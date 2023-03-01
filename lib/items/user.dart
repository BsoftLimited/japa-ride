import "dart:convert" show json;
import 'dart:developer';
import "package:japa/items/item.dart";
import 'package:japa/items/location.dart';
import 'package:json_annotation/json_annotation.dart';

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
    
    Client(Map<String, dynamic> data):
            super(
            id: data["id"] as String, name: data["name"] as String,
            surname: data["surname"] as String, username: data["username"] as String,
            phone: data["phone"] as String, email: data["email"] as String){

    }
}

@JsonSerializable()
class Driver extends User{
    late String vehicle, opening, closing, status;

    Driver(Map<String, dynamic> data):
            super(
                id: data["id"] as String, name: data["name"] as String,
                surname: data["surname"] as String, username: data["username"] as String,
                phone: data["phone"] as String, email: data["email"] as String){
        vehicle = data["vehicle"] as String;
        opening = data["start"] as String;
        closing = data["end"] as String;
        status = data["status"] as String;
    }

    Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id, 'name': name, 'surname' : surname, "phone" : phone,
        "email" : email, "vehicle" : vehicle, "start" : opening,
        "end" : closing, "status" : status
    };
}