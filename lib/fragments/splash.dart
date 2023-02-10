import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget{
    Function() listener;
    
    Splash({super.key, required this.listener});

    @override
    State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<Splash> with TickerProviderStateMixin, AfterLayoutMixin{
    double opacity = 0.0;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                color: Colors.white,
                child: AnimatedOpacity(
                  curve: Curves.easeIn,
                  opacity: opacity,
                  duration: const Duration(seconds: 3),
                  onEnd: widget.listener,
                  child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Image.asset("res/logo.png", width: 120,),
                              const SizedBox(height: 10,),
                              const Text("Japa Ride", style: TextStyle(color: Colors.black87, fontSize: 30.0, fontWeight: FontWeight.w900),)
                          ],
                      ),),
                ),
            )
        );
    }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
      setState(() { opacity = 1; });
  }
}