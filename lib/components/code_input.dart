import 'package:flutter/material.dart';

class CodeInput extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => CodeInputState();
  
}
class CodeInputState extends State<CodeInput>{
  @override
  Widget build(BuildContext context) {
    return
      SizedBox(width: 40, height: 50, child: Center(
        child: TextFormField( textAlign: TextAlign.center, maxLength: 1, maxLines: 1,
          decoration: InputDecoration(border: OutlineInputBorder()),),
      ));
  }
  
}