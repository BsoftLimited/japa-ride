import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:japa/utils/util.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';

class MapSearch extends StatefulWidget{
  final LatLng? currentLocation;

  MapSearch({super.key, this.currentLocation});


  @override
  State<StatefulWidget> createState() => MapSearchState();
}
class MapSearchState extends State<MapSearch>{
  @override
  Widget build(BuildContext context) {
    String location;

    return  Scaffold(
        appBar: AppBar(title: const Text("Location Search", style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 245, 160, 94), fontWeight: FontWeight.w400, letterSpacing: 1.3)),
          leading: Row(
            children: [
              Icon(Icons.arrow_back, size: 26, color: const Color.fromARGB(255, 245, 160, 94),),
              SizedBox(width: 8,),
              IconButton(icon: Icon(Icons.not_listed_location_outlined,), iconSize: 26, color: const Color.fromARGB(255, 245, 160, 94), onPressed: (){
                  Navigator.pop(context, null);
              },),
            ],
          ),
          leadingWidth: 70,
          backgroundColor: Colors.white, elevation: 1,),
        body: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
                child: SearchMapPlaceWidget(
                    bgColor: Colors.white, textColor: const Color.fromARGB(255, 245, 160, 94), iconColor: const Color.fromARGB(255, 245, 160, 94),
                    apiKey: Util.mapAPIKey, language: 'en', location: widget.currentLocation,
                    radius: widget.currentLocation == null ? null : 30000,
                    onSelected: (Place place) async { Navigator.pop(context, place); },
                ),
              ),
            ),
          ],
        )
    );
  }
  
}