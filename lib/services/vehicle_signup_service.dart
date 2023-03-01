import 'package:japa/services/service.dart';

class VehicleSignUpService extends Service{
  VehicleSignUpService({required super.listener}): super(host: "users/make_driver.php");
}