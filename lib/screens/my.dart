import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Japa Ride',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  bool _isVisible = false;
  late ScrollController controller;

  void show_nav(){
    setState(() { _isVisible = true; });
  }

  void hide_nav(){
    setState(() { _isVisible = false; });
  }


  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: controller,
        children: List.generate(50, (index) => Text(("$index"))),
      ),
      bottomNavigationBar: Offstage(
        offstage: !_isVisible,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
                label: "Log",
                icon: Icon(Icons.menu_book_outlined)
            ),
            BottomNavigationBarItem(
                label: "Account",
                icon: Icon(Icons.account_circle)
            )
          ],
        ),
      ),
    );
  }
}