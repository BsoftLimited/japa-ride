import 'package:flutter/material.dart';

class AccountSettings extends StatefulWidget{
    @override
    State<StatefulWidget> createState() => __AccountSettingsState();
}

class __AccountSettingsState extends State<AccountSettings>{
    @override
    Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Row(
              children: [
                Icon(Icons.manage_accounts_rounded, color: Colors.white,),
                SizedBox(width: 4,),
                Text("Account Settings", style: TextStyle(color: Colors.white, fontSize: 14),),
              ],
            ),
            leading: IconButton(
                visualDensity: VisualDensity(horizontal: -4, vertical:  -4),
                onPressed: (){ Navigator.pop(context); }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 8, left: 8),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CircleAvatar(backgroundImage: AssetImage("res/ceo.jpg"), radius: 30.0,),
                    ),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text("Okelekle Nobel", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
                      SizedBox(height: 4,),
                      Text("+2347087952034", style: TextStyle(fontSize: 12)),
                      SizedBox(height: 4,),
                      Text("okelekelenobel@gmail.com", style: TextStyle(fontSize: 12)),
                    ],)),
                    TextButton(onPressed: (){  }, child: Row(children: [
                      CircleAvatar( child: Icon(Icons.edit_outlined, size: 15, color: Colors.white), radius: 14,),
                    ],)),
                  ],),
                ),
              Divider(),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("Manage Trusted Contacts", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),),
                    SizedBox(height: 8),
                    Text("share your trip status with your loved onve s ina single tap", style: TextStyle(fontSize: 10, color: Colors.black87),),
                  ],),
                ), onPressed: (){},
              ),
              Divider(),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("Verify Your Ride", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),),
                    SizedBox(height: 8),
                    Text("use a PIN to make sure you get right car", style: TextStyle(fontSize: 10, color: Colors.black87),),
                  ],),
                ), onPressed: (){},
              ),
              Divider(),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("Notification", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),),
                    SizedBox(height: 8),
                    Text("Manage your ride notication ", style: TextStyle(fontSize: 10, color: Colors.black87),),
                  ],),
                ), onPressed: (){},
              ),
              Divider(),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("Edit  Profile", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),),
                    SizedBox(height: 8),
                    Text("edit your profile", style: TextStyle(fontSize: 10, color: Colors.black87),),
                  ],),
                ), onPressed: (){},
              ),
              Divider(),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("Change Password", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),),
                    SizedBox(height: 8),
                    Text("change your pin", style: TextStyle(fontSize: 10, color: Colors.black87),),
                  ],),
                ), onPressed: (){},
              ),
              Divider(),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("Fund Wallet", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),),
                    SizedBox(height: 8),
                    Text("fund your wallet by using your  ATM CARD or transfr", style: TextStyle(fontSize: 10, color: Colors.black87),),
                  ],),
                ), onPressed: (){ Navigator.pushNamed(context, "/main/wallet"); },
              ),
              Divider(),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("Security", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),),
                    SizedBox(height: 8),
                    Text("control your account security", style: TextStyle(fontSize: 10, color: Colors.black87),),
                  ],),
                ), onPressed: (){},
              ),
              Divider(),
            ],),
          ),
        );
    }
}