import 'package:flutter/material.dart';
import 'package:japa/components/code_input.dart';
import 'package:japa/components/input.dart';

class RecoveryState extends State<Recovery>{
  TextEditingController controller = TextEditingController();

  void validate(){
    setState(() {
      widget.number = "07087952034";
    });
  }

  Widget build_form(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgotten Password", style: TextStyle(color: const Color.fromARGB(255, 245, 160, 94), fontWeight: FontWeight.w400, letterSpacing: 1.3)),
        leading: Row(children: [
          IconButton(onPressed: (){ Navigator.pop(context); }, iconSize: 22, icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 245, 160, 94),)),
          SizedBox(width: 2,),
          Icon(Icons.phonelink_lock_outlined, size: 26, color: const Color.fromARGB(255, 245, 160, 94),),
        ],),
        leadingWidth: 70,
        backgroundColor: Colors.white, elevation: 1,),
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
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Input(hint: "Email", icon: Icons.email, color: const Color.fromARGB(255, 245, 160, 94), controller: controller),
              ),
              const SizedBox(height: 15,),
              Center(
                child: MaterialButton(onPressed: validate,
                  child: Padding( padding: EdgeInsets.only(left: 40, right:  40, top: 14, bottom: 14), child: Text("Reset Password", style: TextStyle(color: Colors.white),)),
                  color: const Color.fromARGB(255, 245, 160, 94),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
            ],),
        ),
      ),
    );
  }

  Widget build_verification(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Verify Phone Number", style: TextStyle(color: const Color.fromARGB(255, 245, 160, 94), fontWeight: FontWeight.w400, letterSpacing: 1.3)),
          leading: Row(children: [
            IconButton(onPressed: (){ Navigator.pop(context); }, iconSize: 22, icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 245, 160, 94),)),
            SizedBox(width: 2,),
            Icon(Icons.lock_clock_outlined, size: 26, color: const Color.fromARGB(255, 245, 160, 94),),
          ],),
          leadingWidth: 70,
          backgroundColor: Colors.white, elevation: 1,),
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
              SizedBox(height: 5,),
              Center(child: Text("OTP  Verification", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),)),
              SizedBox(height: 20,),
              Center(
                child: Text("Enter the OTP sent to ${widget.number}",
                  style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              ),
              SizedBox(height: 10,),
              Center(child: CodeInput()),
              SizedBox(height: 15,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn’t receive OTP?", style: TextStyle(fontSize: 14),),
                    TextButton(onPressed: () =>{ }, child: const Text("RESEND", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)),]
              ),
              const SizedBox(height: 15,),
              MaterialButton(onPressed: ()=>{},
                  color: const Color.fromARGB(255, 245, 160, 94),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 40, right:  40, top: 14, bottom: 14),
                    child: Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  )),
            ],),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return widget.number == null ? build_form(context) : build_verification(context);
  }
}

class Recovery extends StatefulWidget{
  String? number;

  @override
  State<StatefulWidget> createState() => RecoveryState();
}