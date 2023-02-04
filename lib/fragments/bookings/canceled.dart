import 'package:flutter/material.dart';

class Canceled extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CanceledState();
  }
  
}
class CanceledState extends State<Canceled>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center( child:  Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Image.asset("res/no_data.png", width: 150,),
      SizedBox(height: 8,),
      Text("You have no canceled booking", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      SizedBox(height: 8,),
      Text("You have no cancel booking has been made at this time", style: TextStyle(fontSize: 12),),
    ],),);
  }
  
}