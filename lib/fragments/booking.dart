import 'package:flutter/material.dart';
import 'package:japa/fragments/bookings/active.dart';
import 'package:japa/fragments/bookings/canceled.dart';
import 'package:japa/fragments/bookings/completed.dart';

class Booking extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BookingState();
  }
  
}
class BookingState extends State<Booking>{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('My Bookings', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          leading: Icon(Icons.menu_book, color: const Color.fromARGB(255, 245, 160, 94),),
          leadingWidth: 30,
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 12),
            indicatorColor: const Color.fromARGB(255, 245, 160, 94),
            labelColor: const Color.fromARGB(255, 245, 160, 94),
            unselectedLabelColor: Colors.black54,
            tabs: [
              Tab(text: "Active"),
              Tab(text: "Completed"),
              Tab(text: "Cancelled"),
            ],
          ),
        ),
        body: TabBarView( children: [ Active(), Completed(), Canceled()],
        ),
      ),
    );
  }
  
}