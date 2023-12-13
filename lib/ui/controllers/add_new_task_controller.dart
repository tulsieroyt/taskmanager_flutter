import 'package:get/get.dart';
import 'package:taskmanager_flutter/data/network_caller/network_caller.dart';
import 'package:taskmanager_flutter/data/network_caller/network_response.dart';
import 'package:taskmanager_flutter/data/utility/urls.dart';

class AddNewTaskController extends GetxController {
  bool _createTaskInProgress = false;
  String _failedMessage = '';

  bool get createTaskInProgress => _createTaskInProgress;

  String get failedMessage => _failedMessage;

  Future<bool> createNewTask(String title, String description) async {
    _createTaskInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.createTask,
        body: {"title": title, "description": description, "status": "New"});
    _createTaskInProgress = false;
    update();
    if (response.isSuccess) {
      if (response.jsonResponse['status'] == 'success') {
        return true;
      } else {
        _failedMessage = 'Email is not found! Check your email';
      }
      _failedMessage = 'New task added successfully.';
      return true;
    } else {
      _failedMessage = 'Create new task failed! Try again';
    }
    return false;
  }
}
