import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:japa/models/autocomplate_prediction.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile({Key? key, required this.autocompletePrediction, required this.onclicked}) : super(key: key);

  final AutocompletePrediction autocompletePrediction;
  final void Function() onclicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           SvgPicture.asset("res/search_icon.svg", width: 24,),
           SizedBox(width: 5,),
           Expanded(child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.start,
             mainAxisSize: MainAxisSize.min,
             children: [
               TextButton(
                 onPressed: onclicked,
                 style: ButtonStyle(alignment: Alignment.topRight),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.start,
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Text(autocompletePrediction.structuredFormatting!.mainText!, style: TextStyle(fontSize: 16, color: Colors.black45, fontWeight: FontWeight.bold),),
                     SizedBox(height: 8,),
                     Text(autocompletePrediction.structuredFormatting!.secondaryText!,  maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12,  color: Colors.black45),),
                     SizedBox(height: 10,),
                   ],
                 ),
               ),
               const Divider(height: 0.4, thickness: 0.4, color: Colors.black38),
             ],
           )),
        ],
      ),
    );
  }
}
