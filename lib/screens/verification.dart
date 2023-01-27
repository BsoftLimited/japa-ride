import 'package:flutter/material.dart';

class Verification extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => VerificationState();
  
}
class VerificationState extends State<Verification>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verification", style: TextStyle(color: Colors.white70))),
    );
  }
  
}