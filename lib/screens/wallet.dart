import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Wallet extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => __WalletState();
}

class __WalletState extends State<Wallet>{
    late ScrollController __scrollController;
    static const kExpandedHeight = 160.0;

    bool get __isSliverAppBarExpanded {
        return __scrollController.hasClients && __scrollController.offset > kExpandedHeight - kToolbarHeight;
    }

    @override
    void initState() {
        super.initState();
        __scrollController = ScrollController()..addListener(() {
              setState(() {});
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: CustomScrollView( controller: __scrollController,
                physics: const BouncingScrollPhysics( parent: AlwaysScrollableScrollPhysics()),
                slivers: <Widget>[
                SliverAppBar(
                    iconTheme: const IconThemeData(color: Colors.white),
                    title: Text('Wallet', style: TextStyle(color: Colors.white, fontSize: 16),),
                    leadingWidth: 20,
                    pinned: true, snap: false, floating: false, expandedHeight: kExpandedHeight,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0))),
                    flexibleSpace: __isSliverAppBarExpanded ? null : FlexibleSpaceBar(
                        centerTitle: true,
                        title: Column(mainAxisAlignment: MainAxisAlignment.end, mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("\u20A6 2000.00", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                                SizedBox(height: 8,),
                                IconButton(onPressed: (){}, icon: Icon(Icons.visibility_off, size: 12, color: Colors.white,))
                              ],
                            ),
                            Text("Current Balance", style: TextStyle(color: Colors.white, fontSize: 8)),
                        ],),
                        stretchModes: const <StretchMode>[StretchMode.zoomBackground, StretchMode.blurBackground, StretchMode.fadeTitle],
                    // ClipRRect added here for rounded corners
                        background: ClipRRect(
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
                            child: Container(color: const Color.fromARGB(255, 245, 160, 94),))
                    ),
                ),

                SliverList(delegate: SliverChildBuilderDelegate((_, int index) {
                    return ListTile(
                        leading: Container(margin: const EdgeInsets.all(8.0),
                            color: Colors.primaries[Random().nextInt(Colors.primaries.length)], padding: const EdgeInsets.all(8), width: 100),
                        title: Text('Place ${index + 1}', textScaleFactor: 1.5));
                    },childCount: 20),
                ),
            ]),
        );
    }
}