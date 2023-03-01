import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:japa/items/data.dart';
import 'package:japa/items/user.dart';
import 'package:japa/screens/vehicle_signup.dart'; //

class __Option extends StatelessWidget{
    IconData icon;
    String text;
    void Function() onClick;

    __Option({ required this.icon, required this.text, required this.onClick});

    @override
    Widget build(BuildContext context) {
      return TextButton(onPressed: onClick,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Icon(icon, size: 18, color: Colors.black54,),
              const SizedBox(width: 8),
              Expanded(child: Text(text, textAlign: TextAlign.start, style: TextStyle(fontSize: 14, color: Colors.black54,),)),
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black54,),
            ]),
          ));
    }
}

class Profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ProfileState();
}

class ProfileState extends State<Profile>{
  User user = Data.instance().user;

  Widget __initBecomeDriver(){
      if(user is Client){
        return Column(children: [
          Divider(thickness: 0.4, color: Colors.black38),
          SizedBox(height: 5,),
          __Option(icon: Icons.minor_crash, text: "Become a Driver", onClick: (){
            log("I was clicked");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VehicleSignup(id: user.id),
              ),
            );
          }),
          SizedBox(height: 5,),
        ],);
      }
      return SizedBox(height: 0,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          leading: Icon(Icons.person_2_outlined, color: const Color.fromARGB(255, 245, 160, 94), size: 30,),
          leadingWidth: 40,),
        body: SingleChildScrollView( child: Column(children: [
            SizedBox(height: 40,),
            CircleAvatar(backgroundImage: AssetImage("res/profile.png"), radius: 46.0,),
            SizedBox(height: 5,),
            Text("${user.surname} ${user.name}", style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text("${user.phone}", style: TextStyle(color: Colors.black54, fontSize: 12),),
            SizedBox(height: 30,),
            __Option(icon: Icons.person_2_outlined, text: "Edit Profile", onClick: (){},),
            SizedBox(height: 5,),
            Divider(thickness: 0.4, color: Colors.black38),
            SizedBox(height: 5,),
            __Option(icon: Icons.location_on_outlined, text: "Address", onClick: (){}),
            SizedBox(height: 5,),
            Divider(thickness: 0.4, color: Colors.black38),
            SizedBox(height: 5,),
            __Option(icon: Icons.notifications_active_outlined, text: "Notification", onClick: (){}),
            SizedBox(height: 5,),
            __initBecomeDriver(),
            Divider(thickness: 0.4, color: Colors.black38),
            SizedBox(height: 5,),
            __Option(icon: Icons.wallet_outlined, text: "Payment", onClick: (){},),
            SizedBox(height: 5,),
            Divider(thickness: 0.4, color: Colors.black38),
            SizedBox(height: 5,),
            __Option(icon: Icons.security, text: "Security", onClick: (){}),
            SizedBox(height: 5,),
            Divider(thickness: 0.4, color: Colors.black38),
            SizedBox(height: 5,),
            __Option(icon: Icons.lock_outline_sharp, text: "Privacy Policy", onClick: (){}),
          SizedBox(height: 5,),
          Divider(thickness: 0.4, color: Colors.black38),
          SizedBox(height: 5,),
            __Option(icon: Icons.info_outline_rounded, text: "Help Center", onClick: (){}),
          SizedBox(height: 5,),
          Divider(thickness: 0.4, color: Colors.black38),
          SizedBox(height: 5,),
            __Option(icon: Icons.group_add_outlined, text: "Invite Friends", onClick: (){}),
          SizedBox(height: 5,),
          Divider(thickness: 0.4, color: Colors.black38),
          SizedBox(height: 5,),
          Container(alignment: Alignment.bottomRight, padding: EdgeInsets.only(right: 10),
              child: MaterialButton(onPressed: ()=>{  Navigator.pushReplacementNamed(context, "/")},
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                  color: const Color.fromARGB(255, 245, 160, 94),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row( mainAxisSize: MainAxisSize.min,
                      children: [
                        Iconify(Bi.door_open_fill, size: 20, color: Colors.white),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text("Logout", style:  TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  )))
        ],),),
    );
  }
  
}