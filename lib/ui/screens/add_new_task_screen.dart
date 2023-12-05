import 'package:flutter/material.dart';
import 'package:taskmanager_flutter/data/network_caller/network_caller.dart';
import 'package:taskmanager_flutter/data/network_caller/network_response.dart';
import 'package:taskmanager_flutter/data/utility/urls.dart';
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
  bool _createTaskInProgress = false;

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
                            child: Visibility(
                              visible: _createTaskInProgress == false,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: ElevatedButton(
                                onPressed: createNewTask,
                                child: const Icon(
                                  Icons.arrow_circle_right_outlined,
                                ),
                              ),
                            ),
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
    if (_fromKey.currentState!.validate()) {
      _createTaskInProgress = true;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.createTask, body: {
        "title": _subjectTEController.text.trim(),
        "description": _descriptionTEController.text.trim(),
        "status": "New"
      });
      _createTaskInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        _subjectTEController.clear();
        _descriptionTEController.clear();
        if (mounted) {
          showSnackMessage(context, 'New task added successfully.');
          //Adding refresh callback function to update list after adding new Task
          widget.refreshData();
          Navigator.pop(
              context); //After successfully adding task this screen will pop
        }
      } else {
        if (mounted) {
          showSnackMessage(context, 'Create new task failed! Try again', true);
        }
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
