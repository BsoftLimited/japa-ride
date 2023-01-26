import 'package:japa/services/service.dart';

class SignUpService extends Service{
    SignUpService({required super.listener}): super(host: "signup.php");
}