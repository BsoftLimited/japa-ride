import 'package:flutter/material.dart';
import 'package:japa/fragments/login.dart';
import 'package:japa/fragments/splash.dart';
import 'package:japa/utils/util.dart';

class Launcher extends StatefulWidget{
    const Launcher({super.key});

    @override
    State<StatefulWidget> createState() => LauncherState();
}

class LauncherState extends State<Launcher>{
    int index = 0;
    Option<Login> login = Option.none();
    Option<Splash> splash = Option.none();

    Widget render(){
        if(login.is_none){
            login = Option.some(const Login(key: Key("login"),));
        }

        if(splash.is_none){
            splash = Option.some(Splash(key: const Key("splash"), listener: (() {
              setState(() { index = index == 0 ? 1 : 0; });
            }),));
        }
        return index == 0 ? splash.value : login.value;
    }

    @override
    Widget build(BuildContext context) {
        return Center(
            child: AnimatedSwitcher(
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                duration: const Duration(seconds: 1),
                child: render(),
            ),
        );
    }
}