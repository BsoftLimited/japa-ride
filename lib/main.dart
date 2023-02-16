import 'package:flutter/material.dart';
import 'package:japa/fragments/login.dart';
import 'package:japa/screens/Recovery.dart';
import 'package:japa/screens/account_settings.dart';
import 'package:japa/screens/launcher.dart';
import 'package:japa/screens/loading.dart';
import 'package:japa/screens/main.dart';
import 'package:japa/screens/my.dart';
import 'package:japa/screens/signup.dart';

void main() =>runApp(const JapaRide());

class JapaRide extends StatefulWidget {
    const JapaRide({super.key});

    @override
  State<StatefulWidget> createState() => __JapaRide();
}

class __JapaRide extends State<JapaRide>{
    @override
    Widget build(BuildContext context) {
        Map<int, Color> swatch = {
            50: const Color.fromARGB(255, 245, 160, 94),
            100: const Color.fromARGB(255, 245, 160, 94),
            200: const Color.fromARGB(255, 245, 160, 94),
            300: const Color.fromARGB(255, 245, 160, 94),
            400: const Color.fromARGB(2553, 245, 160, 94),
            500: const Color.fromARGB(255, 245, 160, 94),
            600: const Color.fromARGB(255, 245, 160, 94),
            700: const Color.fromARGB(255, 245, 160, 94),
            800: const Color.fromARGB(255, 245, 160, 94),
            900: const Color.fromARGB(255, 245, 160, 94),
        };
        return MaterialApp(
            title: 'Japa Ride',
            theme: ThemeData(primarySwatch: MaterialColor( const Color.fromARGB(255, 245, 160, 94).value, swatch)),
            initialRoute: "/main",
            debugShowCheckedModeBanner: false,
            routes: {
                "/" :(context) => const Launcher(),
                "/loading" : (context) => Loading(),
                "/signup" : (context) => Signup(),
                "/login" : (context) => Login(),
                "/recovery" : (context) => Recovery(),
                "/main/settings": (context) => AccountSettings(),
                "/main": (context) => const Main(),
                "/test" : (context) => OrderTrackingPage(),
            },
        );
    }
}
