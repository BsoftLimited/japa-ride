import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart'; // For Iconify Widget
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/bi.dart';

class Account extends StatefulWidget{
    @override
    State<StatefulWidget> createState() => AccountState();
}

class AccountState extends State<Account>{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 150,
          child: Stack(children: [
            Column(children: [
              Expanded(child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 245, 160, 94),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),)),
              Expanded(child: Container())
            ],),
            Container(alignment: Alignment.centerLeft, padding: EdgeInsets.only(left: 30), child:Row(children: [
                CircleAvatar(backgroundImage: AssetImage("res/ceo.jpg"), radius: 46.0,),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 24),
                  child: Text("Okelekele Nobel", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                ),
            ])),
          ],),
        ),
        Divider(),
        SizedBox(height: 10,),
        Padding(padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              TextButton(onPressed: (){ Navigator.pushNamed(context, "/main/wallet"); }, child: Row(children: [
                CircleAvatar( child: Iconify(Bi.cash_coin, size: 15, color: Colors.white), radius: 14,),
                SizedBox(width: 20,),
                Text("Fund Account", style: TextStyle(fontSize: 14, color: Colors.black54),)
              ],)),
              SizedBox(height: 14,),
              TextButton(onPressed: (){}, child: Row(children: [
                CircleAvatar( child: Icon(Icons.message, size: 15, color: Colors.white), radius: 14,),
                SizedBox(width: 20,),
                Text("Messages", style: TextStyle(fontSize: 14, color: Colors.black54),)
              ],)),
              SizedBox(height: 14,),
              TextButton(onPressed: (){}, child: Row(children: [
                CircleAvatar( child: Iconify(Mdi.car_estate, size: 17, color: Colors.white,), radius: 14,),
                SizedBox(width: 20,),
                Text("Become a rider", style: TextStyle(fontSize: 14, color: Colors.black54),)
              ],)),
              SizedBox(height: 7,),
            ],)
        ),
        Divider(),
        Padding(padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              SizedBox(height: 7,),
              TextButton(onPressed: (){}, child: Row(children: [
                CircleAvatar( child: Icon(Icons.lightbulb, size: 15, color: Colors.white), radius: 14,),
                SizedBox(width: 20,),
                Text("Tips", style: TextStyle(fontSize: 14, color: Colors.black54),)
              ],)),
              SizedBox(height: 14,),
              TextButton(onPressed: (){}, child: Row(children: [
                CircleAvatar( child: Icon(Icons.rule_outlined, size: 15, color: Colors.white), radius: 14,),
                SizedBox(width: 20,),
                Text("Legal", style: TextStyle(fontSize: 14, color: Colors.black54),)
              ],)),
              SizedBox(height: 14,),
              TextButton(onPressed: (){ Navigator.pushNamed(context, "/main/settings"); }, child: Row(children: [
                CircleAvatar( child: Icon(Icons.settings, size: 15, color: Colors.white), radius: 14,),
                SizedBox(width: 20,),
                Text("Settings", style: TextStyle(fontSize: 14, color: Colors.black54),)
              ],)),
              SizedBox(height: 14,),
              TextButton(onPressed: (){}, child: Row(children: [
                CircleAvatar( child: Icon(Icons.help_outline, size: 17, color: Colors.white), radius: 14,),
                SizedBox(width: 20,),
                Text("Help", style: TextStyle(fontSize: 14, color: Colors.black54),)
              ],)),
            ],)
        ),
        SizedBox(height: 10,),
        Divider(),
        SizedBox(height: 10,),
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
      ],),
    );
  }
  
}