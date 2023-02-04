import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pinput/pinput.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TopButton extends StatefulWidget{
  String text;
  Function() click;
  TopButton({required this.text, required this.click});

  @override
  State<StatefulWidget> createState() => __TopButtonState();
}

class __TopButtonState extends State<TopButton>{
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.click, style: ElevatedButton.styleFrom(
            primary: Colors.white,
            side: BorderSide(width:1, color: const Color.fromARGB(255, 245, 160, 94)), //border width and color
            elevation: 3, //elevation of button
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(20) //content padding inside button
        ),
        child: Row(children: [
          Icon(Icons.location_on, size: 14, color: const Color.fromARGB(255, 245, 160, 94),),
          Text(widget.text, style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 245, 160, 94)),)],));
  }
}

class Map extends StatefulWidget {
  @override
  __MapState createState() => __MapState();
}

class __MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  late TextEditingController __searchController;
  late PanelController __panelController;
  int __searchIndex = 0;

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
      __searchController.setText(value);
      if(__panelController.isPanelClosed){
        __panelController.open();
      }
  }

  @override
  void initState() {
    __searchController = TextEditingController();
    __searchController.addListener(() {
      if(__searchController.value.text.isNotEmpty && __searchIndex == 0){
        setState(() { __searchIndex = 1; });
      }else if(__searchController.value.text.isEmpty && __searchIndex == 1){
        setState(() { __searchIndex = 0; });
      }
    });
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
                          TopButton(click: ()=>top_clicked("Home"), text: "Home"),
                          SizedBox(width: 8,),
                          TopButton(click: ()=>top_clicked("Office"), text: "Office"),
                          SizedBox(width: 8,),
                          TopButton(click: ()=>top_clicked("Markets"), text: "Markets"),
                          SizedBox(width: 8,),
                          TopButton(click: ()=>top_clicked("Resturants"), text: "Resturants"),
                          SizedBox(width: 8,),
                          TopButton(click: ()=>top_clicked("Hotels"), text: "Hotels"),
                          SizedBox(width: 8,),
                          TopButton(click: ()=>top_clicked("Schools"), text: "Schools"),
                          SizedBox(width: 8,),
                          TopButton(click: ()=>top_clicked("Clubs"), text: "Clubs"),
                          SizedBox(width: 8,),
                          TopButton(click: ()=>top_clicked("Bars"), text: "Bars"),
                        ],),
                      ),
                    ),
                    SizedBox(height: 5,),
                    IconButton(iconSize: 20, onPressed: __goToMe, icon: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 245, 160, 94),
                        child: Icon(Icons.location_searching_sharp, color: Colors.white, size: 14,))),
                  ],
                ),
              ],
          ),
        collapsed: Container(
            alignment: Alignment.topCenter, padding: EdgeInsets.only(top: 3),
            child: SizedBox(width: 40, height: 5, child: Divider(color: Colors.black54, thickness: 2,),)),
        panel: Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 12),
            child: Column(
              children: [
                TextField(
                  style: TextStyle( fontSize: 14), controller: __searchController,
                  onTap: (){ __panelController.open(); }, onTapOutside: (event){ __panelController.close(); },
                  decoration: InputDecoration(
                      hintText: "Where do you want to go to ?",
                      prefixIcon: Icon(Icons.search, size: 18,),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
                SizedBox(height: 8,),
                IndexedStack(
                  index: __searchIndex,
                  children: [
                    Center(child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(children: [
                          Image.asset("res/location_search.png", width: 180, height: 200,),
                          SizedBox(height: 5,),
                          Text("No Search Made", style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.2, fontSize: 18, color: Colors.black54)),
                      ]),
                    )),
                    Center(child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(children: [
                        Image.asset("res/no_data.png", width: 150, height: 200,),
                        SizedBox(height: 5,),
                        Text("No Search result found", style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.2, fontSize: 18, color: Colors.black54)),
                      ]),
                    ))
                  ],),
              ],
            ),
        ),
    );
  }

  Future<void> __goToMe() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }
}
