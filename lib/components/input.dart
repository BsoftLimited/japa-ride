import 'package:flutter/material.dart';
import 'package:japa/utils/util.dart';

class Input extends StatefulWidget{
    final String hint;
    final IconData? icon;
    final Color color;
    final TextInputType inputType;
    final TextEditingController controller;

    Input({Key? key, required this.hint, this.icon, required this.controller, this.color = const Color.fromARGB(255, 245, 160, 94), this.inputType = TextInputType.text }) : super(key: key);

    @override
    State<StatefulWidget> createState()=> InputState();
}

class InputState extends State<Input>{
    Option<bool> __hide = Option.none();

    UnderlineInputBorder __getBorder(Color color){
        return UnderlineInputBorder(
            borderSide: BorderSide(width: 1, style: BorderStyle.solid, color: color),
        );
    }

    TextStyle __getStyle()=> TextStyle( fontSize: 16.0, color: widget.color );

    Icon? __getPrexfixIcon(){
        if(widget.icon != null){
            return Icon(widget.icon, size: 24, color: widget.color);
        }
    }

    InputDecoration __getDecoration(){
        if(__hide.is_none){
            __hide = Option.some(widget.inputType == TextInputType.visiblePassword);
        }
        IconButton? suffixIcon = widget.inputType != TextInputType.visiblePassword ? null : IconButton(
            icon: Icon(__hide.value ? Icons.remove_red_eye : Icons.visibility_off , size: 24),
            color: widget.color,
            onPressed: (){ setState(()=> __hide.set(!__hide.value) );});
        return InputDecoration(
            labelText: widget.hint,
            labelStyle: TextStyle( fontSize: 16.0, color: widget.color ),
            focusColor: widget.color,
            border: __getBorder(widget.color),
            enabledBorder: __getBorder(Colors.grey),
            prefixIcon : __getPrexfixIcon(),
            suffixIcon: suffixIcon
        );
    }

    @override
    Widget build(BuildContext context) {
        return TextFormField(
            keyboardType: widget.inputType,
            controller: widget.controller,
            decoration: __getDecoration(),
            obscureText: __hide.value,
            style: __getStyle(),
        );;
    }
}