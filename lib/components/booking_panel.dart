import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:japa/components/panel.dart';
import 'package:japa/components/vehicle_type.dart';
import 'package:japa/screens/map_search.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';

class BookingPanel extends StatefulWidget{
    final LatLng? currentLocation;
    Function(Selecting) search;

    BookingPanel({super.key,required this.search,  this.currentLocation});

    @override
    State<StatefulWidget> createState() => BookingPanelState();
}

class BookingPanelState extends State<BookingPanel>{
    Selecting __selecting = Selecting.Location;
    Place? __location, __destination;
    String vehicleType = '';

    Future<void> __toSearchScreen(BuildContext context) async {
      Place result = await Navigator.push(context, MaterialPageRoute(builder: (context) => MapSearch(currentLocation: widget.currentLocation,)));
      if (!mounted) return;


      setState(() {
          if(__selecting == Selecting.Location) {
              __location = result;
          }else{
              __destination = result;
          }

          if(__location != null && __destination != null){}
      });
    }

    void onVehicleChange(String? value){
        setState(() { vehicleType = value!; });
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
                  child: Text(__location == null ? "Current Loaction" : __location?.description as String, style: TextStyle( fontSize: 14, color: Colors.black45),),
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
                  child: Text(__destination == null ? "Destination" : __destination?.description as String, style: TextStyle( fontSize: 14, color: Colors.black45),),
                ),
                onPressed: (){
                    widget.search(Selecting.Destination);
                },
              ),)
            ],),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text("Distance", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black45, letterSpacing: 1.4),),
                Text("0 km", style: TextStyle(fontSize: 12, color: Colors.black45),),
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
          ],
        ),
      );
    }
}