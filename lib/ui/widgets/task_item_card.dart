import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager_flutter/data/modals/task.dart';
import 'package:taskmanager_flutter/ui/controllers/task_item_card_controller.dart';

//todo-1 : delete Task API integration
//todo-1 : completed

//todo-2 : Update TaskList and SummaryCard after update TaskStatus
//todo-2: completed

enum TaskStatus { New, Progress, Completed, Cancelled }

class TaskItemCard extends StatefulWidget {
  const TaskItemCard({
    super.key,
    required this.task,
    required this.onStatusChange,
    required this.showProgress,
  });

  final Task task;
  final VoidCallback onStatusChange;
  final Function(bool) showProgress;

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  final _taskItemCardController = Get.find<TaskItemCardController>();

  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);
    final response = await _taskItemCardController.updateTaskStatus(
        widget.task.sId ?? '', status);
    if (response) {
      widget.onStatusChange();
    }
    widget.showProgress(false);
  }

  Future<void> deleteTask() async {
    widget.showProgress(true);
    final response =
        await _taskItemCardController.deleteTask(widget.task.sId ?? '');
    if (response) {
      widget.onStatusChange();
    }
    widget.showProgress(false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title ?? '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(widget.task.description ?? ''),
            Text('Date: ${widget.task.createdDate}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task.status ?? 'New',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor:
                      _getChipBackgroundColor(widget.task.status ?? ''),
                ),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: deleteTask,
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: showUpdateStatusModel,
                      icon: const Icon(
                        Icons.edit,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getChipBackgroundColor(String status) {
    switch (status) {
      case 'New':
        return Colors.blue;
      case 'Progress':
        return Colors.orangeAccent;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void showUpdateStatusModel() {
    List<ListTile> items = TaskStatus.values
        .map(
          (e) => ListTile(
            title: Text(e.name),
            onTap: () {
              updateTaskStatus(e.name);
              Get.back();
            },
          ),
        )
        .toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: items,
          ),
          actions: [
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
