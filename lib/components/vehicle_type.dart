import 'package:flutter/material.dart';

class VehicleType extends StatelessWidget{
    IconData icon;
    String title, groupValue;
    int count, amount;
    void Function(String? value) onClick;

    VehicleType({required this.groupValue, required this.icon, required this.title, required this.count, required this.amount, required this.onClick});
    
    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 10),
        child: Row(
            mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey, child: Icon(icon, size: 16, color: Colors.white,),),
              SizedBox(width: 8,),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("$title", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black45, letterSpacing: 1.2),),
                  SizedBox(height: 6,),
                  Text("${count} Nearbies", style: TextStyle(fontSize: 11, color: Colors.black45),)
              ],)
            ],),
            Row(mainAxisSize: MainAxisSize.min, children: [
                Text("\u20A6 $amount", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 245, 160, 94))),
                SizedBox(width: 5,),
                Radio(value: title, groupValue: groupValue, onChanged: onClick),
            ],)
        ],),
      );
    }
}