import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:japa/items/time.dart';

class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({required String time, LocaleType? locale}) : super(locale: locale) {
    CustomTime customTime = CustomTime.parse(time);
    this.currentTime = DateTime(2023, 9, 7, customTime.hours, customTime.mins, 12);
    this.setLeftIndex(this.currentTime.hour);
    this.setMiddleIndex(this.currentTime.minute);
    this.setRightIndex(this.currentTime.hour % 2);
  }

  @override
  String? leftStringAtIndex(int index) {
    if(index == 0){
       return "12";
    }else if(index > 12 ){
        return "${index - 12}";
    }
    return "${index}";
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  // TODO: implement rightList
  List<String> get rightList => ["AM", "PM"];

  @override
  String? rightStringAtIndex(int index) {
      return index % 2 == 0 ? "PM" : "AM";
  }

  @override
  String leftDivider() => ":";

  @override
  String rightDivider() => "";

  @override
  List<int> layoutProportions() => [1, 1, 1];

  @override
  DateTime finalTime() {
    int hours = this.currentLeftIndex() + (this.currentRightIndex() % 2 == 0 ? 12 : 0);
    return currentTime.isUtc ? DateTime.utc(
        currentTime.year, currentTime.month,
        currentTime.day, hours,
        this.currentMiddleIndex(),
        this.currentRightIndex())
        : DateTime(
        currentTime.year, currentTime.month,
        currentTime.day, hours,
        this.currentMiddleIndex(),
        this.currentRightIndex());
  }
}