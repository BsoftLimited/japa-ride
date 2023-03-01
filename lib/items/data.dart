import "dart:convert" show json;
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:japa/fragments/Status.dart';
import 'package:japa/items/item.dart';

import 'package:japa/items/user.dart';
import 'package:japa/screens/loading.dart';
import 'package:japa/services/init_service.dart';
import 'package:japa/utils/util.dart';

class Data extends Item{
    User user;

    Data.__new({required this.user});

    static Option<Data> __data = Option.none();

    static bool hasInstance() => Data.__data.is_some;
    static Data instance()=> Data.__data.value;
    static create(Map<String, dynamic> data){
        User user = UserFrom(data["user"]);
        __data = Option.some(Data.__new(user: user));
    }

    static void initialize(BuildContext context, String data, void Function() finished){
        Loading.Start(context: context, message: "Initializing, please wait"); log("initiliazation was called");
        try{
        InitService service = InitService(listener: (suceeded, response, request){
            Loading.Stop(context);
            if(suceeded){
                Map<String, dynamic> init = json.decode(response) as  Map<String, dynamic>;

                Data.create(init);
                finished();
            }else{
                log("${response}");
                Map<String, dynamic> init = json.decode(response)[0];
                Status.Start(context: context, status: suceeded, message: JsonHelper.getString(init["message"]));
                log("Error:  $response");
            }
        });
        service.start(params: json.decode(data));
        }catch(ex){
            log("${ex.toString()}");
        }
    }
}