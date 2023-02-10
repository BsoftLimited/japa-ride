import 'package:japa/services/service.dart';

class VerificationService extends Service{
    VerificationService({required super.listener}): super(host: "gist/users/verify");
}