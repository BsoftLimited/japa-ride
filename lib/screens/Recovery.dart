import 'package:flutter/material.dart';
import 'package:japa/components/code_input.dart';
import 'package:japa/components/input.dart';

class RecoveryForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => RecoveryFormState();
}

class RecoveryFormState extends State<RecoveryForm>{
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgotten Password", style: TextStyle(color: Colors.white70),)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right:  20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Icon(Icons.lock_person_outlined, size: 120, color: const Color.fromARGB(255, 245, 160, 94), )),
              SizedBox(height: 12,),
              Text("Dont’s Worry! Just Enter Your Email  Address Below. And  We’ll send you the password rest intruction",
                style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              SizedBox(height: 32,),
              Text("Enter your registration email address",
                style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Input(hint: "Email", icon: Icons.email, color: const Color.fromARGB(255, 245, 160, 94), controller: controller),
              ),
              const SizedBox(height: 15,),
              Center(
                child: MaterialButton(onPressed: ()=>{},
                  child: Padding( padding: EdgeInsets.only(left: 30, right:  30, top: 10, bottom: 10), child: Text("Reset Password", style: TextStyle(color: Colors.white70),)),
                  color: const Color.fromARGB(255, 245, 160, 94),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
            ],),
        ),
      ),
    );
  }
}

class RecoveryVerificationState extends State<RecoveryVerification>{
  TextEditingController codeOne = TextEditingController();
  TextEditingController codeTwo = TextEditingController();
  TextEditingController codeThree = TextEditingController();
  TextEditingController codeFour = TextEditingController();
  TextEditingController codeFive = TextEditingController();
  TextEditingController codeSix = TextEditingController();
  List<int> code = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Verify Phone Number", style: TextStyle(color: Colors.white70),)),
    body: SafeArea(
      child: Column(
        children: [
          SizedBox(height: 30,),
          Center(
            child: Text("A code as been sent to your phone number",
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          ),
          SizedBox(height: 8,),
          Center(child: Image.asset("res/phone.png", width: 200,),),
          SizedBox(height: 24,),
          Center(
            child: Text("Enter the OTP sent to 08168192868",
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          ),
          SizedBox(height: 10,),
          Center(child: Row(mainAxisSize: MainAxisSize.min, children: [
            CodeInput(),
            SizedBox(width: 10,),
            CodeInput(),
            SizedBox(width: 10,),
            CodeInput(),
            SizedBox(width: 10,),
            CodeInput(),
            SizedBox(width: 10,),
            CodeInput(),
            SizedBox(width: 10,),
            CodeInput(),
          ]))
        ],),
    ));
  }
}

class RecoveryVerification extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => RecoveryVerificationState();
}

class Recovery extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return RecoveryVerification();
  }
}