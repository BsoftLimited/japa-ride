import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:japa/components/panel.dart';
import 'package:japa/components/vehicle_type.dart';
import 'package:japa/items/location.dart';
import 'package:japa/items/time.dart';

class DriverDetails{
  late String name, surname, username;

  DriverDetails.from(Map<String, dynamic> data){
    this.name = data["name"];
    this.surname = data["surname"];
    this.username = data["username"];
  }
}

class DriverRespose{
  late String vehicle;
  late CustomTime start, end;
  late DriverDetails details;

  DriverRespose.parse(String data){
    Map<String, dynamic> init = json.decode(data);
    this.vehicle = init["vehicle"];
    this.start = CustomTime.parse(init["start"]);
    this.end = CustomTime.parse(init["end"]);
    this.details = DriverDetails.from(init["details"]);
  }
}

class BookingPanel extends StatefulWidget{
    final CustonLocation?  location, destination;
    Function(Selecting) search;
    double distance;

    BookingPanel({super.key,required this.search, this.location, this.destination, required this.distance});

    @override
    State<StatefulWidget> createState() => BookingPanelState();
}

class BookingPanelState extends State<BookingPanel>{
    Selecting __selecting = Selecting.Location;
    String vehicleType = '';
    bool loadiing = true;

    void onVehicleChange(String? value){
        setState(() { vehicleType = value!; });
    }

    Widget booking(){
        return Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("Distance", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black45, letterSpacing: 1.4),),
              Text("${ widget.distance.ceil() } km", style: TextStyle(fontSize: 12, color: Colors.black45),),
            ],),
          ),
          Expanded(child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Divider(),
              SizedBox(height: 10,),
              Text("Select the desired Vehicle Type:", style:  TextStyle(fontSize: 12, color: Colors.black45, fontWeight: FontWeight.bold), ),
              SizedBox(height: 8,),
              VehicleType(icon: Icons.motorcycle_outlined, title: "Bike", count: 0, amount: 0, onClick: onVehicleChange, groupValue: vehicleType,),
              VehicleType(icon: Icons.local_taxi_outlined, title: "Taxi", count: 0, amount: 0, onClick: onVehicleChange, groupValue: vehicleType,),
              VehicleType(icon: Icons.directions_bus_outlined, title: "Bus", count: 0, amount: 0, onClick: onVehicleChange, groupValue: vehicleType,),
              VehicleType(icon: Icons.directions_bus_sharp, title: "Long Bus", count: 0, amount: 0, onClick: onVehicleChange, groupValue: vehicleType,),
              Divider(),
              Container(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                      onPressed: (){}, textColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 6),
                      child: Row(mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.car_crash_outlined, size: 14,), SizedBox(width: 6,), Text("Proceed", style: TextStyle(fontSize: 12),),
                        ],
                      ), color: const Color.fromARGB(255, 245, 160, 94) //c
                  ),
                ),
              ),
            ],),))
        ],);
    }

    Widget loading(){
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
          SpinKitFoldingCube(color: Color.fromARGB(255, 245, 160, 94), size: 36,),
          SizedBox(height: 18),
          Text("loading, please wait..", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, letterSpacing: 1.5, fontSize: 12),),
      ],),);
    }

    Widget initMain(){
      if(widget.location != null && widget.destination != null){
          if(loadiing){
            return loading();
          }else{
            return booking();
          }
      }
      return Container();
    }

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 4),
                child: Text("Select Adress", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black45),),
              ),
            ),
            Divider(thickness: 0.6,),
            Row(children: [
              Icon(Icons.location_history_outlined, color: const Color.fromARGB(255, 245, 160, 94), ),
              SizedBox(width: 5,),
              Expanded(child: OutlinedButton(
                style:  OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text( widget.location == null ? "Current Loaction" : widget.location!.name, style: TextStyle( fontSize: 14, color: Colors.black45),),
                ),
                onPressed: (){
                    widget.search(Selecting.Location);
                },
              ),)
            ],),
            SizedBox(height: 20, width: 24, child: VerticalDivider(width: 20, thickness: 1, color: const Color.fromARGB(255, 245, 160, 94),)),
            Row(children: [
              Icon(Icons.location_on_outlined, color: const Color.fromARGB(255, 245, 160, 94), ),
              SizedBox(width: 5,),
              Expanded(child: OutlinedButton(
                style:  OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(widget.destination == null ? "Destination" : widget.destination!.name, style: TextStyle( fontSize: 14, color: Colors.black45),),
                ),
                onPressed: (){
                    widget.search(Selecting.Destination);
                },
              ),)
            ],),
            Divider(),
            Expanded(child: initMain())
          ],
        ),
      );
    }
}