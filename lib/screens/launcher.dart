import 'package:flutter/material.dart';
import 'package:japa/fragments/cards.dart';
import 'package:japa/fragments/splash.dart';
import 'package:japa/utils/util.dart';

class Launcher extends StatefulWidget{
    const Launcher({super.key});

    @override
    State<StatefulWidget> createState() => LauncherState();
}

class LauncherState extends State<Launcher>{
    int index = 0;
    Option<Cards> cards = Option.none();
    Option<Splash> splash = Option.none();

    Widget render(){
        if(cards.is_none){
            cards = Option.some(Cards(key: Key("cards"),));
        }

        if(splash.is_none){
            splash = Option.some(Splash(key: const Key("splash"), listener: (() {
              setState(() { index = index == 0 ? 1 : 0; });
            }),));
        }
        return index == 0 ? splash.value : cards.value;
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