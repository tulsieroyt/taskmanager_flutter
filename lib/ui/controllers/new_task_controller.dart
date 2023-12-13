import 'package:get/get.dart';
import 'package:taskmanager_flutter/data/modals/task_list_model.dart';
import 'package:taskmanager_flutter/data/modals/task_summary_count_list_model.dart';
import 'package:taskmanager_flutter/data/network_caller/network_caller.dart';
import 'package:taskmanager_flutter/data/network_caller/network_response.dart';
import 'package:taskmanager_flutter/data/utility/urls.dart';

class NewTaskController extends GetxController {
  bool _getNewTaskInProgress = false;
  bool _getTaskSummaryCountInProgress = false;
  TaskListModel _taskListModel = TaskListModel();
  TaskSummaryCountListModel _taskSummaryCountListModel =
      TaskSummaryCountListModel();

  bool get getNewTaskInProgress => _getNewTaskInProgress;

  bool get getTaskSummaryCountInProgress => _getTaskSummaryCountInProgress;

  TaskListModel get taskListModel => _taskListModel;

  TaskSummaryCountListModel get taskSummaryCountListModel =>
      _taskSummaryCountListModel;

  ///Function to getNewTask from API
  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _getNewTaskInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskList);
    _getNewTaskInProgress = false;
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }

  Future<void> getTaskSummaryCountList() async {
    _getTaskSummaryCountInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskSummaryCountList);
    if (response.isSuccess) {
      _taskSummaryCountListModel =
          TaskSummaryCountListModel.fromJson(response.jsonResponse);
    }

    _getTaskSummaryCountInProgress = false;
    update();
  }


  void refreshData() {
    getNewTaskList();
    getTaskSummaryCountList();
  }
}
