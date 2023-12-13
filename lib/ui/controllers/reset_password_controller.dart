import 'package:get/get.dart';
import 'package:taskmanager_flutter/data/network_caller/network_caller.dart';
import 'package:taskmanager_flutter/data/network_caller/network_response.dart';
import 'package:taskmanager_flutter/data/utility/urls.dart';

class ResetPasswordController extends GetxController {
  bool _resetPasswordInProgress = false;
  String _failedMessage = '';

  bool get resetPasswordInProgress => _resetPasswordInProgress;

  String get failedMessage => _failedMessage;

  Future<bool> resetPassword(String email, String otp, String password) async {
    _resetPasswordInProgress = true;
    update();

    Map<String, dynamic> resetPasswordData = {
      "email": email,
      "OTP": otp,
      "password": password
    };

    final NetworkResponse response = await NetworkCaller()
        .postRequest(Urls.resetPassword, body: resetPasswordData);

    _resetPasswordInProgress = false;
    update();

    if (response.isSuccess) {
      if (response.jsonResponse['status'] == 'success') {
        return true;
      } else {
        _failedMessage = 'Password reset failed! Try again';
        return false;
      }
    }
    return false;
  }
}
