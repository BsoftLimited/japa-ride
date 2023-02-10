import 'dart:developer';
import "dart:convert" show json;

import 'package:flutter/material.dart';
import 'package:japa/components/input.dart';
import 'package:japa/fragments/Status.dart';
import 'package:japa/items/data.dart';
import 'package:japa/screens/loading.dart';
import 'package:japa/services/login_service.dart';
import 'package:japa/utils/util.dart';

class LoginForm extends StatefulWidget {
    const LoginForm({super.key});

    @override
    State<StatefulWidget> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
    Option<TextEditingController> usernameController = Option.none();
    Option<TextEditingController> passwordController = Option.none();
    bool isReady = false;

    void login(){
      Loading.Start(context: context, message: "Login in, please wait");
      Map<String, String> params = { "username" : usernameController.value.value.text, "password" : passwordController.value.value.text };

      LoginService service = LoginService(listener: (suceeded, response, request){
          Loading.Stop(context);
          if(suceeded){
              Data.initialize(context, response);
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
        if(usernameController.is_none){
            usernameController = Option.some(TextEditingController());
            usernameController.value.addListener(() {
              bool init = usernameController.value.value.text.isNotEmpty && passwordController.value.value.text.isNotEmpty;
              if(init != isReady){
                setState(() { isReady = init; });
              }
            });
        }

        if(passwordController.is_none){
            passwordController = Option.some(TextEditingController());
            passwordController.value.addListener(() {
              bool init = usernameController.value.value.text.isNotEmpty && passwordController.value.value.text.isNotEmpty;
              if(init != isReady){
                setState(() { isReady = init; });
              }
            });
        }

        return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                    Input(hint: "Username", icon: Icons.person, color: const Color.fromARGB(255, 245, 160, 94), controller: usernameController.value),
                    const SizedBox(height: 15,),
                    Input(hint: "Password", icon: Icons.lock, inputType: TextInputType.visiblePassword, color: const Color.fromARGB(255, 245, 160, 94) , controller: passwordController.value),
                  const SizedBox(height: 3,),
                  Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: TextButton(onPressed: ()=>{ Navigator.pushNamed(context, "/recovery") }, child: Text("Forgotten password ?", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),))),
                  const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                              onPressed: isReady ? (){
                                  log("submit pressed");
                                  login();
                              } : null,
                              color: const Color.fromARGB(255, 245, 160, 94),
                              disabledColor: Colors.brown,
                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0) ),
                              child: const Padding(
                                  padding: EdgeInsets.only(top: 12, bottom: 12, right: 30, left: 30),
                                  child: Text("Login", style: TextStyle(color: Colors.white,
                          )),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row( 
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            const Text("do not have an account ?", style: TextStyle(fontSize: 14),),
                            TextButton(onPressed: () =>{ Navigator.pushNamed(context, "/signup") }, child: const Text("register", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)),]
                    ),
          ]),
        );
    }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => __LoginState();
}

class __LoginState extends State<Login>{
    @override
    Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: const Text("Login", style: TextStyle(color: const Color.fromARGB(255, 245, 160, 94), fontWeight: FontWeight.w400, letterSpacing: 1.3)),
            leading: Icon(Icons.account_circle, size: 26, color: const Color.fromARGB(255, 245, 160, 94),),
            leadingWidth: 70,
            backgroundColor: Colors.white, elevation: 1,),
            body: Center(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        Image.asset("res/logo.png", width: 100,),
                        const SizedBox(height: 10,),
                        const Text("Japa Ride", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                        const SizedBox(height: 15),
                        const LoginForm(),
                    ],),
                ),
        );
    }
}
