import 'package:flutter/material.dart';
import 'package:taskmanager_flutter/data/modals/task_list_model.dart';
import 'package:taskmanager_flutter/data/network_caller/network_caller.dart';
import 'package:taskmanager_flutter/data/network_caller/network_response.dart';
import 'package:taskmanager_flutter/data/utility/urls.dart';
import 'package:taskmanager_flutter/ui/widgets/profile_summary_card.dart';
import 'package:taskmanager_flutter/ui/widgets/task_item_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool getProgressTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getProgressTaskList() async {
    getProgressTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getInProgressTask);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }

    getProgressTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: Visibility(
                visible: getProgressTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getProgressTaskList,
                  child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: taskListModel.taskList![index],
                        onStatusChange: () {
                          getProgressTaskList();
                        },
                        showProgress: (inProgress) {
                          getProgressTaskInProgress = inProgress;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
