import 'package:flutter/material.dart';

class Verification extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => VerificationState();
  
}
class VerificationState extends State<Verification>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verification", style: TextStyle(color: Color.fromARGB(255, 245, 160, 94), fontWeight: FontWeight.w400, letterSpacing: 1.3)),
        leading: Row(children: [
          IconButton(onPressed: (){ Navigator.pop(context); }, iconSize: 22, icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 245, 160, 94),)),
          const SizedBox(width: 2,),
          const Icon(Icons.phonelink_lock_outlined, size: 26, color: Color.fromARGB(255, 245, 160, 94),),
        ],),
        leadingWidth: 70,
        backgroundColor: Colors.white, elevation: 1,),
    );
  }
  
}