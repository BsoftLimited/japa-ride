import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:japa/components/custom_picker.dart';
import 'package:japa/components/vehicle_select.dart';
import 'package:japa/fragments/Status.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:japa/items/data.dart';
import 'package:japa/items/time.dart';
import 'package:japa/screens/loading.dart';
import 'package:japa/services/vehicle_signup_service.dart';
import 'package:japa/utils/util.dart';


class VehicleSignup extends StatefulWidget{
  String id;

  VehicleSignup({super.key,  this.id = "" });

  @override
  State<StatefulWidget> createState() => VehicleSignupState();
}

class VehicleSignupState extends State<VehicleSignup>{
  String start = "7:00", end = "18:00", vehicle = "Taxi";

  void submit(){
    Loading.Start(context: context, message: "Vehicle Registration in progress");
    Map<String, String> params = {
      "id" : widget.id,
      "vehicle" : vehicle.replaceAll(" ", "").toLowerCase(),
      "start" : start, "end" : end };

    VehicleSignUpService service = VehicleSignUpService(listener: (suceeded, response, request){
        Loading.Stop(context);
        if(suceeded){
            Data.initialize(context, response, ()=>Navigator.pushReplacementNamed(context, '/main'));
        }else{
            Map<String, dynamic> init = json.decode(response)[0];
            Status.Start(context: context, status: suceeded, message: JsonHelper.getString(init["message"]));
        }
        log("$response");
    });
    service.start(params: params);
  }

  void setStart(){
    DatePicker.showPicker(context, showTitleActions: true, onConfirm: (date) {
          start = CustomTime.from(date).toString();
        },  pickerModel: CustomPicker(time: start),
        locale: LocaleType.en);
  }

  void setEnd(){
    DatePicker.showPicker(context,
        showTitleActions: true, onConfirm: (date) {
          end = CustomTime.from(date).toString();
        },  pickerModel: CustomPicker(time: end),
        locale: LocaleType.en);
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text("Vehicle Form", style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 245, 160, 94), fontWeight: FontWeight.w400, letterSpacing: 1.3)),
          leading: Row(children: [
            IconButton(onPressed: (){ Navigator.pop(context); }, iconSize: 22, icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 245, 160, 94),)),
            SizedBox(width: 2,),
            Icon(Icons.car_crash_sharp, size: 26, color: const Color.fromARGB(255, 245, 160, 94),),
          ],),
          leadingWidth: 70,
          backgroundColor: Colors.white, elevation: 1,),
        body: SafeArea( child: Center( child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Row(
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Image.asset("res/way.png"),
                  )),
                ],
              ),
              SizedBox(height: 15,),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Choose Vehicle type", style: TextStyle(fontSize: 18, letterSpacing: 1.2, fontWeight: FontWeight.w600, color: Colors.black45),),
                      SizedBox(height: 5,),
                      Row(children: [
                        Expanded(child: Text("You have to choose vehicle type, as this will be use to identify and group which category of transportation that the client will want to use.",
                          style: TextStyle(fontSize: 14, color: Colors.black45),),)
                      ],),
                      SizedBox(height: 5,),
                      VehicleSelect(valueChanged: (value){ vehicle = value!; },),
                      SizedBox(height: 15,),
                      Text("Working Period", style: TextStyle(fontSize: 18, letterSpacing: 1.2, fontWeight: FontWeight.w600, color: Colors.black45)),
                      SizedBox(height: 5,),
                      Row(children: [
                        Expanded(child: Text("You have to set when and when you will be active to receive bookings. note you can always change this on the account settings.",
                          style: TextStyle(fontSize: 14, color: Colors.black45),),)
                      ],),
                      SizedBox(height: 8,),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text("from", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1.2)),
                        ),
                        OutlinedButton(onPressed: setStart, style: OutlinedButton.styleFrom(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                            child: Padding(padding: const EdgeInsets.all(8.0),
                              child: Text("7:00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1.2),),
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("to", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1.2)),
                        ),
                        OutlinedButton(onPressed: setEnd, style: OutlinedButton.styleFrom(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                            child: Padding(padding: const EdgeInsets.all(8.0),
                              child: Text("12:00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1.2),),
                        )),
                      ],),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(onPressed: submit,
                              child: Padding( padding: EdgeInsets.only(left: 30, right:  30, top: 12, bottom: 12), child: Text("submit", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),)),
                              color: const Color.fromARGB(255, 245, 160, 94),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                        ],
                      ),
                    ],
                ),
              )
          ],) )),
      );
  }
  
}