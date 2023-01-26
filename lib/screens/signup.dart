import 'package:flutter/material.dart';
import 'package:japa/components/input.dart';
import 'package:japa/components/signup_input.dart';

class SignupForm extends StatefulWidget{
    @override
    State<StatefulWidget> createState() => SignupFormState();
}

class SignupFormState extends State<SignupForm>{
    TextEditingController fullName = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController password = TextEditingController();

    bool check(String text){
        return false;
    }

    void monitor(bool correct){

    }

    @override
    Widget build(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  SignUpInput(hint: "Full Name", inputType: TextInputType.name, check: check, monitior: monitor,  controller: fullName),
                  const SizedBox(width: 10,),
                  SignUpInput(hint: "Email Address", inputType: TextInputType.emailAddress, check: check, monitior: monitor,  controller: email),
                  const SizedBox(height: 15,),
                  SignUpInput(hint: "Phone", inputType: TextInputType.phone, check: check, monitior: monitor,  controller: phone),
                  const SizedBox(height: 15,),
                  SignUpInput(hint: "Password", inputType: TextInputType.visiblePassword, check: check, monitior: monitor,  controller: password),
              ],
          ),
        );
    }
}

class Signup extends StatelessWidget{
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text("Register", style: TextStyle(color: Colors.white70),)),
            body: Center(child: SignupForm()),
        );
    }
}