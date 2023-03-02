import 'package:japa/services/service.dart';

class DriversService extends Service {
  DriversService({required super.listener}): super(host: "drivers/all.php");
}