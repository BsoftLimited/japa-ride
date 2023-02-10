import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:japa/fragments/account.dart';
import 'package:japa/fragments/booking.dart';
import 'package:japa/fragments/inbox.dart';
import 'package:japa/fragments/profile.dart';
import 'package:japa/fragments/wallet.dart';
import 'package:japa/fragments/map.dart';

class Main extends StatefulWidget{
  const Main({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => __MainState();
}

class __MainState extends State<Main> with SingleTickerProviderStateMixin{
  int __selectedIndex = 0;
  bool __isVisble = true;
  late List<Widget> __pages;

  void __onItemTapped(int index){
      setState(() { __selectedIndex = index; });
  }

  @override
  void initState() {
      __pages = <Widget>[ Map(), Booking(), Inbox(), Wallet(), Profile()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("Japa Ride"), elevation: 0, titleTextStyle: TextStyle(color: Colors.white70), toolbarTextStyle: TextStyle(color: Colors.white70),),
      body: IndexedStack(
          children: __pages,
          index: __selectedIndex
        ),
      bottomNavigationBar: Offstage(
        offstage: !__isVisble,
        child: BottomNavigationBar(
          selectedItemColor: const Color.fromARGB(255, 245, 160, 94), unselectedItemColor: Colors.black54,
          selectedFontSize: 12, unselectedFontSize: 12, showUnselectedLabels: true, enableFeedback: false,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: "Map" ),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: "Booking" ),
            BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: "Inbox" ),
            BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet" ),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_sharp), label: "Profile" ),
          ],
          currentIndex: __selectedIndex,
          onTap: __onItemTapped
        ),
      ),
    );
  }
}