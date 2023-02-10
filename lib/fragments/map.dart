import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:japa/components/panel.dart';
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
            padding: EdgeInsets.all(20) //content padding inside button
        ),
        child: Row(children: [
          Icon(icon, size: 14, color: const Color.fromARGB(255, 245, 160, 94),),
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
            padding: EdgeInsets.all(14), shape: CircleBorder(), minWidth: 20,
            child: Icon( icon, color: Colors.white, size: 18,));
    }
}

class Map extends StatefulWidget {
  @override
  __MapState createState() => __MapState();
}

class __MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  late PanelController __panelController;
  BPanelController bPanelController = BPanelController();

  static final CameraPosition _kGooglePlex = CameraPosition( target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746);
  LocationData? _currentLocation;
  var location = new Location();

  Future<void> _getCurrentLocation() async {
    try {
      _currentLocation = await location.getLocation();
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    setState(() {});
  }

  void top_clicked(String value){
      if(__panelController.isPanelClosed){
        __panelController.open();
      }
  }

  @override
  void initState() {
    __panelController = PanelController();
    super.initState();
    _getCurrentLocation();
  }

  Set<Marker> initMarker(){
    Set<Marker> markers = Set();
    if(_currentLocation != null){
       markers.add(Marker(
          markerId: MarkerId("curr_loc"),
          position: LatLng(_currentLocation?.latitude as double, _currentLocation?.longitude as double),
          infoWindow: InfoWindow(title: "Your Location"),
          icon: BitmapDescriptor.defaultMarker));
    }
    return markers;
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
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) { _controller.complete(controller); },
                  markers: initMarker()),
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
        panel: Panel(currentLocation: initCurrentLoaction(), panelController: __panelController, bPanelController: bPanelController,),
    );
  }

  LatLng? initCurrentLoaction(){
      if( _currentLocation != null ){
        return LatLng(_currentLocation?.latitude as double, _currentLocation?.longitude as double);
      }
  }

  Future<void> __goToMe() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }
}
