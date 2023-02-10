import "dart:convert" show json;

abstract class Item{
  String serialize() => json.encode(this);
}