import 'dart:convert';

import 'package:japa/items/item.dart';
import 'package:japa/items/location.dart';
import 'package:japa/items/user.dart';

class Client extends Item{
    late User user;
    Location? home, work;

    Client({required this.user, this.home, this.work});
    Client.from(Map<String, dynamic> data){
        this.user = User.from(data["user"]);
        if(data.containsKey("home")){
            this.home = Location.from(data["home"]);
        }

        if(data.containsKey("work")){
          this.work = Location.from(data["work"]);
        }
    }

    Client.parse(String data): this.from(json.decode(data));
}