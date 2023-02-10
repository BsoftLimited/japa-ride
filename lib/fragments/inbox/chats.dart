import 'package:flutter/material.dart';

class Chats extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatsState();
  }
  
}
class ChatsState extends State<Chats>{
  @override
  Widget build(BuildContext context) {
    return Center( child:  Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Image.asset("res/no_chats.png", width: 200,),
      SizedBox(height: 8,),
      Text("You have no messages", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      SizedBox(height: 8,),
      Text("You have not made or recieved any chats at this time", style: TextStyle(fontSize: 12),),
    ],),);
  }
  
}