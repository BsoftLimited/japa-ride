import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:japa/fragments/account.dart';
import 'package:japa/fragments/home.dart';

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
      __pages = <Widget>[
          Home(isHideBottomNavbar: (isHide) =>{
             setState(()=>{ __isVisble = !isHide })
          }),
        Center(child: Text("logs"),),
        Account()
      ];
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home" ),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: "Logs" ),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_sharp), label: "Account" ),
          ],
          currentIndex: __selectedIndex,
          onTap: __onItemTapped
        ),
      ),
    );
  }
}