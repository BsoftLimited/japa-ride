import 'package:flutter/material.dart';
import 'package:japa/components/input.dart';
import 'package:japa/utils/util.dart';

class SignUpInput extends StatefulWidget{
  final String hint;
  final IconData? iconData;
  final TextInputType inputType;
  final bool Function(String) check;
  final void Function(bool) monitior;
  final TextEditingController controller;

  SignUpInput({required this.hint, this.iconData, required this.inputType, required this.check, required this.controller, required this.monitior});

  @override
  State<StatefulWidget> createState() => SignUpInputState();
}

class SignUpInputState extends State<SignUpInput>{
  bool isOk = false, isEqual = false;
  Option<TextEditingController> controller = Option.none();
  Option<TextEditingController> recontroller = Option.none();

  Widget build_normal(){
    return Row(
      children: [
        Expanded(child: Input(hint: widget.hint, icon: widget.iconData, controller: controller.value, inputType: widget.inputType)),
        const SizedBox(width: 5),
        Icon(isOk ? Icons.check : Icons.cancel, color: isOk ? const Color.fromARGB(255, 245, 160, 94) : Colors.red, size: 20,)
      ],
    );
  }

  Widget build_password(){
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Input(hint: "Password", icon: widget.iconData, controller: controller.value, inputType: widget.inputType)),
            const SizedBox(width: 5),
            Icon(isOk ? Icons.check : Icons.cancel, color: isOk ? const Color.fromARGB(255, 245, 160, 94) : Colors.red, size: 20,)
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(child: Input(hint: "Re-Enter password", icon: widget.iconData, controller: recontroller.value, inputType: widget.inputType)),
            const SizedBox(width: 5),
            Icon(isEqual ? Icons.check : Icons.cancel, color: isEqual ? const Color.fromARGB(255, 245, 160, 94) : Colors.red, size: 20,)
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
        isOk = widget.check(controller.value.value.text);
        if(widget.inputType == TextInputType.visiblePassword) {
          isEqual = controller.value.value.text == recontroller.value.value.text;
        }
        widget.inputType == TextInputType.visiblePassword ? widget.monitior(isEqual && isOk) : widget.monitior(isOk);
      });
    }

    if(widget.inputType == TextInputType.visiblePassword && recontroller.is_none){
      recontroller = Option.some(TextEditingController());
      isEqual = controller.value.value.text == recontroller.value.value.text;
      recontroller.value.addListener(() {
        isEqual = controller.value.value.text == recontroller.value.value.text;
        widget.monitior(isEqual && isOk);
      });
    }

    return widget.inputType == TextInputType.visiblePassword ? build_password() : build_normal();
  }
}