import 'package:flutter/material.dart';

class Completed extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CompletedState();
  }
  
}
class CompletedState extends State<Completed>{
  @override
  Widget build(BuildContext context) {
    return Center( child:  Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Image.asset("res/no_data.png", width: 150,),
      SizedBox(height: 8,),
      Text("You have no conpleted booking", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      SizedBox(height: 8,),
      Text("You have not completed any booking at this time", style: TextStyle(fontSize: 12),),
    ],),);
  }
  
}