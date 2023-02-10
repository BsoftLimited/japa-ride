import 'package:japa/services/service.dart';

class InitService extends Service {
  InitService({required super.listener}): super(host: "init.php");
}