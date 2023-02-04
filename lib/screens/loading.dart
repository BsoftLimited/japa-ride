import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget{
    String message;
    static bool active = false;

    Loading({this.message = "Loading"});

    @override
    State<StatefulWidget> createState()=>  LoadingState();

    static void Start({required BuildContext context, String message = "Loading, Please wait"}){
      if(active){ Loading.Stop(context); }
        Navigator.of(context).push(
            MaterialPageRoute( settings: const RouteSettings(name: '/loading'),
                builder: (context) => Loading(message: message)));
        Loading.active = true;
    }

    static void Stop(BuildContext context){
        if(Loading.active){
            Loading.active = false;
            Navigator.pop(context);
        }
    }
}

class LoadingState extends State<Loading>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SpinKitFoldingCube(color: Color.fromARGB(255, 245, 160, 94),),
            SizedBox(height: 20),
            Text(widget.message, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, letterSpacing: 1.5, fontSize: 16),),
          ],),
        )
    );
  }
  
}