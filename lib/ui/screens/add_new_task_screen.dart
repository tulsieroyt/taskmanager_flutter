import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager_flutter/ui/controllers/add_new_task_controller.dart';
import 'package:taskmanager_flutter/ui/widgets/body_background.dart';
import 'package:taskmanager_flutter/ui/widgets/profile_summary_card.dart';
import 'package:taskmanager_flutter/ui/widgets/snack_message.dart';

//todo-1 : adding validation on title and description field
//todo-1 : completed

//todo-2: update taskList and SummaryCard after adding new task
//todo-2: completed

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key, required this.refreshData});

  final Function refreshData;

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final _addNewTaskController = Get.find<AddNewTaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: BodyBackground(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _fromKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Add New Task',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _subjectTEController,
                            //wrong controller name,
                            decoration: const InputDecoration(
                              hintText: 'Title',
                            ),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter your Title';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            maxLines: 8,
                            controller: _descriptionTEController,
                            decoration: const InputDecoration(
                              hintText: 'Descriptions',
                            ),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter Description';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: GetBuilder<AddNewTaskController>(
                                builder: (addNewTaskController) {
                              return Visibility(
                                visible:
                                    addNewTaskController.createTaskInProgress ==
                                        false,
                                replacement: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                child: ElevatedButton(
                                  onPressed: createNewTask,
                                  child: const Icon(
                                    Icons.arrow_circle_right_outlined,
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> createNewTask() async {
    if (!_fromKey.currentState!.validate()) {
      return;
    }
    final response = await _addNewTaskController.createNewTask(
      _subjectTEController.text.trim(),
      _descriptionTEController.text.trim(),
    );

    if (response) {
      _subjectTEController.clear();
      _descriptionTEController.clear();
      if (mounted) {
        showSnackMessage(context, 'New Task Added Successfully.');
        widget.refreshData();
        Get.back();
      }
    } else {
      if (mounted) {
        showSnackMessage(context, _addNewTaskController.failedMessage, true);
      }
    }
  }

  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
