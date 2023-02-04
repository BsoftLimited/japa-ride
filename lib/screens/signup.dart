import 'package:flutter/material.dart';
import 'package:japa/components/signup_input.dart';
import 'package:japa/fragments/Status.dart';
import 'dart:developer';
import "dart:convert" show json;

import 'package:japa/screens/loading.dart';
import 'package:japa/services/signup_service.dart';
import 'package:japa/utils/util.dart';

enum SignupAs{ Client, Driver }

class SignupForm extends StatefulWidget{
    @override
    State<StatefulWidget> createState() => SignupFormState();
}

class SignupFormState extends State<SignupForm>{
    TextEditingController fullName = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController username = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController password = TextEditingController();

    bool isNameOk = false, isUsernameOk = false, isEmailOk = false, isPhoneOk = false, isPasswordOk = false, isOk = false;

    SignupAs? __as = SignupAs.Driver;
    bool agreed = false;

    void changeAs(SignupAs? value){
        setState(() {
          __as = value;
        });
    }

    void check(){
        bool init = isNameOk && isUsernameOk && isEmailOk && isPhoneOk && isPasswordOk && agreed;
        if(init != isOk){
          setState(() { isOk = init; });
        }
    }

    void signup(){
        Loading.Start(context: context, message: "Registration in progress");
        Map<String, String> params = {
            "name" : fullName.value.text,
            "email" : email.value.text,
            "phone" : phone.value.text.replaceAll(" ", ""),
            "user_type" : __as == SignupAs.Client ? "client" : "driver",
            "username" : username.value.text,
            "password" : password.value.text };

        SignUpService service = SignUpService(listener: (suceeded, response){
          Loading.Stop(context);
          if(suceeded){
              Navigator.pushReplacementNamed(context, "/main");
          }else{
              Map<String, dynamic> init = json.decode(response)[0];
              Status.Start(context: context, status: suceeded, message: JsonHelper.getString(init["message"]));
          }
          log("$response");
        });
        service.start(params: params);
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
                    Row(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Text("Sign up as: "),
                        SizedBox(width: 100,
                          child: ListTile(
                              title: Row(children: <Widget>[
                                      Radio(value: SignupAs.Driver, groupValue: __as, onChanged: changeAs, ),
                                      Text('Driver', style: TextStyle(fontSize: 12),),
                                  ],
                              ))),
                        SizedBox(width: 100,
                            child: ListTile(
                                title: Row(children: <Widget>[
                                    Radio(value: SignupAs.Client, groupValue: __as, onChanged: changeAs, ),
                                    Text('Client', style: TextStyle(fontSize: 12),),
                                ],
                                ))),
                    ],),
                    SignUpInput(
                        hint: "Full Name", information: "Your followed by your surname. example John Smith",
                        inputType: TextInputType.name, controller: fullName,
                        monitior: (value){
                            isNameOk = value;
                            check();
                        },
                        check: (value){
                            return value.contains(" ") &&  value.indexOf(' ') != value.length - 1;
                        }
                    ),
                    const SizedBox(height: 15,),
                    SignUpInput(
                        hint: "Email Address", information: "Your email addres must be valid",
                        inputType: TextInputType.emailAddress, controller: email,
                        monitior: (value){
                          isEmailOk = value;
                          check();
                        },
                        check: (value){
                            return RegExp(r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}').hasMatch(value);
                        }
                    ),
                    const SizedBox(height: 15,),
                    SignUpInput(
                        hint: "Username", information: "Username must be atleast 5 characters long",
                        inputType: TextInputType.text, controller: username,
                        monitior: (value){
                          isUsernameOk = value;
                          check();
                        },
                        check: (value){
                          return value.length >= 5;
                        }
                    ),
                  const SizedBox(height: 15,),
                    SignUpInput(
                        hint: "Phone", information: "Your Phone must be active", inputType: TextInputType.phone, controller: phone,
                        monitior: (value){
                          isPhoneOk = value;
                          check();
                        },
                        check: (value){
                            return value.length  > 7;
                        }
                    ),
                    const SizedBox(height: 15,),
                    SignUpInput(
                        hint: "Password", information: "Must contain leters, number and atleast one symbol", inputType: TextInputType.visiblePassword, controller: password,
                        monitior: (value){
                          isPasswordOk = value;
                          check();
                        },
                        check: (value){
                            return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}').hasMatch(value);
                        }
                    ),
                    const SizedBox(height: 15,),
                    Container(alignment: AlignmentDirectional.topStart,
                        child: TextButton( onPressed: (){ setState((){ agreed = !agreed; }); },
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                            children: [
                                Checkbox(value: agreed, onChanged:(value){ setState((){ agreed = !agreed; check(); }); },),
                                Text("Agree to our", style: TextStyle(fontSize: 12),),
                                Text("Terms and Conditions", style: TextStyle(fontSize: 12),),
                            ],
                          ),
                        ),
                    ),
                    const SizedBox(height: 15,),
                    MaterialButton(onPressed: isOk ? signup : null,
                        child: Padding( padding: EdgeInsets.only(left: 30, right:  30, top: 10, bottom: 10), child: Text("submit", style: TextStyle(color: Colors.white70),)),
                        color: const Color.fromARGB(255, 245, 160, 94), disabledColor: Colors.brown,
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

class Signup extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => __SigupState();
}

class __SigupState extends State<Signup>{
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text("Registration", style: TextStyle(color: const Color.fromARGB(255, 245, 160, 94), fontWeight: FontWeight.w400, letterSpacing: 1.3)),
              leading: Row(children: [
                  IconButton(onPressed: (){ Navigator.pop(context); }, iconSize: 22, icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 245, 160, 94),)),
                SizedBox(width: 2,),
                Icon(Icons.account_circle, size: 26, color: const Color.fromARGB(255, 245, 160, 94),),
              ],),
              leadingWidth: 70,
              backgroundColor: Colors.white, elevation: 1,),
            body: SafeArea( child: Center( child: SignupForm())),
        );
    }
}