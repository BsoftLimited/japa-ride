import 'dart:async';
import 'dart:developer';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:japa/providers/map_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:japa/components/panel.dart';
import 'package:japa/utils/util.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum Mode{ Select, Search }

class TopButton extends StatelessWidget{
  String text;
  Function() click;
  IconData icon;
  TopButton({required this.icon, required this.text, required this.click});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: click, style: ElevatedButton.styleFrom(
            primary: Colors.white,
            side: BorderSide(width:1, color: const Color.fromARGB(255, 245, 160, 94)), //border width and color
            elevation: 3, //elevation of button
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(10) //content padding inside button
        ),
        child: Row(children: [
          Icon(icon, size: 18, color: const Color.fromARGB(255, 245, 160, 94),),
          SizedBox(width: 2),
          Text(text, style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 245, 160, 94)),)],));
  }
}

class CircleButton extends StatelessWidget{
    Function() onPressed;
    IconData icon;

    CircleButton({required this.onPressed, required this.icon});

    @override
    Widget build(BuildContext context) {
        return MaterialButton(onPressed: this.onPressed, color:  const Color.fromARGB(255, 245, 160, 94),
            padding: EdgeInsets.all(12), shape: CircleBorder(), minWidth: 20,
            child: Icon( icon, color: Colors.white, size: 18,));
    }
}

class Map extends StatefulWidget {
  @override
  __MapState createState() => __MapState();
}

class __MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  late PanelController __panelController = PanelController();
  BPanelController bPanelController = BPanelController();

  LocationData? __currentLocation;
  CameraPosition? __cameraPosition;
  BitmapDescriptor? clientBitmap;
  String? mapStyle;

  Future<void> __getCurrentLocation() async {
    Location location = Location();
    try {
      LocationData currentLocation = await location.getLocation();
      if(currentLocation != null) {
        __currentLocation = currentLocation;
        __cameraPosition = CameraPosition(target: LatLng( currentLocation.latitude!, currentLocation.longitude!), zoom: 16.0);
        setState(()=>{});
      }

    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
  }

  void top_clicked(String value){
      if(__panelController.isPanelClosed){
        __panelController.open();
      }
  }

  @override
  void initState() {
      BitmapDescriptor.fromAssetImage( ImageConfiguration(size: Size(48, 48)), 'res/location.png').then((onValue) { clientBitmap = onValue;});
      SchedulerBinding.instance?.addPostFrameCallback((_) {
          rootBundle.loadString(FileConstants.mapStyle).then((string) { mapStyle = string; });
      });
      __getCurrentLocation();
      super.initState();
  }

  Future<Set<Marker>> generateMarkers(List<LatLng> positions) async {
      List<Marker> markers = <Marker>[];
      for (final location in positions) {
          final icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(24, 24)), 'assets/location.png');

          final marker = Marker(
              markerId: MarkerId(location.toString()),
              position: LatLng(location.latitude, location.longitude),
              icon: icon,
          );
          markers.add(marker);
    }
    return markers.toSet();
  }

  Set<Marker> initMarker(LocationData locationData){
      Set<Marker> markers = Set();
      markers.add(Marker(
          markerId: MarkerId("current location"),
          position: LatLng(locationData.latitude!, locationData.longitude!),
          infoWindow: InfoWindow(title: "Your Location"),
          icon: clientBitmap == null ? BitmapDescriptor.defaultMarker : (clientBitmap as BitmapDescriptor) ));
      return markers;
  }

  Widget initMap(){
    if(__currentLocation == null){
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SpinKitFoldingCube(color: Color.fromARGB(255, 245, 160, 94),),
        SizedBox(height: 20),
        Text("loading Map, please wait..", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, letterSpacing: 1.5, fontSize: 14),),
      ],),);
    }else{
      CameraPosition cameraPosition = __cameraPosition as CameraPosition;
      return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: cameraPosition,
          onMapCreated: (GoogleMapController controller) { _controller.complete(controller); },
          markers: initMarker(__currentLocation as LocationData),
          onCameraMove: (CameraPosition position) {
            Provider.of<MapProvider>(context, listen: false).updateCurrentLocation(
              LatLng(position.target.latitude, position.target.longitude));
          },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      minHeight: 70, backdropEnabled: true, controller: __panelController,
      onPanelClosed: (){ log("closed at ${__panelController.panelPosition}"); setState(() { }); },
        //onPanelOpened: (){ log("opened at ${__panelController.panelPosition}"); setState(() { __isOpened = true; }); },
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                          SizedBox(width: 8,),
                          TopButton(click: ()=>top_clicked("Markets"), text: "Markets", icon: Icons.shopping_cart_outlined,),
                          SizedBox(width: 8,),
                          TopButton(click: ()=>top_clicked("Resturants"), text: "Resturants", icon: Icons.restaurant_menu_outlined,),
                          SizedBox(width: 8,),
                          TopButton(click: ()=>top_clicked("Bars"), text: "Bars", icon: Icons.wine_bar),
                          SizedBox(width: 8,),
                          TopButton(click: ()=>top_clicked("Schools"), text: "Schools", icon: Icons.school_outlined,),
                          SizedBox(width: 8,),
                          TopButton(click: ()=>top_clicked("Banks"), text: "Banks", icon: Icons.monetization_on_outlined,),
                        ],),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column( mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleButton(onPressed: (){ bPanelController.openLocate(); }, icon: Icons.bookmarks_outlined),
                          SizedBox(height: 10,),
                          CircleButton(onPressed: (){ bPanelController.openSearch(); }, icon: Icons.search_outlined,),
                          SizedBox(height: 10,),
                          CircleButton(onPressed: __goToMe, icon: Icons.location_searching_sharp,),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
          ),
        collapsed: Container(
            alignment: Alignment.topCenter, padding: EdgeInsets.only(top: 3),
            child: SizedBox(width: 40, height: 5, child: Divider(color: Colors.black54, thickness: 2,),)),
        panel: Panel(currentLocation: initCurrentLocation(), panelController: __panelController, bPanelController: bPanelController,),
    );
  }

  LatLng? initCurrentLocation(){
      if(__currentLocation != null) {
        LocationData locationData = __currentLocation as LocationData;
        return LatLng(locationData.latitude!, locationData.longitude!);
      }
  }

  Future<void> __goToMe() async {
    if(__cameraPosition != null){
      final GoogleMapController controller = await _controller.future;
      CameraPosition cameraPosition = __cameraPosition as CameraPosition;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }
}
