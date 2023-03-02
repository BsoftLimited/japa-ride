import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:japa/components/panel.dart';
import 'package:japa/utils/network_util.dart';
import 'package:japa/utils/util.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum Mode{ Select, Search }

class TopButton extends StatelessWidget{
  final String text;
  final Function() click;
  final IconData icon;
  const TopButton({super.key, required this.icon, required this.text, required this.click});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: click, style: ElevatedButton.styleFrom(
            primary: Colors.white,
            side: const BorderSide(width:1, color: Color.fromARGB(255, 245, 160, 94)), //border width and color
            elevation: 3, //elevation of button
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(10) //content padding inside button
        ),
        child: Row(children: [
          Icon(icon, size: 18, color: const Color.fromARGB(255, 245, 160, 94),),
          const SizedBox(width: 2),
          Text(text, style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 245, 160, 94)),)],));
  }
}

class CircleButton extends StatelessWidget{
    final Function() onPressed;
    final IconData icon;

    const CircleButton({super.key, required this.onPressed, required this.icon});

    @override
    Widget build(BuildContext context) {
        return MaterialButton(onPressed: onPressed, color:  const Color.fromARGB(255, 245, 160, 94),
            padding: const EdgeInsets.all(12), shape: const CircleBorder(), minWidth: 20,
            child: Icon( icon, color: Colors.white, size: 18,));
    }
}

class CircleToggleButton extends StatelessWidget{
  final Function() onPressed;
  final IconData icon;
  final bool active;

  const CircleToggleButton({super.key, required this.onPressed, required this.icon, required this.active});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: onPressed, color: active ?  Colors.white : const Color.fromARGB(255, 245, 160, 94),
        padding: const EdgeInsets.all(12), shape: const CircleBorder(), minWidth: 20,
        child: Icon( icon, color: active ? const Color.fromARGB(255, 245, 160, 94) :  Colors.white , size: 18,));
  }
}

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => __MapState();
}

class __MapState extends State<Map> {
  final Completer<GoogleMapController> __controller = Completer();
  final PanelController __panelController = PanelController();
  BPanelController bPanelController = BPanelController();

  Option<LatLng> destination = Option.none(), start = Option.none();
  Set<Polyline> polylines = Set();
  Option<LocationData> currentLocation = Option.none();
  Option<CameraPosition> cameraPosition = Option.none();

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;
  String? mapStyle;
  double distance = 0;
  bool track = false;

  final double TRACKING_CAMERA_TILT = 85;
  final double TRACKING_CAMERA_BEARING = 30;
  late double default_camera_tilt, default_camera_bearing;

  Location location = new Location();

