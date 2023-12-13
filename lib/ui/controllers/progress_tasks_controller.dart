import 'package:get/get.dart';
import 'package:taskmanager_flutter/data/modals/task_list_model.dart';
import 'package:taskmanager_flutter/data/network_caller/network_caller.dart';
import 'package:taskmanager_flutter/data/network_caller/network_response.dart';
import 'package:taskmanager_flutter/data/utility/urls.dart';

class ProgressTaskController extends GetxController {
  bool _getProgressTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getProgressTaskInProgress => _getProgressTaskInProgress;

  TaskListModel get taskListModel => _taskListModel;

  Future<void> getProgressTaskList() async {
    _getProgressTaskInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getInProgressTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }

    _getProgressTaskInProgress = false;
    update();
  }
}
