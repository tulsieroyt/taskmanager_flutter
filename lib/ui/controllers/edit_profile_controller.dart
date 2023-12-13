import 'package:get/get.dart';
import 'package:taskmanager_flutter/data/modals/user_model.dart';
import 'package:taskmanager_flutter/data/network_caller/network_caller.dart';
import 'package:taskmanager_flutter/data/network_caller/network_response.dart';
import 'package:taskmanager_flutter/data/utility/urls.dart';
import 'package:taskmanager_flutter/ui/controllers/auth_controller.dart';

class EditProfileController extends GetxController {
  bool _updateProfileInProgress = false;
  String _failedMessage = '';

  bool get updateProfileInProgress => _updateProfileInProgress;

  String get failedMessage => _failedMessage;

  Future<bool> updateProfile(
      String email, String fName, String lName, String mobile,
      [String? photo, String? password]) async {
    Map<String, dynamic> inputData = {
      "email": email,
      "firstName": fName,
      "lastName": lName,
      "mobile": mobile,
    };
    if (password!.isNotEmpty) {
      inputData['password'] = password;
    }
    if (photo != null) {
      inputData['photo'] = photo;
    }
    _updateProfileInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.updateProfile, body: inputData);

    _updateProfileInProgress = false;
    update();
    if (response.isSuccess) {
      Get.find<AuthController>().updateUserInformation(UserModel(
          email: email,
          firstName: fName,
          lastName: lName,
          mobile: mobile,
          photo: photo ?? Get.find<AuthController>().user?.photo));
      _failedMessage = 'Profile update successfully';
      return true;
    } else {
      _failedMessage = 'Update profile failed!';
    }
    return false;
  }
}