  void getPolyPoints() async {
      List<LatLng> polylineCoordinates = [];
      if(start.is_some && destination.is_some){
          List<PolylineDetail> lines = await NetworkUtil.initPolyLines(currentLocation: fromCurrent()!, start: start.value, destination: destination.value);
          setState(() {
             polylines.add(lines[0].polyline);
             polylines.add(lines[1].polyline);
             distance = lines[1].distance;
          });
      }
  }
  Future<void> getCurrentLocation() async{
        bool isEnabled =  await location.serviceEnabled();
        while(!isEnabled){
            isEnabled = await location.requestService();
        }

        PermissionStatus permissionGranted = await location.hasPermission();
        while(permissionGranted == PermissionStatus.denied){
            permissionGranted = await location.requestPermission();
        }

        LocationData locationData =  await location.getLocation();
        currentLocation = Option.some(locationData);
        log("I got your location");
        cameraPosition = Option.some(CameraPosition(target: LatLng(locationData.latitude!, locationData.longitude!), zoom: 16.0));
        default_camera_bearing = cameraPosition.value.bearing;
        default_camera_tilt = cameraPosition.value.tilt;

        setState(() {});

        GoogleMapController googleMapController = await __controller.future;
        location.onLocationChanged.listen((value) {
            setState(() {
              currentLocation = Option.some(value);
              if(track){
                googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                        CameraPosition(zoom: cameraPosition.value.zoom, tilt: TRACKING_CAMERA_TILT, bearing: TRACKING_CAMERA_TILT, target: LatLng(value.latitude!, value.longitude!))));
              }else{
                cameraPosition = Option.some(CameraPosition(target: LatLng(value.latitude!, value.longitude!),
                    tilt: default_camera_tilt, bearing: default_camera_bearing, zoom: cameraPosition.value.zoom));
              }
            });
        });
  }

  void setCustomMakerIcons(){
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'res/pin.png').then((value) => { sourceIcon = value });
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'res/location_checked.png').then((value) => { destinationIcon = value });
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'res/location_persion.png').then((value) => { currentIcon = value });
  }

  void top_clicked(String value){
      if(__panelController.isPanelClosed){
        __panelController.open();
      }
  }

  @override
  void initState() {
      super.initState();
      track = false;
      getCurrentLocation();
      setCustomMakerIcons();
  }

  Set<Marker> initMarkers(){
      Set<Marker> init = {};
      init.add(Marker(markerId: const MarkerId("location"), position: fromCurrent()!, icon: currentIcon));
      if(start.is_some && destination.is_some){
          getPolyPoints();
          init.add(Marker(markerId: const MarkerId("source"), position: start.value, icon: sourceIcon));
          init.add(Marker(markerId: const MarkerId("destination"), position: destination.value, icon: destinationIcon),);
      }
      return init;
  }

  Widget initMap(){
    if(currentLocation.is_none){
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
          SpinKitFoldingCube(color: Color.fromARGB(255, 245, 160, 94), size: 36,),
          SizedBox(height: 18),
          Text("loading Map, please wait..", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, letterSpacing: 1.5, fontSize: 12),),
      ],),);
    }else{
      return GoogleMap(
          mapType: start.is_some && destination.is_some ? MapType.terrain : MapType.normal,
          initialCameraPosition: cameraPosition.value,
          onMapCreated: (GoogleMapController controller) { __controller.complete(controller); },
          markers: initMarkers(),
          polylines: polylines
          /*onCameraMove: (CameraPosition position) {
            Provider.of<MapProvider>(context, listen: false).updateCurrentLocation(
              LatLng(position.target.latitude, position.target.longitude));},*/
      );
    }
  }

  void clear(){
      setState(() {
          start = Option.none();
          destination = Option.none();
          polylines.clear();
          distance = 0;
      });
  }

  Widget __initExtra(){
      if(start.is_some && destination.is_some){
        return Column(children: [
          const SizedBox(height: 10,),
          CircleToggleButton(active: track, onPressed: (){ setState(() {
            track = !track;
          }); }, icon: Icons.track_changes,),
        ]);
      }
      return SizedBox(height: 0,);
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      minHeight: 70, backdropEnabled: true, controller: __panelController,
      onPanelClosed: (){ log("closed at ${__panelController.panelPosition}"); setState(() { }); },
        //onPanelOpened: (){ log("opened at ${__panelController.panelPosition}"); setState(() { __isOpened = true; }); },
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      body: Stack(
              children:[
                initMap(),
                Column( crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          TopButton(click: ()=>top_clicked("Home"), text: "Home", icon: Icons.home_outlined,),
                          const SizedBox(width: 8,),
                          TopButton(click: ()=>top_clicked("Markets"), text: "Markets", icon: Icons.shopping_cart_outlined,),
                          const SizedBox(width: 8,),
                          TopButton(click: ()=>top_clicked("Resturants"), text: "Resturants", icon: Icons.restaurant_menu_outlined,),
                          const SizedBox(width: 8,),
                          TopButton(click: ()=>top_clicked("Bars"), text: "Bars", icon: Icons.wine_bar),
                          const SizedBox(width: 8,),
                          TopButton(click: ()=>top_clicked("Schools"), text: "Schools", icon: Icons.school_outlined,),
                        ],),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column( mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleButton(onPressed: (){ bPanelController.openLocate(); }, icon: Icons.bookmarks_outlined),
                          const SizedBox(height: 10,),
                          CircleButton(onPressed: (){ bPanelController.openSearch(); }, icon: Icons.search_outlined,),
                          const SizedBox(height: 10,),
                          CircleButton(onPressed: __goToMe, icon: Icons.location_searching_sharp,),
                          __initExtra(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
          ),
        collapsed: Container(
            alignment: Alignment.topCenter, padding: const EdgeInsets.only(top: 3),
            child: const SizedBox(width: 40, height: 5, child: Divider(color: Colors.black54, thickness: 2,),)),
        panel: Panel(currentLocation: fromCurrent(), panelController: __panelController, bPanelController: bPanelController, distance: distance, showRoute: (loct, dest) {
            setState(() {
              start = Option.some(loct.latLng);
              destination = Option.some(dest.latLng);
              track = true;
            });
        }
    ,),
    );
  }

  LatLng? fromCurrent(){
    if(currentLocation.is_some){
      double lat = currentLocation.value.latitude!;
      double lng = currentLocation.value.longitude!;
      return LatLng(lat, lng);
    }
  }

  Future<void> __goToMe() async {
    if(cameraPosition.is_some){
      final GoogleMapController controller = await __controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition.value));
    }
  }
}
