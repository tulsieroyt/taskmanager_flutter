import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager_flutter/ui/controllers/cancelled_tasks_controller.dart';
import 'package:taskmanager_flutter/ui/widgets/profile_summary_card.dart';
import 'package:taskmanager_flutter/ui/widgets/task_item_card.dart';

///todo- fetching cancelled task via calling api
///todo-completed

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CancelledTaskController>().getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: GetBuilder<CancelledTaskController>(
                  builder: (cancelledTaskController) {
                return Visibility(
                  visible: cancelledTaskController.getCancelledTaskInProgress ==
                      false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: cancelledTaskController.getCancelledTaskList,
                    child: ListView.builder(
                      itemCount: cancelledTaskController
                              .taskListModel.taskList?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return TaskItemCard(
                          task: cancelledTaskController
                              .taskListModel.taskList![index],
                          onStatusChange: () {
                            cancelledTaskController.getCancelledTaskList;
                          },
                          showProgress: (inProgress) {},
                        );
                      },
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
