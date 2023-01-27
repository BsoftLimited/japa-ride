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
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    SignUpInput(hint: "Full Name", information: "Your followed by your surname. example John Smith", inputType: TextInputType.name, check: check, monitior: monitor,  controller: fullName),
                    const SizedBox(height: 12,),
                    SignUpInput(hint: "Email Address", information: "Your email addres must be valid", inputType: TextInputType.emailAddress, check: check, monitior: monitor,  controller: email),
                    const SizedBox(height: 12,),
                    SignUpInput(hint: "Phone", information: "Your Phone must be active", inputType: TextInputType.phone, check: check, monitior: monitor,  controller: phone),
                    const SizedBox(height: 12,),
                    SignUpInput(hint: "Password", information: "Must contain leters, number and atleast one symbol", inputType: TextInputType.visiblePassword, check: check, monitior: monitor,  controller: password),
                    const SizedBox(height: 12,),
                    Container(alignment: AlignmentDirectional.topCenter,
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                          children: [
                              Checkbox(value: false, onChanged:(value)=>{}),
                              Text("Agree to our", style: TextStyle(fontSize: 12),),
                              TextButton(onPressed: ()=>{}, child: Text("Terms and Conditions", style: TextStyle(fontSize: 12),)),
                          ],
                        ),
                    ),
                    const SizedBox(height: 12,),
                    MaterialButton(onPressed: ()=>{},
                        child: Padding( padding: EdgeInsets.only(left: 30, right:  30, top: 10, bottom: 10), child: Text("submit", style: TextStyle(color: Colors.white70),)),
                        color: const Color.fromARGB(255, 245, 160, 94),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    const SizedBox(height: 5,),
                    Container(alignment: AlignmentDirectional.topCenter,
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                Text("Already have an account", style: TextStyle(fontSize: 12),),
                                TextButton(onPressed: ()=>{ Navigator.pop(context) }, child: Text("login", style: TextStyle(fontSize: 12),)),
                            ],
                        ),
                    ),
                ],
            ),
          ),
        );
    }
}

class Signup extends StatelessWidget{
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text("Register", style: TextStyle(color: Colors.white70),)),
            body: SafeArea( child: Center( child: SignupForm())),
        );
    }
}