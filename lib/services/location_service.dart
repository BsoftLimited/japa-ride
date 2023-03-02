import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:japa/items/data.dart';
import 'package:japa/services/service.dart';
import 'package:japa/utils/util.dart';

class UpdateLocationService extends Service{
  UpdateLocationService({required super.listener}): super(host: "drivers/update_location.php");
}

class GetLocationService extends Service{
    GetLocationService({required super.listener}): super(host: "drivers/location.php");
}

class LocationService{
    Option<LatLng> currentPosition = Option.none();
    bool isRunning = false;
    late UpdateLocationService updateService;

    LocationService(){
      updateService = UpdateLocationService(
          listener: (bool succeed, String data, String request){
            log(data);
            if(currentPosition.is_some){
              LatLng init = currentPosition.value;
              currentPosition = Option.none();
              updateService.start(params: initRequest(init));
            }else{
              isRunning = false;
            }
          });
    }

    update(LatLng position){
        if(isRunning){
            currentPosition = Option.some(position);
        }else{
            isRunning = true;
            updateService.start(params: initRequest(position));
        }
    }

    Map<String, dynamic> initRequest(LatLng location){
        String id = Data.instance().user.id;
        return { "id" : id, "lat" : location.latitude, "lng" : location.longitude };
    }
}