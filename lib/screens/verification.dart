import 'package:flutter/material.dart';

class Verification extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => VerificationState();
  
}
class VerificationState extends State<Verification>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verification", style: TextStyle(color: const Color.fromARGB(255, 245, 160, 94), fontWeight: FontWeight.w400, letterSpacing: 1.3)),
        leading: Row(children: [
          IconButton(onPressed: (){ Navigator.pop(context); }, iconSize: 22, icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 245, 160, 94),)),
          SizedBox(width: 2,),
          Icon(Icons.phonelink_lock_outlined, size: 26, color: const Color.fromARGB(255, 245, 160, 94),),
        ],),
        leadingWidth: 70,
        backgroundColor: Colors.white, elevation: 1,),
    );
  }
  
}