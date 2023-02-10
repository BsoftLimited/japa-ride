import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:japa/components/input.dart';
import 'package:japa/utils/util.dart';
import 'package:pinput/pinput.dart';

Widget __getflag(String country){
    return Image.asset('icons/flags/png/${country}.png', package: 'country_icons', width: 28, height: 28,);
}

class SignUpInput extends StatefulWidget {
  final String hint, information;
  final IconData? iconData;
  final TextInputType inputType;
  final bool Function(String) check;
  final void Function(bool) monitior;
  final TextEditingController controller;

  SignUpInput(
      {required this.hint, required this.information, this.iconData, required this.inputType, required this.check, required this.controller, required this.monitior});

  @override
  State<StatefulWidget> createState() {
    if (inputType == TextInputType.phone) {
      return SignupInputPhoneState();
    } else if (inputType == TextInputType.visiblePassword) {
      return SignupInputPasswordState();
    }
    return SigupInputTextState();
  }
}
abstract class SignupInputBaseState extends State<SignUpInput>{
  bool isOk = false;
  Option<TextEditingController> controller = Option.none();
}

class SigupInputTextState extends SignupInputBaseState{
  Widget build_normal(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Input(hint: widget.hint, icon: widget.iconData, iconSize: 16, textSize: 14, controller: controller.value, inputType: widget.inputType),
        const SizedBox(height: 3),
        Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded( child: Text(widget.information, style: TextStyle(fontSize: 12)),),
              const SizedBox(width: 5),
              Icon(isOk ? Icons.check : Icons.cancel, color: isOk ? const Color.fromARGB(255, 245, 160, 94) : Colors.red, size: 16,)
            ]
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if(controller.is_none){
      controller = Option.some(widget.controller);
      isOk = widget.check(controller.value.text);
      controller.value.addListener(() {
        setState(() {
          isOk = widget.check(controller.value.value.text);
          widget.monitior(isOk);
        });
      });
    }
    return build_normal();
  }
}

class SignupInputPasswordState extends SignupInputBaseState{
  Option<TextEditingController> recontroller = Option.none();
  bool isEqual = false;

  Widget build_password(){
    return Column(
      children: [
        Column(
          children: [
            Input(hint: "Password", icon: widget.iconData, controller: controller.value, inputType: widget.inputType, iconSize: 16, textSize: 14,),
            const SizedBox(height: 3),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded( child: Text(widget.information, style: TextStyle(fontSize: 12)),),
                  const SizedBox(width: 5),
                  Icon(isOk ? Icons.check : Icons.cancel, color: isOk ? const Color.fromARGB(255, 245, 160, 94) : Colors.red, size: 16,)
                ]
            ),
          ],
        ),
        const SizedBox(height: 15),
        Column(
          children: [
            Input(hint: "Re-Enter password", icon: widget.iconData, controller: recontroller.value, inputType: widget.inputType, iconSize: 16, textSize: 14,),
            const SizedBox(height: 3),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded( child: Text("must be equal to the password enterd earlier", style: TextStyle(fontSize: 12)),),
                  const SizedBox(width: 5),
                  Icon(isEqual && controller.value.text.isNotEmpty ? Icons.check : Icons.cancel, color: isOk ? const Color.fromARGB(255, 245, 160, 94) : Colors.red, size: 16,)
                ]
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if(controller.is_none){
      controller = Option.some(widget.controller);
      isOk = widget.check(controller.value.text);
      controller.value.addListener(() {
         setState(() {
           isOk = widget.check(controller.value.value.text);
           isEqual = controller.value.value.text == recontroller.value.value.text;
           widget.monitior(isEqual && isOk);
         });
      });
    }

    if(recontroller.is_none){
      recontroller = Option.some(TextEditingController());
      isEqual = controller.value.value.text == recontroller.value.value.text;
      recontroller.value.addListener(() {
        setState(() {
          isEqual = controller.value.value.text == recontroller.value.value.text;
          widget.monitior(isEqual && isOk && !controller.value.text.isEmpty);
        });
      });
    }
    return build_password();
  }
}

class SignupInputPhoneState extends SignupInputBaseState{
  String initValue = "+1";
  List<CountryFlag> flags = CountryFlag.Flags();
  late List<DropdownMenuItem<String>> items;

  changeValue(String? value){
      setState(() {
          initValue = value as String;
          widget.controller.setText(initValue + ' ');
      });
  }

  @override
  void initState() {
      items = List.generate(flags.length, (index){
        CountryFlag flag = flags[index];
        return DropdownMenuItem(value: flag.code, child:  Padding( padding: const EdgeInsets.only(left: 8.0),  child: __getflag(flag.name),),);
      });
      widget.controller.setText(initValue);
      widget.controller.addListener(() {
          if(widget.controller.value.text.length < initValue.length + 1){
              widget.controller.setText(initValue + " ");
          }else if(widget.controller.value.text.length > initValue.length + 1){
              String init = widget.controller.value.text;
              int value = init.codeUnitAt(init.length - 1);
              if(!(value >= 48 && value <= 57)){
                  init = init.substring(0, init.length - 1);
                  widget.controller.setText(init);
              }
          }
      });
      super.initState();
  }

  Widget build_phone(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 60, child: DropdownButtonHideUnderline(child: DropdownButton(value: initValue, items: items, onChanged: changeValue))),
              Expanded(child:Input(hint: widget.hint, icon: widget.iconData, controller: controller.value, inputType: widget.inputType, iconSize: 16, textSize: 14,)),
            ]
        ),
        const SizedBox(height: 3,),
        Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded( child: Text(widget.information, style: TextStyle(fontSize: 12)),),
              const SizedBox(width: 5),
              Icon(isOk ? Icons.check : Icons.cancel, color: isOk ? const Color.fromARGB(255, 245, 160, 94) : Colors.red, size: 16,)
            ]
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if(controller.is_none){
      controller = Option.some(widget.controller);
      isOk = widget.check(controller.value.text);
      controller.value.addListener(() {
        setState(() {
          isOk = widget.check(controller.value.value.text);
          widget.monitior(isOk);
        });
      });
    }
    return build_phone();
  }
}
