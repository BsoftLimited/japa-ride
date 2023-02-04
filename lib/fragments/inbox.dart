import 'package:flutter/material.dart';
import 'package:japa/fragments/inbox/calls.dart';
import 'package:japa/fragments/inbox/chats.dart';

class Inbox extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InboxState();
  }
  
}
class InboxState extends State<Inbox>{
  int __activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: __activeIndex,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Inbox', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          leading: Icon(Icons.comment_outlined, color: const Color.fromARGB(255, 245, 160, 94), size: 28,),
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 12),
            indicatorColor: const Color.fromARGB(255, 245, 160, 94),
            labelColor: const Color.fromARGB(255, 245, 160, 94),
            unselectedLabelColor: Colors.black54,
            onTap: (value){ setState(() {
              __activeIndex = value;
            });},
            tabs: [
              Tab(text: "Chats"),
              Tab(text: "Calls"),
            ],
          ),
        ),
        body: TabBarView( children: [ Chats(), Calls()]),
        floatingActionButton: FloatingActionButton( mini: true,
          onPressed: () {},

          child: Icon((__activeIndex == 0) ? Icons.message_outlined : Icons.phone, color: Colors.white,),
        ),
      ),
    );
  }
  
}