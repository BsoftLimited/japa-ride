import 'package:flutter/material.dart';

class SelectVehicle extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SelectVehicleState();
}

class SelectVehicleState extends State<SelectVehicle>{
  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text('Select Vehicle', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              leading: Row(
                children: [
                  IconButton(onPressed: (){ Navigator.pop(context); }, icon: Icon(Icons.arrow_back,), color: const Color.fromARGB(255, 245, 160, 94)),
                  SizedBox(width: 5,),
                  Icon(Icons.emoji_transportation_outlined, color: const Color.fromARGB(255, 245, 160, 94),),
                ],
              ),
              leadingWidth: 30,),
      );
  }
  
}