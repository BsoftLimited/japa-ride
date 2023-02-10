import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:japa/components/search_input.dart';
import 'package:japa/utils/util.dart';

class Home extends StatefulWidget{
  final Function(bool) isHideBottomNavbar;

  Home({required this.isHideBottomNavbar});

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home>{
    late Option<List<Widget>> __carosel_items = Option.none();
    late Option<Widget> __header = Option.none();

    List<Widget> __init_carosel_items(){
        if(__carosel_items.is_none){
            __carosel_items = Option.some([
                Container(
                    width: MediaQuery.of(context).size.width, margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 160, 94),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10), bottom: Radius.circular(10)),),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text("Quick, in-town delivery", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70),),
                              SizedBox(height: 10),
                              Text("send a package", style: TextStyle(fontSize: 12, color: Colors.white70))
                            ],),
                          ),
                          Image.asset("res/present.png")
                      ],),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width, margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 160, 94),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10), bottom: Radius.circular(10)),),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text("Got favourite driver", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70),),
                              SizedBox(height: 10),
                              Text("Book reserve", style: TextStyle(fontSize: 12, color: Colors.white70))
                            ],),
                          ),
                          Image.asset("res/wheel.png")
                        ],),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width, margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 160, 94),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10), bottom: Radius.circular(10)),),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text("Leave some at home", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70),),
                              SizedBox(height: 10),
                              Text("send a package", style: TextStyle(fontSize: 12, color: Colors.white70))
                            ],),
                          ),
                          Image.asset("res/teddy.png")
                        ],),
                    ))
            ]);
        }
        return __carosel_items.value;
  }

  Widget __init_header(){
      if(__header.is_none){
          __header = Option.some(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: Padding(
                    padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                    child:Container(
                      height: 80,
                      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.vertical(top: Radius.circular(10), bottom: Radius.circular(10))),
                      child: Center(child: TextButton(
                        onPressed: ()=>{},
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Image.asset("res/mercedes.png", width: 60,),
                          SizedBox(height: 5,),
                          Text("Ride", style: TextStyle(color: Colors.black54),)
                        ],),
                      ),),))),
                Expanded(child: Padding(
                    padding: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
                    child:Container(
                      height: 80,
                      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.vertical(top: Radius.circular(10), bottom: Radius.circular(10))),
                      child: Center(child: TextButton(
                        onPressed: ()=>{},
                        child: Column( mainAxisAlignment: MainAxisAlignment.center, children: [
                          Image.asset("res/rectangle.png", width: 55,),
                          SizedBox(height: 5,),
                          Text("Ride", style: TextStyle(color: Colors.black54),)
                        ],),
                      ),),))),
                Expanded(child: Padding(
                    padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                    child:Container(
                      height: 80,
                      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.vertical(top: Radius.circular(10), bottom: Radius.circular(10))),
                      child: Center(child: TextButton(
                        onPressed: (){ Navigator.pushNamed(context, "/main/wallet"); },
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Image.asset("res/fund.png", width: 50,),
                          SizedBox(height: 5,),
                          Text("Fund Wallet", style: TextStyle(color: Colors.black54),)
                        ],),
                      ),),))),
              ]),
          );
      }
      return __header.value;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          __init_header(),
          CarouselSlider(
            options: CarouselOptions(
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 300),
                height: 120.0, viewportFraction: 1.0),
            items: __init_carosel_items()
          ),
          Padding( padding: const EdgeInsets.all(10.0),  child: SearchInput()),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("Around you", textAlign: TextAlign.left,),
          ),
          SizedBox(height: 200, child: Center(child: Image.asset("res/map.png"))),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(Icons.star, size: 24, color:  Colors.black45,)),
              Expanded(
                child: Column( children: [
                  Row(children: [Expanded( child: Text("Choose a saved place")),  Icon(Icons.arrow_forward_ios_outlined, size: 14,)]),
                  SizedBox(height: 15,),
                  Divider(color: Colors.black45, thickness: 0.2,)
                ],),
              )
            ],),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(Icons.location_on, size: 24, color:  Colors.black45,),
              ),
              Expanded(
                child: Column( children: [
                  Row(children: [Expanded( child: Text("Set destination on map")),  Icon(Icons.arrow_forward_ios_outlined, size: 14,)]),
                  SizedBox(height: 15,),
                  Divider(color: Colors.black45, thickness: 0.2,)
                ],),
              )
            ],),
          )
        ],),
      );
  }
  
}