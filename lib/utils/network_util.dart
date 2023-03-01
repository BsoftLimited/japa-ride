import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:japa/utils/util.dart';

class PolylineDetail{
    Polyline polyline;
    double distance;

    PolylineDetail({ required this.polyline, required this.distance });
}

class NetworkUtil{
    static Future<String?> fetchUri(Uri uri, {Map<String, String>? headers}) async{
        try{
          final response = await http.get(uri, headers: headers);
          if(response.statusCode == 200){
            return response.body;
          }
        }catch(e){
          debugPrint(e.toString());
        }
        return null;
    }

    static Future<LatLng?> fetchPlaceDetails(String placeID) async{
        Uri uri = Uri.https("maps.googleapis.com", "maps/api/place/details/json", { "place_id" : placeID, "key" : Util.mapAPIKey, "fields" : ["geometry"] });
        String? response = await NetworkUtil.fetchUri(uri);
        //log(" fet lat and long res - ${response}");
        if(response != null) {
          final result = json.decode(response);
          return LatLng(result["result"]["geometry"]["location"]["lat"],
              result["result"]["geometry"]["location"]["lng"]);
        }
    }

    static Future<PolylineDetail> initPolyline({ required LatLng start, required LatLng destination, required String name, required, required Color color }) async{
        List<LatLng> polylineCoordinates = [];
        PolylinePoints polylinePoints = PolylinePoints();
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
            Util.mapAPIKey,
            PointLatLng(start.latitude, start.longitude),
            PointLatLng(destination.latitude, destination.longitude),
        );

        if (result.points.isNotEmpty) {
            for (var point in result.points) {
                polylineCoordinates.add(LatLng(point.latitude, point.longitude));
            }
        }

        double totalDistance = 0;
        for(var i = 0; i < polylineCoordinates.length-1; i++){
            totalDistance += Util.calculateDistance(polylineCoordinates[i], polylineCoordinates[i+1]);
        }

        Polyline line = Polyline( polylineId: PolylineId(name), color: color, points: polylineCoordinates );
        return PolylineDetail(polyline: line, distance: totalDistance);
    }

    static Future<List<PolylineDetail>> initPolyLines({ required LatLng currentLocation, required LatLng start, required LatLng destination}) async{
        PolylineDetail toPickup = await initPolyline(start: currentLocation, destination: start, name: "rendezvous", color: Colors.lightBlue);
        PolylineDetail toDestination = await initPolyline(start: start, destination: destination, name: "trip", color: const Color.fromARGB(255, 245, 160, 94));

        return [toPickup, toDestination];
    }
}