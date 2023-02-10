import 'package:flutter/material.dart';

class Calls extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CallsState();
  }
  
}
class CallsState extends State<Calls>{
  @override
  Widget build(BuildContext context) {
    return Center( child:  Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Image.asset("res/no_calls.png", width: 140,),
      SizedBox(height: 8,),
      Text("You have no calls", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      SizedBox(height: 8,),
      Text("You have not made any calls at this time", style: TextStyle(fontSize: 12),),
    ],),);
  }
  
}