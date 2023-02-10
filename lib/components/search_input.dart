import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SearchInputState();
}

class SearchInputState extends State<SearchInput>{

  TextStyle __getStyle()=> TextStyle( fontSize: 14.0 );

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded( child: Container(
              padding: EdgeInsets.only(top: 0, bottom: 0, right: 10, left: 10),
              decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextField( style: __getStyle(), decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(0)), scrollPadding: EdgeInsets.all(0),))),
          ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.search, color: Colors.white70,),
                style: ElevatedButton.styleFrom(shape: CircleBorder(), padding: EdgeInsets.all(16)),)
        ],
      );
  }
}