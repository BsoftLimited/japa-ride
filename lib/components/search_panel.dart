import 'package:flutter/material.dart';
import 'package:japa/components/location_list_tile.dart';
import 'package:japa/components/panel.dart';
import 'package:japa/models/autocomplate_prediction.dart';
import 'package:japa/models/place_auto_complate_response.dart';
import 'package:japa/utils/network_util.dart';
import 'package:japa/utils/util.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SearchPanel extends StatefulWidget{
    PanelController panelController;
    Function(AutocompletePrediction) onSelected;
    Function() onTap;
    Selecting selecting;

    SearchPanel({required this.onTap, required this.onSelected, required this.panelController, required this.selecting});

    @override
    State<StatefulWidget> createState() =>  SearchPanelState();
}

class SearchPanelState extends State<SearchPanel>{
  TextEditingController __searchController = TextEditingController();
  int __searchIndex = 0;
  List<AutocompletePrediction> placePredictions = [];

  @override
  void initState() {
    super.initState();
    __searchController = TextEditingController();
    __searchController.addListener(() {
      if(__searchController.value.text.isEmpty && __searchIndex == 1){
        setState(() { __searchIndex = 0; });
      }else if(__searchController.value.text.isNotEmpty && __searchIndex == 1){
        setState(() { __searchIndex = 0; });
      }
    });
  }

  void palceAutocomplate(String query) async{
      Uri uri = Uri.https("maps.googleapis.com", "maps/api/place/autocomplete/json", { "input" : query, "key" : Util.mapAPIKey });
      String? response = await NetworkUtil.fetchUri(uri);
      if(response != null){
          PlaceAutocompleteResponse  result = PlaceAutocompleteResponse.parseAutocompleteResult(response);
          if(result.predictions != null){
              setState(() { placePredictions = result.predictions!; });
          }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8, top: 12),
      child: Column(
        children: [
          TextField( autofocus: true,
            style: TextStyle( fontSize: 14), controller: __searchController,
            onTap: widget.onTap,
            onChanged: (value){ palceAutocomplate(value); },
            decoration: InputDecoration(
                hintText: widget.selecting == Selecting.Destination ? "Where do you want to go to ?" : "Where would you like to be picked up ?",
                prefixIcon: Icon(Icons.search, size: 18,),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
          SizedBox(height: 8,),
          Expanded(
            child: IndexedStack(
              index: __searchIndex,
              children: [
                Center(child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(children: [
                    Image.asset("res/location_search.png", width: 180, height: 200,),
                    SizedBox(height: 5,),
                    Text("No Search Made", style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.2, fontSize: 18, color: Colors.black54)),
                  ]),
                )),
                Container(
                  child: ListView.builder(itemBuilder: (context, index) =>LocationListTile(
                      press: () => widget.onSelected(placePredictions[index]),
                      location: placePredictions[index].description!,
                  ), itemCount: placePredictions.length,),
                )
              ],),
          ),
        ],
      ),
    );
  }
  
}