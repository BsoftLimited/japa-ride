import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:japa/utils/util.dart';
import 'package:location/location.dart';

class OrderTrackingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => __OrderTrackingPageState();
}

class __OrderTrackingPageState extends State<OrderTrackingPage>{
    final Completer<GoogleMapController> __controller = Completer();

    BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
    BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
    BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;

    static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
    static const LatLng destination = LatLng(37.33429383, -122.06600055);

    List<LatLng> polylineCoordinates = [];
    Option<LocationData> currentLocation = Option.none();

    void getPolyPoints() async {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Util.mapAPIKey,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude),
      );
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) =>
            polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
        setState(() {});
      }
    }

    void getCurrentLocation() async{
        Location location = Location();
        location.getLocation().then((value) => { currentLocation = Option.some(value) });
        GoogleMapController googleMapController = await __controller.future;
        location.onLocationChanged.listen((value) { currentLocation = Option.some(value);
            googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(zoom: 13.5, target: LatLng(value.latitude!, value.longitude!))));
            setState(() {});
        });
    }

    void setCustomMakerIcons(){
        BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'res/pin.png').then((value) => { sourceIcon = value });
        BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'res/pin.png').then((value) => { destinationIcon = value });
        BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'res/position.png').then((value) => { currentIcon = value });
    }

    @override
  void initState() {
    getPolyPoints();
    getCurrentLocation();
    setCustomMakerIcons();
    super.initState();
  }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
          body: currentLocation.is_none ? const Center(child: Text("loading"),) : GoogleMap(
            initialCameraPosition: const CameraPosition(target: sourceLocation, zoom: 13.5),
            markers: {
              Marker(markerId: const MarkerId("source"), position: sourceLocation, icon: sourceIcon),
              Marker(markerId: const MarkerId("destination"), position: destination, icon: destinationIcon),
              Marker(markerId: const MarkerId("location"), position: fromCurrent(), icon: currentIcon),
            },
            onMapCreated: (mapController){
              __controller.complete(mapController);
            },
            polylines: { Polyline(
                polylineId:  const PolylineId("route"),
                points: polylineCoordinates, color: const Color.fromARGB(255, 245, 160, 94), width: 6), }
          ),
        );
    }

    LatLng fromCurrent(){
      double lat = currentLocation.value.latitude!;
      double lng = currentLocation.value.longitude!;

      return LatLng(lat, lng);
    }
}