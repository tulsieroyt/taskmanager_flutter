import 'package:get/get.dart';
import 'package:taskmanager_flutter/data/network_caller/network_caller.dart';
import 'package:taskmanager_flutter/data/network_caller/network_response.dart';
import 'package:taskmanager_flutter/data/utility/urls.dart';

class PinVerificationController extends GetxController {
  bool _recoverVerifyOTP = false;

  bool get recoverVerifyOTP => _recoverVerifyOTP;

  Future<bool> recoverVerityOTP(String otp, String email) async {
    _recoverVerifyOTP = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.recoverVerifyOTP(email, otp));

    _recoverVerifyOTP = false;
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
