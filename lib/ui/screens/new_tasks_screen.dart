import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager_flutter/data/modals/task_count.dart';
import 'package:taskmanager_flutter/ui/controllers/new_task_controller.dart';
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
  @override
  void initState() {
    super.initState();
    Get.find<NewTaskController>().getNewTaskList();
    Get.find<NewTaskController>().getTaskSummaryCountList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            GetBuilder<NewTaskController>(
              builder: (newTaskSummaryController) {
                return Visibility(
                  visible:
                      newTaskSummaryController.getTaskSummaryCountInProgress ==
                              false &&
                          (newTaskSummaryController.taskSummaryCountListModel
                                  .taskCountList?.isNotEmpty ??
                              false),
                  replacement: const Center(
                    child: LinearProgressIndicator(),
                  ),
                  child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: newTaskSummaryController
                              .taskSummaryCountListModel
                              .taskCountList
                              ?.length ??
                          0,
                      itemBuilder: (context, index) {
                        TaskCount taskCount = newTaskSummaryController
                            .taskSummaryCountListModel.taskCountList![index];
                        return FittedBox(
                          child: SummaryCard(
                            count: taskCount.sum.toString(),
                            title: taskCount.sId ?? '',
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: GetBuilder<NewTaskController>(
                builder: (newTaskController) {
                  return Visibility(
                    visible: newTaskController.getNewTaskInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: RefreshIndicator(
                      onRefresh: () => newTaskController.getNewTaskList(),
                      child: ListView.builder(
                        itemCount:
                            newTaskController.taskListModel.taskList?.length ??
                                0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: newTaskController
                                .taskListModel.taskList![index],
                            onStatusChange: () {
                              newTaskController.getTaskSummaryCountList();
                              newTaskController.getNewTaskList();
                            },
                            showProgress: (inProgress) {},
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            AddNewTaskScreen(
              refreshData: Get.find<NewTaskController>().refreshData,
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
