import 'package:flutter/material.dart';

class Util{
    static String get HomeUri => "http://192.168.43.194/blimited/api/";
    static String generateUID()=>"uuid";
    static Color get purple => const Color.fromRGBO(108, 99, 255, 1);
    static Color get black => Colors.black54;
    static String TimeSpan(DateTime time){
        DateTime current = DateTime.now();
        if(current.year > time.year){
            return (current.year - time.year == 1) ? "last year" : "${current.year - time.year} years ago";
        }else if(current.month > time.month){
            return (current.month - time.month == 1) ? "last month" : "${current.month - time.month} months ago";
        }else if(current.day > time.day){
            return (current.day - time.day == 1) ? "yesterday" : "${current.day - time.day} days ago";
        }else if(current.hour > time.hour){
            return (current.hour - time.hour == 1) ? "an hour ago" : "${current.hour - time.hour} hours ago";
        }else if (current.minute > time.minute){
            return (current.minute - time.minute == 1) ? "a minute ago" : "${current.minute - time.minute} minutes ago";
        }else if(current.second > time.second){
            return (current.second - time.second == 1) ? "a second ago" : "${current.second - time.second} seconds ago";
        }
        return  "now";
    }
}

class JsonHelper{
    static String getString(Object value)=> value.toString();
    static bool getBoolean(Object value){
        if(value is bool){
          return value as bool;
        }
        return value.toString() == "1" || value.toString() == "true";
    }

    static DateTime getDateTime(Object value){
        if(value is DateTime){
            return value as DateTime;
        }
        return DateTime.parse(value.toString());
    }

    static int getInt(Object value){
        if(value is int){
          return value as int;
        }
        return int.parse(value.toString());
    }

    static double getDouble(Object value){
      if(value is double){
        return value as double;
      }
      return double.parse(value.toString());
    }

    static Map<String, dynamic> getObject(Object value){
        if(value is Map<String, dynamic>){
            return value as  Map<String, dynamic>;
        }
        return {};
    }
}

class Option<T>{
    late T __value;
    bool __is_some = false;

    bool get is_some => __is_some;
    bool get is_none => !__is_some;
    T get value => __value;

    Option.none();
    Option.some(this.__value): __is_some = true;

    set(T value){
        __value = value;
        __is_some = true;
    }
}