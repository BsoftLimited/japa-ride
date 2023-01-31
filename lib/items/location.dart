import 'package:japa/items/item.dart';
import "dart:convert" show json;

class Location extends Item{
    String address;
    double logitute, latitute;

    Location({required this.address, required this.logitute, required this.latitute});
    Location.from(Map<String, dynamic> data):  this(address: data["address"], logitute: data["logitute"], latitute: data["latitute"]);
    Location.parse(String data): this.from(json.decode(data));
}