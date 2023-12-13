import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager_flutter/ui/controllers/completed_tasks_controller.dart';
import 'package:taskmanager_flutter/ui/widgets/profile_summary_card.dart';
import 'package:taskmanager_flutter/ui/widgets/task_item_card.dart';

///todo-fetching completed task via calling API with status
///todo-completed

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CompletedTaskController>().getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: GetBuilder<CompletedTaskController>(
                builder: (completedTaskController) {
                  return Visibility(
                    visible:
                        completedTaskController.getCompletedTaskInProgress ==
                            false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: RefreshIndicator(
                      onRefresh: completedTaskController.getCompletedTaskList,
                      child: ListView.builder(
                        itemCount: completedTaskController
                                .taskListModel.taskList?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: completedTaskController
                                .taskListModel.taskList![index],
                            onStatusChange: () {
                              completedTaskController.getCompletedTaskList();
                            },
                            showProgress: (inProgress) {},
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
