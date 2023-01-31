import 'package:flutter/material.dart';

class ProfileForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ProfileFormState();
}

class ProfileFormState extends State<ProfileForm>{
  @override
  Widget build(BuildContext context) {
    return Row(children: [],);
  }
}

class EdithProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EdithProfileState();
  }
}

class EdithProfileState extends State<EdithProfile>{
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text("Register", style: TextStyle(color: Colors.white70),)),
        body: SafeArea( child: Center( child: ProfileForm())),
      );
    }
}