import 'package:flutter/material.dart';
import 'package:taskmanager_flutter/data/network_caller/network_caller.dart';
import 'package:taskmanager_flutter/data/utility/urls.dart';
import 'package:taskmanager_flutter/ui/widgets/profile_summary_card.dart';
import 'package:taskmanager_flutter/ui/widgets/task_item_card.dart';

import '../../data/modals/task_list_model.dart';
import '../../data/network_caller/network_response.dart';

///todo- fetching cancelled task via calling api
///todo-completed

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool getCanceledTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getCanceledTaskList() async {
    getCanceledTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCancelledTask);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }

    getCanceledTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getCanceledTaskList();
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
                visible: getCanceledTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getCanceledTaskList,
                  child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: taskListModel.taskList![index],
                        onStatusChange: () {
                          getCanceledTaskList();
                        },
                        showProgress: (inProgress) {
                          getCanceledTaskInProgress = inProgress;
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
