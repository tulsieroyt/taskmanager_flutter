import 'package:get/get.dart';
import 'package:taskmanager_flutter/data/network_caller/network_caller.dart';
import 'package:taskmanager_flutter/data/network_caller/network_response.dart';
import 'package:taskmanager_flutter/data/utility/urls.dart';

import '../../data/modals/task_list_model.dart';

class CompletedTaskController extends GetxController {
  bool _getCompletedTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCompletedTaskInProgress => _getCompletedTaskInProgress;

  TaskListModel get taskListModel => _taskListModel;

  Future<void> getCompletedTaskList() async {
    _getCompletedTaskInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCompletedTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }

    _getCompletedTaskInProgress = false;
    update();
  }
}
