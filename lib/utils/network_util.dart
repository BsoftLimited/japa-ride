import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:japa/utils/util.dart';

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
        if(response != null) {
          final result = json.decode(response);
          return LatLng(double.parse(result["geometry"]["lat"]),
              double.parse(result["geometry"]["lng"]));
        }
    }
}