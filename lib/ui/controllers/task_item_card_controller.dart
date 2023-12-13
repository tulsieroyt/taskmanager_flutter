import 'package:get/get.dart';
import 'package:taskmanager_flutter/data/network_caller/network_caller.dart';
import 'package:taskmanager_flutter/data/utility/urls.dart';

class TaskItemCardController extends GetxController {
  Future<bool> updateTaskStatus(String sId, String status) async {
    final response =
        await NetworkCaller().getRequest(Urls.updateTaskStatus(sId, status));
    if (response.isSuccess) {
      return true;
    }
    return false;
  }

  Future<bool> deleteTask(String sId) async {
    final response = await NetworkCaller().getRequest(Urls.deleteTask(sId));
    if (response.isSuccess) {
      return true;
    }
    return false;
  }
}
