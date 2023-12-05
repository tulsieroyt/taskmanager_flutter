import 'package:flutter/material.dart';
import 'package:taskmanager_flutter/data/modals/task_count.dart';
import 'package:taskmanager_flutter/data/modals/task_list_model.dart';
import 'package:taskmanager_flutter/data/modals/task_summary_count_list_model.dart';
import 'package:taskmanager_flutter/data/network_caller/network_caller.dart';
import 'package:taskmanager_flutter/data/network_caller/network_response.dart';
import 'package:taskmanager_flutter/data/utility/urls.dart';
import 'package:taskmanager_flutter/ui/screens/add_new_task_screen.dart';
import 'package:taskmanager_flutter/ui/widgets/profile_summary_card.dart';
import 'package:taskmanager_flutter/ui/widgets/summary_card.dart';
import 'package:taskmanager_flutter/ui/widgets/task_item_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool getNewTaskInProgress = false;
  bool getTaskSummaryCountInProgress = false;
  TaskListModel taskListModel = TaskListModel();
  TaskSummaryCountListModel taskSummaryCountListModel =
      TaskSummaryCountListModel();

  void refreshData() {
    getTaskSummaryCountList();
    getNewTaskList();
  }

  Future<void> getNewTaskList() async {
    getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskList);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }

    getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getTaskSummaryCountList() async {
    getTaskSummaryCountInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskSummaryCountList);
    if (response.isSuccess) {
      taskSummaryCountListModel =
          TaskSummaryCountListModel.fromJson(response.jsonResponse);
    }

    getTaskSummaryCountInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getTaskSummaryCountList();
    getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Visibility(
              visible: getTaskSummaryCountInProgress == false &&
                  (taskSummaryCountListModel.taskCountList?.isNotEmpty ??
                      false),
              replacement: const Center(
                child: LinearProgressIndicator(),
              ),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      taskSummaryCountListModel.taskCountList?.length ?? 0,
                  itemBuilder: (context, index) {
                    TaskCount taskCount =
                        taskSummaryCountListModel.taskCountList![index];
                    return FittedBox(
                      child: SummaryCard(
                        count: taskCount.sum.toString(),
                        title: taskCount.sId ?? '',
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: getNewTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getNewTaskList,
                  child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: taskListModel.taskList![index],
                        onStatusChange: () {
                          getTaskSummaryCountList();
                          getNewTaskList();
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        showProgress: (inProgress) {
                          getNewTaskInProgress = inProgress;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewTaskScreen(
                refreshData: refreshData,
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
