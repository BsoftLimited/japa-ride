import 'package:japa/services/service.dart';

class LoginService extends Service {
  LoginService({required super.listener}): super(host: "login.php");
}