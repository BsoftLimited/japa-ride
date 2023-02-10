import 'package:japa/items/item.dart';
import "dart:convert" show json;

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Location extends Item{
    String address;
    double logitute, latitute;

    Location({required this.address, required this.logitute, required this.latitute});
    Location.from(Map<String, dynamic> data):  this(address: data["address"] as String, logitute: double.parse(data["logitute"]), latitute: double.parse(data["latitute"]));
    Location.parse(String data): this.from(json.decode(data) as Map<String, dynamic>);
}