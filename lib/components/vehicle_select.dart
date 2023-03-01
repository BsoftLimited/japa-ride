import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/emojione_monotone.dart';

class __VehicleSelectItem{
    String name, icon;

    __VehicleSelectItem({ required this.name, required this.icon });
}
class VehicleSelect extends StatefulWidget{
  final void Function(String?) valueChanged;

  VehicleSelect({ required this.valueChanged});

  @override
  State<StatefulWidget> createState() => __VehicleSelectState();
}

class __VehicleSelectState extends State<VehicleSelect>{
  List<__VehicleSelectItem> vehicles = [
    __VehicleSelectItem(name: "Bus", icon: EmojioneMonotone.oncoming_bus),
    __VehicleSelectItem(name: "Taxi", icon: EmojioneMonotone.oncoming_taxi),
    __VehicleSelectItem(name: "Tricycle", icon: EmojioneMonotone.oncoming_fist),
    __VehicleSelectItem(name: "Long Bus", icon: EmojioneMonotone.oncoming_bus),
  ];
  late List<DropdownMenuItem<String>> items;
  String initValue = "Taxi";

  Widget __getIcon(__VehicleSelectItem item){
    return Row(children: [
      Iconify(item.icon, size: 18, color:const Color.fromARGB(255, 245, 160, 94),),
      SizedBox(width: 5,),
      Text(item.name, style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 245, 160, 94),),),
    ],);
  }

  @override
  void initState() {
    items = List.generate(vehicles.length, (index){
      __VehicleSelectItem init = vehicles[index];
      return DropdownMenuItem(value: init.name, child:  Padding( padding: const EdgeInsets.only(left: 8.0),  child: __getIcon(init),),);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(child: DropdownButton(value: initValue,
        borderRadius: BorderRadius.circular(20.0),
        items: items, onChanged: (value){
        widget.valueChanged(value);
        setState(() {
            initValue = value!;
        });
    }));
  }
}

