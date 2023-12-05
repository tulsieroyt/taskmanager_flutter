import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taskmanager_flutter/data/network_caller/network_caller.dart';
import 'package:taskmanager_flutter/data/network_caller/network_response.dart';
import 'package:taskmanager_flutter/data/utility/urls.dart';
import 'package:taskmanager_flutter/ui/screens/login_screen.dart';
import 'package:taskmanager_flutter/ui/screens/pin_verification_screen.dart';
import 'package:taskmanager_flutter/ui/widgets/body_background.dart';
import 'package:taskmanager_flutter/ui/widgets/snack_message.dart';

//todo-RecoverVerifyEmail integration
//todo-completed

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool recoverVerifyEmailInProgress = false;

  Future<void> recoverVerifyEmail(String email) async {
    recoverVerifyEmailInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.recoverVerifyEmail(email));
    if (response.isSuccess) {
      if (response.jsonResponse['status'] == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PinVerificationScreen(
              email: email,
            ),
          ),
        );
      } else {
        if (mounted) {
          showSnackMessage(context, 'Email is not found! Check your email');
        }
      }
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const ForgotPasswordScreen(),
          ),
          (route) => false);
    }
    recoverVerifyEmailInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Your Email Address',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text(
                      'A 6 digit verification pin will send to your email address.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
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
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: recoverVerifyEmailInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              recoverVerifyEmail(
                                  _emailTEController.text.trim());
                            }
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have account?",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false);
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _validateEmailAddress(String input) {
    const emailRegex =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    return RegExp(emailRegex).hasMatch(input);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
