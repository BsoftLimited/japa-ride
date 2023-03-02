import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:japa/items/data.dart';
import 'package:japa/services/drivers_service.dart';
import 'package:japa/services/location_service.dart';
import 'package:japa/utils/util.dart';

class DriversPanel extends StatefulWidget{
    final void Function(String username) onDriverSelected;

    const DriversPanel({super.key, required this.onDriverSelected});

    @override
    State<StatefulWidget> createState() => __DriversPanel();
}

class __DriversPanel extends State<DriversPanel>{
    bool isLoading = false;
    List<dynamic> drivers = [];
    
    @override
    void initState() {
        isLoading = false;
        super.initState();
        DriversService(listener: (succeed, response, request){
            if(succeed){
                drivers = json.decode(response)["drivers"];
                setState(() { isLoading = true; });
            }
        });
    }
    
    Widget initVIew(dynamic item){
        LatLng driverLocation = LatLng(item.lat, item.lng);
        LatLng myLocation = LatLng(Data.instance().currentLocation.value.latitude!, Data.instance().currentLocation.value.longitude!)
        double distance = Util.calculateDistance(driverLocation, myLocation);
        return Container(
            padding: const EdgeInsets.all(10),
            child: TextButton(
                child: Row(
                    children: [
                        CircleAvatar(radius: 80,child: Image.asset("res/profile.png"),),
                        const SizedBox(width: 10,),
                        Column(children: [
                            Text("${item.name} ${item.surname}", style: const TextStyle(color: Colors.black38, fontSize: 18, fontWeight: FontWeight.w400),),
                            const SizedBox(height: 5,),
                            Text("${item.details.phone}", style: const TextStyle(color: Colors.black38, fontSize: 14, fontWeight: FontWeight.w400),),
                            const SizedBox(height: 5,),
                            Text("${item.vehicle_type}", style: const TextStyle(color: Colors.black38, fontSize: 12, fontWeight: FontWeight.w400),),
                            const SizedBox(height: 5,),
                            Text("Ratings: ${ Util.getStars(5) }", style: const TextStyle(color: Colors.black38, fontSize: 18, fontWeight: FontWeight.w400),),
                            const SizedBox(height: 5,),
                            Text("${distance.ceil() } km away", style: const TextStyle(color: Colors.black38, fontSize: 14, fontWeight: FontWeight.w400),),
                          ],
                        ),
                         
                    ],
                ),
                onPressed: (){ widget.onDriverSelected(item.username as String); },),
        );
    }
    
    Widget loading(){
        return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
            SpinKitFoldingCube(color: Color.fromARGB(255, 245, 160, 94), size: 36,),
            SizedBox(height: 18),
            Text("getting drivers close to you, please wait..", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, letterSpacing: 1.5, fontSize: 12),),
      ],),);
    }
  
    @override
    Widget build(BuildContext context) {
        return IndexedStack(
          index: isLoading ? 0 : 1,
          children: [ 
              loading(), 
              Column(children: List<Widget>.generate(drivers.length, (index){ return initVIew(drivers[index]); }),)
          ],);
    }
}