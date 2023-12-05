import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanager_flutter/data/modals/user_model.dart';
import 'package:taskmanager_flutter/data/network_caller/network_caller.dart';
import 'package:taskmanager_flutter/data/network_caller/network_response.dart';
import 'package:taskmanager_flutter/data/utility/urls.dart';
import 'package:taskmanager_flutter/ui/controllers/auth_controller.dart';
import 'package:taskmanager_flutter/ui/widgets/body_background.dart';
import 'package:taskmanager_flutter/ui/widgets/profile_summary_card.dart';
import 'package:taskmanager_flutter/ui/widgets/snack_message.dart';

//todo-adding form validation on update profile
//todo-completed

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _fNameTEController = TextEditingController();
  final TextEditingController _lNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool updateProfileInProgress = false;
  XFile? photo;

  @override
  void initState() {
    super.initState();
    _emailTEController.text = AuthController.user?.email ?? '';
    _fNameTEController.text = AuthController.user?.firstName ?? '';
    _lNameTEController.text = AuthController.user?.lastName ?? '';
    _mobileTEController.text = AuthController.user?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(
              enableOnTap: false,
            ),
            Expanded(
              child: BodyBackground(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          'Update Profile',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        photoPickerField(),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _emailTEController,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                          ),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Enter your email';
                            }
                            if (!_validateEmailAddress(value!)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _fNameTEController,
                          decoration: const InputDecoration(
                            hintText: 'First Name',
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter your first Name';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _lNameTEController,
                          decoration: const InputDecoration(
                            hintText: 'Last Name',
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter your last Name';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _mobileTEController,
                          decoration: const InputDecoration(
                            hintText: 'Mobile',
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter your mobile number';
                            }
                            if (value.length < 11) {
                              return 'Enter correct mobile number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _passwordTEController,
                          decoration: const InputDecoration(
                            hintText: 'Password (Optional)',
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: updateProfileInProgress == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                              onPressed: updateProfile,
                              child: const Text(
                                'Update',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
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
          ],
        ),
      ),
    );
  }

  bool _validateEmailAddress(String input) {
    const emailRegex =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    return RegExp(emailRegex).hasMatch(input);
  }

  Future<void> updateProfile() async {
    updateProfileInProgress = true;
    if (mounted) {
      setState(() {});
    }
    String? photoInBase64;
    Map<String, dynamic> inputData = {
      "email": _emailTEController.text.trim(),
      "firstName": _fNameTEController.text.trim(),
      "lastName": _lNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim()
    };
    if (_passwordTEController.text.isNotEmpty) {
      inputData['password'] = _passwordTEController.text;
    }
    if (photo != null) {
      List<int> imageBytes = await photo!.readAsBytes();
      photoInBase64 = base64Encode(imageBytes);
      inputData['photo'] = photoInBase64;
    }
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.updateProfile, body: inputData);

    updateProfileInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      AuthController.updateUserInformation(UserModel(
          email: _emailTEController.text.trim(),
          firstName: _fNameTEController.text.trim(),
          lastName: _lNameTEController.text.trim(),
          mobile: _mobileTEController.text.trim(),
          photo: photoInBase64 ?? AuthController.user?.photo));
      if (mounted) {
        showSnackMessage(context, 'Profile update successfully');
      }
    } else {
      if (mounted) {
        showSnackMessage(context, 'Update profile failed!');
      }
    }
  }

  Container photoPickerField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Photos',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () async {
                final XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  imageQuality: 50,
                );
                if (image != null) {
                  photo = image;
                  if (mounted) {
                    setState(() {});
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Visibility(
                    visible: photo == null,
                    replacement: Text(photo?.name ?? ''),
                    child: const Text('Select a photo')),
              ),
            ),
          )
        ],
      ),
    );
  }
}
