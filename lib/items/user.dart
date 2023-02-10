import "dart:convert" show json;
import 'dart:developer';
import "package:japa/items/item.dart";
import 'package:japa/items/location.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'vehicle')
enum Vehicle{
    Car("car"), Bus("bus"), Tricycle("tricycle");

    const Vehicle(this.vehicle);
    final String vehicle;
}

@JsonEnum(valueField: 'status')
enum DriverStatus{
    Available("available"), Busy("busy"), Resting("resting"), Closed("closed");

    final String status;
    const DriverStatus(this.status);
}

abstract class User extends Item{
    String id, name, surname, username, phone, email;

    User({required this.id, required this.name, required this.surname, required this.username, required this.phone, required this.email});
}

User UserParse(String data){
    Map<String, dynamic> init = json.decode(data) as  Map<String, dynamic>;
    return UserFrom(init);
}

User UserFrom(Map<String, dynamic> data){
    if(data["user_type"] == 'driver'){
        return Driver(data);
    }
    return Client(data);
}

@JsonSerializable()
class Client extends User{
    Location? home, work;
    
    Client(Map<String, dynamic> data):
            super(
            id: data["id"] as String, name: data["name"] as String,
            surname: data["surname"] as String, username: data["username"] as String,
            phone: data["phone"] as String, email: data["email"] as String){
        if(data.containsKey("home")){
            home = Location.from(data["home"]);
        }

        if(data.containsKey("work")){
          work = Location.from(data["work"]);
        }
    }
}

@JsonSerializable()
class Driver extends User{
    late Vehicle vehicle;
    late double rate;
    late DateTime opening, closing;
    late DriverStatus status;

    Driver(Map<String, dynamic> data):
            super(
                id: data["id"] as String, name: data["name"] as String,
                surname: data["surname"] as String, username: data["username"] as String,
                phone: data["phone"] as String, email: data["email"] as String){
        vehicle = data[vehicle];
        rate = double.parse(data["rate"] as String);
        opening = DateTime.parse(data["opening"] as String);
        closing = DateTime.parse(data["closing"] as String);
        status = data[status];
    }

    Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id, 'name': name, 'surname' : surname, "phone" : phone,
        "email" : email, "vehicle" : vehicle.vehicle, "rate" : rate, "opening" : opening.toString(),
        "closing" : closing.toString(), "status" : status.status
    };
}