import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:japa/utils/util.dart';

class Cards extends StatefulWidget{
  const Cards({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CardsState();
  }
  
}
class CardsState extends State<Cards>{
    Option<List<Widget>> __carosel_items = Option.none();
    CarouselController __controller = CarouselController();
    int __index = 0;
  
    List<Widget> __init_carosel_items(){
        if(__carosel_items.is_none){
            __carosel_items = Option.some([
                Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width, margin: EdgeInsets.symmetric(horizontal: 10.0), 
                    decoration: BoxDecoration( color: Colors.transparent), 
                    child: Center(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                          Expanded(child: Image.asset("res/destination.png")),
                          Text("We provide professional transportation services to you", textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w400, letterSpacing: 1.4),)
                        ],),
                    )
                ),
                Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width, margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration( color: Colors.transparent),
                    child: Center(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                        Expanded(child: Image.asset("res/trip.png",)),
                        Text("Your satisfaction is our number one priority", textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w400, letterSpacing: 1.4),)
                      ],),
                    )
                ),
                Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width, margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration( color: Colors.transparent),
                    child: Center(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                        Expanded(child: Image.asset("res/world.png")),
                        Text("Moving from one place to another has never been more convenient.", textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w400, letterSpacing: 1.4),)
                      ],),
                    )
                ),
          ]);
      }
      return __carosel_items.value;
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  SafeArea(
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(child: Column(
              children: [
                CarouselSlider(
                    options: CarouselOptions(
                        enableInfiniteScroll: false,
                        reverse: false,
                        autoPlay: false,
                        height: 460,
                        viewportFraction: 1.0),
                    carouselController: __controller,
                    items: __init_carosel_items()
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: __carosel_items.value.asMap().entries.map((entry) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 245, 160, 94).withOpacity(__index == entry.key ? 0.9 : 0.3)),
                    );
                  }).toList(),
                ),
              ],
            ),),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  color: const Color.fromARGB(255, 245, 160, 94), onPressed: () {
                if(__index < 2){
                  setState(() {
                    __index += 1;
                    __controller.animateToPage( __index, duration: Duration(milliseconds: 300));
                  });
                }else{
                  Navigator.pushReplacementNamed(context, '/login');
                }

              }, child: Text( __index < 2 ? "Next" : "Get Started", style: TextStyle(fontWeight: FontWeight.bold),),),
            ),
            SizedBox(height: 30),
          ]),
        )
    );
  }
}