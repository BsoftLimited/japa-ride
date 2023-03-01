class CustomTime{
    late int hours, mins;
    late String faction;

    CustomTime({required this.hours, required this.mins, required this.faction});
    CustomTime.parse(String data){
        List<String> init = data.split(":");
        this.hours = int.parse(init[0]);
        this.mins = int.parse(init[1]);
        this.faction = hours >= 12 ? "PM" : "AM";
    }

    CustomTime.from(DateTime dateTime){
        this.hours = dateTime.hour;
        this.mins = dateTime.minute;
        this.faction = hours >= 12 ? "PM" : "AM";
    }

    @override
  String toString() {
      int initHours = faction == "PM" ? hours + 12 : hours;
      return "${initHours}:${mins}";
  }
}