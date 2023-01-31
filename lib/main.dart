import 'package:flutter/material.dart';
import 'package:japa/screens/Recovery.dart';
import 'package:japa/screens/account_settings.dart';
import 'package:japa/screens/launcher.dart';
import 'package:japa/screens/main.dart';
import 'package:japa/screens/my.dart';
import 'package:japa/screens/signup.dart';
import 'package:japa/screens/wallet.dart';

void main() =>runApp(const JAPARide());

class JAPARide extends StatelessWidget {
    const JAPARide({super.key});


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
            initialRoute: "/",
            routes: {
                "/" :(context) => const Launcher(),
                "/signup" : (context) => Signup(),
                "/recovery" : (context) => Recovery(),
                "/main" : (context) => Main(),
                "/main/settings": (context) => AccountSettings(),
                "/main/wallet" : (context) => Wallet(),
                "/test" : (context) => MyApp(),
            },
        );
    }
}
