import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:japa/items/item.dart';
import "dart:convert" show json;

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CustonLocation extends Item{
    String name, address;
    LatLng latLng;

    CustonLocation({required this.address, required this.name, required this.latLng});
}