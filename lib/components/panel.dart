import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:japa/components/booking_panel.dart';
import 'package:japa/components/search_panel.dart';
import 'package:japa/models/autocomplate_prediction.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum PanelMode{ Search, Locate}
enum Selecting{ Location, Destination }

class PanelData{
    LatLng? location, destination;
    PanelData({this.location, this.destination});
}

class BPanelController{
    late PanelState __panelState;
    
    
    void openSearch(){
        __panelState.openSearch();
    }
    
    void openLocate(){
        __panelState.openLocate();
    }

    void __setPanelState(PanelState panelState){
        __panelState = panelState;
    }
}

class Panel extends StatefulWidget{
    PanelController panelController;
    BPanelController bPanelController;
    LatLng? currentLocation;
    PanelMode? initMode;
    Selecting? initSelecting;
    LatLng? location, destination;

    Panel({required this.bPanelController, required this.panelController, required this.currentLocation, this.initMode, this.initSelecting, this.destination, this.location });

    @override
    State<StatefulWidget> createState() => PanelState();
}

class PanelState extends State<Panel>{
    late PanelMode __mode;
    late Selecting __selecting;


    @override
    void initState() {
        super.initState();
        __mode = widget.initMode == null ? PanelMode.Search: widget.initMode!;
        __selecting = widget.initSelecting == null ?  Selecting.Destination : Selecting.Location;
        widget.bPanelController.__setPanelState(this);
    }

    void searchSelected(AutocompletePrediction prediction){
        if(__selecting == Selecting.Destination){

        }
    }

    void search(Selecting selecting){
        setState(() {__selecting = selecting; __mode = PanelMode.Search; });
    }

    void openSearch(){
        setState(() { __mode = PanelMode.Search; });
        widget.panelController.open();
    }

    void openLocate(){
        setState(() { __mode = PanelMode.Locate; });
        widget.panelController.open();
    }

    @override
    Widget build(BuildContext context) {
        return IndexedStack(
          index: __mode == PanelMode.Search || widget.panelController.isPanelClosed ? 0 : 1,
          children: [
              SearchPanel(panelController: widget.panelController, onSelected: searchSelected, selecting: __selecting, onTap: (){
                  __mode = PanelMode.Search;
                  if(widget.panelController.isPanelClosed ){
                      setState(() { __selecting = Selecting.Destination; });
                      widget.panelController.open();
                  }
              },), BookingPanel(search: search,) ],
        );
    }
}