import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:japa/components/input.dart';
import 'package:japa/utils/util.dart';

class LoginForm extends StatefulWidget {
    const LoginForm({super.key});

    @override
    State<StatefulWidget> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
    Option<TextEditingController> usernameController = Option.none();
    Option<TextEditingController> passwordController = Option.none();

    void login(){

    }

    void toLogin(){

    }
  
    @override
    Widget build(BuildContext context) {
        if(usernameController.is_none){
            usernameController = Option.some(TextEditingController());
        }

        if(passwordController.is_none){
            passwordController = Option.some(TextEditingController());
        }

        return Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
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
                    MaterialButton(onPressed: login, 
                        color: const Color.fromARGB(255, 245, 160, 94),
                        child: const Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 12, right: 30, left: 30),
                            child: Text("Login", style: TextStyle(color: Colors.white,
                    )),
                        )),
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

class Login extends StatelessWidget {
    const Login({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text("Login"), titleTextStyle: const TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.w500),),
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
