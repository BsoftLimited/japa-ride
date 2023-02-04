import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/iconify_flutter.dart'; //

class __Option extends StatefulWidget{
    IconData icon;
    String text;

    __Option({ required this.icon, required this.text});

    @override
    State<StatefulWidget> createState()  => __OptionState();
}

class __OptionState extends State<__Option>{
    @override
    Widget build(BuildContext context) {
        return TextButton(onPressed: (){},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Icon(widget.icon, size: 18, color: Colors.black54,),
                  SizedBox(width: 8),
                  Expanded(child: Text(widget.text, textAlign: TextAlign.start, style: TextStyle(fontSize: 14, color: Colors.black54,),)),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black54,),
              ]),
            ));
    }
}


class Profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ProfileState();
}


class ProfileState extends State<Profile>{
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
            CircleAvatar(backgroundImage: AssetImage("res/ceo.jpg"), radius: 46.0,),
            SizedBox(height: 5,),
            Text("Okelekele Nobel", style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text("+234 795 2034", style: TextStyle(color: Colors.black54, fontSize: 12),),
            SizedBox(height: 30,),
            __Option(icon: Icons.person_2_outlined, text: "Edit Profile"),
            SizedBox(height: 8,),
            __Option(icon: Icons.location_on_outlined, text: "Address"),
            SizedBox(height: 8,),
            __Option(icon: Icons.notifications_active_outlined, text: "Notification"),
            SizedBox(height: 8,),
            __Option(icon: Icons.wallet_outlined, text: "Payment"),
            SizedBox(height: 8,),
            __Option(icon: Icons.security, text: "Security"),
            SizedBox(height: 8,),
            __Option(icon: Icons.lock_outline_sharp, text: "Privacy Policy"),
            SizedBox(height: 8,),
            __Option(icon: Icons.info_outline_rounded, text: "Help Center"),
            SizedBox(height: 8,),
            __Option(icon: Icons.group_add_outlined, text: "Invite Friends"),
            SizedBox(height: 20,),
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