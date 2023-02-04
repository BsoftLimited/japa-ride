import 'package:flutter/material.dart';

class Input extends StatefulWidget{
    final String hint;
    final IconData? icon;
    final double textSize, iconSize;
    final Color color;
    final bool usePrefix;
    final TextInputType inputType;
    final TextEditingController controller;

    Input({Key? key, required this.hint, this.icon, required this.controller, this.usePrefix = true, this.iconSize = 18, this.textSize = 14, this.color = const Color.fromARGB(255, 245, 160, 94), this.inputType = TextInputType.text }) : super(key: key);

    @override
    State<StatefulWidget> createState()=> this.inputType == TextInputType.visiblePassword ? InputPasswordState() : InputTextState();
}

abstract class InputBaseState extends State<Input>{
    late bool __hide;

   @override
   void initState() {
       __hide = widget.inputType == TextInputType.visiblePassword;
       super.initState();
   }

    OutlineInputBorder __getBorder(Color color){
        return OutlineInputBorder(
            borderSide: BorderSide(width: 1, style: BorderStyle.solid, color: color),
            borderRadius: BorderRadius.all(Radius.circular(8))
        );
    }

    TextStyle __getStyle()=> TextStyle( fontSize: widget.textSize, color: widget.color );

    Icon? __getPrexfixIcon(){
        if(widget.icon != null && widget.usePrefix){
            return Icon(widget.icon, size: 24, color: widget.color);
        }
    }

    InputDecoration __getDecoration();

    @override
    Widget build(BuildContext context) {
        return TextFormField(
            keyboardType: widget.inputType,
            controller: widget.controller,
            decoration: __getDecoration(),
            obscureText: __hide,
            style: __getStyle(),
        );;
    }
}

class InputTextState extends InputBaseState{
    @override
    InputDecoration __getDecoration(){
        return InputDecoration(
            labelText: widget.hint,
            labelStyle: TextStyle( fontSize: widget.textSize, color: widget.color ),
            focusColor: widget.color,
            border: __getBorder(widget.color),
            enabledBorder: __getBorder(Colors.grey),
            prefixIcon : __getPrexfixIcon(),
        );
    }
}

class InputPasswordState extends InputBaseState{

    @override
    InputDecoration __getDecoration(){
        IconButton? suffixIcon = widget.usePrefix ? IconButton(
            icon: Icon(__hide ? Icons.remove_red_eye : Icons.visibility_off , size: widget.iconSize),
            color: widget.color,
            onPressed: (){ setState(()=> __hide = !__hide );}) : null;
        return InputDecoration(
            labelText: widget.hint,
            labelStyle: TextStyle( fontSize: widget.textSize, color: widget.color ),
            focusColor: widget.color,
            border: __getBorder(widget.color),
            enabledBorder: __getBorder(Colors.grey),
            prefixIcon : __getPrexfixIcon(),
            suffixIcon: suffixIcon,
        );
    }
}