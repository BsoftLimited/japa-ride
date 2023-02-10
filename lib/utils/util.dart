import 'package:flutter/material.dart';
class CountryFlag{
    String name, code;

    CountryFlag({required this.name, required this.code});

    static List<CountryFlag> Flags(){
        List<CountryFlag> flags = [
            CountryFlag(name: "af", code: "+93"), CountryFlag(name: "al", code: "+355"), CountryFlag(name: "dz", code: "+213"),
            CountryFlag(name: "as", code: "+1-684"), CountryFlag(name: "ad", code: "+376"), CountryFlag(name: "ao", code: "+244"),
            CountryFlag(name: "ai", code: "+1-264"), CountryFlag(name: "aq", code: "+672"), CountryFlag(name: "ag", code: "+1-268"),
            CountryFlag(name: "ar", code: "+54"), CountryFlag(name: "am", code: "+374"), CountryFlag(name: "aw", code: "+297"),
            CountryFlag(name: "au", code: "+61"), CountryFlag(name: "at", code: "+43"), CountryFlag(name: "az", code: "+994"),

            CountryFlag(name: "bs", code: "+1-242"), CountryFlag(name: "bh", code: "+973"), CountryFlag(name: "bd", code: "880"),
            CountryFlag(name: "bb", code: "+1-246"), CountryFlag(name: "by", code: "+375"), CountryFlag(name: "be", code: "+32"),
            CountryFlag(name: "bz", code: "+501"), CountryFlag(name: "bj", code: "+229"), CountryFlag(name: "bm", code: "+1-441"),
            CountryFlag(name: "bt", code: "+975"), CountryFlag(name: "bo", code: "+591"), CountryFlag(name: "ba", code: "+387"),
            CountryFlag(name: "bw", code: "+267"), CountryFlag(name: "br", code: "+55"), CountryFlag(name: "io", code: "+246"),

            CountryFlag(name: "vg", code: "+1-284"), CountryFlag(name: "bn", code: "+673"), CountryFlag(name: "bg", code: "+359"),
            CountryFlag(name: "bf", code: "+226"), CountryFlag(name: "bi", code: "+257"), CountryFlag(name: "kh", code: "+855"),
            CountryFlag(name: "cm", code: "+237"), CountryFlag(name: "ca", code: "+1"), CountryFlag(name: "cv", code: "+238"),
            CountryFlag(name: "ky", code: "+1-345"), CountryFlag(name: "cf", code: "+	236"), CountryFlag(name: "td", code: "+235"),
            CountryFlag(name: "cl", code: "+56"), CountryFlag(name: "cn", code: "+86"), CountryFlag(name: "cx", code: "+61"),

            CountryFlag(name: "cc", code: "+61"), CountryFlag(name: "co", code: "+57"), CountryFlag(name: "km", code: "+269"),
            CountryFlag(name: "ck", code: "+682"), CountryFlag(name: "cr", code: "+376"), CountryFlag(name: "hr", code: "+385"),
            CountryFlag(name: "cu", code: "+53"), CountryFlag(name: "cw", code: "+599"), CountryFlag(name: "cy", code: "+357"),
            CountryFlag(name: "cz", code: "+420"), CountryFlag(name: "cd", code: "+243"), CountryFlag(name: "dk", code: "+45"),
            CountryFlag(name: "dj", code: "+253"), CountryFlag(name: "dm", code: "+1-767"), CountryFlag(name: "do", code: "+1-809"),
        ];
        return flags;
    }
}
class Util{
    static String get HomeUri => "http://localhost/japa-server/api/";
    static String mapAPIKey = "";
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