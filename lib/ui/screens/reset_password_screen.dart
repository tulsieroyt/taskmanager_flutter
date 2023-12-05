import 'package:flutter/material.dart';
import 'package:taskmanager_flutter/data/network_caller/network_caller.dart';
import 'package:taskmanager_flutter/data/network_caller/network_response.dart';
import 'package:taskmanager_flutter/data/utility/urls.dart';
import 'package:taskmanager_flutter/ui/screens/login_screen.dart';
import 'package:taskmanager_flutter/ui/widgets/body_background.dart';
import 'package:taskmanager_flutter/ui/widgets/snack_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen(
      {super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool resetPasswordInProgress = false;

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
                      'Set Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text(
                      'Minimum length password 8 character with latter and number combination ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPasswordTEController,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password again';
                        }
                        if (value != _passwordTEController.text) {
                          return 'Password not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: resetPasswordInProgress == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              resetPassword();
                            }
                          },
                          child: const Text(
                            'Confirm',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
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

  Future<void> resetPassword() async {
    resetPasswordInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> resetPasswordData = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _passwordTEController.text
    };

    final NetworkResponse response = await NetworkCaller()
        .postRequest(Urls.resetPassword, body: resetPasswordData);

    resetPasswordInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      if (response.jsonResponse['status'] == 'success') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      } else {
        if (mounted) {
          showSnackMessage(context, 'Password reset failed! Try again');
        }
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResetPasswordScreen(email: widget.email, otp: widget.otp),
        ),
      );
    }
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
