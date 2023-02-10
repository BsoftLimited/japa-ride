import 'package:flutter/material.dart';

class Status extends StatefulWidget{
  bool status;
  String message;
  static bool active = false;

  Status({required this.message, required this.status});

  @override
  State<StatefulWidget> createState() =>  StatusState();

  static void Start({required BuildContext context, required String message, required bool status}){
    if(active){ Status.Stop(context); }
    Navigator.of(context).push(
        MaterialPageRoute( settings: const RouteSettings(name: '/status'),
            builder: (context) => Status(message: message, status:  status,)));
    Status.active = true;
  }

  static void Stop(BuildContext context){
    if(Status.active){
      Status.active = false;
      Navigator.pop(context);
    }
  }
}

class StatusState extends State<Status>{
  @override
  Widget build(BuildContext context) {
    return TextButton( onPressed: (){ Status.Stop(context); },
      child: Container(alignment: Alignment.center, color: Colors.black45.withAlpha(1),
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                Image.asset( widget.status ? "res/succes.png" : "res/error.png", width: 120, height: 120,),
                SizedBox(height: 8,),
                SizedBox(width: 200, child: Text(widget.message, textAlign: TextAlign.center, style: TextStyle(color: const Color.fromARGB(255, 245, 160, 94)),))
              ],),
            ),
          )),
    );
  }
  
}