import 'package:get/get.dart';
import 'package:taskmanager_flutter/data/network_caller/network_caller.dart';
import 'package:taskmanager_flutter/data/network_caller/network_response.dart';
import 'package:taskmanager_flutter/data/utility/urls.dart';
import 'package:taskmanager_flutter/ui/screens/forgot_password_screen.dart';
import 'package:taskmanager_flutter/ui/screens/pin_verification_screen.dart';

class ForgotPasswordController extends GetxController {
  bool _recoverVerifyEmailInProgress = false;

  bool get recoverVerifyEmailInProgress => _recoverVerifyEmailInProgress;

  Future<bool> recoverVerifyEmail(String email) async {
    _recoverVerifyEmailInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.recoverVerifyEmail(email));
    _recoverVerifyEmailInProgress = false;
    update();

    if (response.isSuccess) {
      if (response.jsonResponse['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
