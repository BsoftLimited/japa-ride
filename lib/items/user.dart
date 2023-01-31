import "dart:convert" show json;
import "package:japa/items/item.dart";

class User extends Item{
    String name, surname, username, number, email;

    User({required this.name, required this.surname, required this.username, required this.number, required this.email});
    User.from(Map<String, dynamic> data): this(name: data["name"], surname: data["surname"], username: data["username"], number: data["number"], email: data["email"]);
    User.parse(String data): this.from(json.decode(data));
}