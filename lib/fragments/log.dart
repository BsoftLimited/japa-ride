import 'package:flutter/material.dart';

class Log extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LogState();
  }
  
}
class LogState extends State<Log>{
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Logs"),);
  }
  
}