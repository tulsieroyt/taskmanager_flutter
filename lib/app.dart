import 'package:flutter/material.dart';
import 'package:taskmanager_flutter/ui/controllers/add_new_task_controller.dart';
import 'package:taskmanager_flutter/ui/controllers/auth_controller.dart';
import 'package:taskmanager_flutter/ui/controllers/cancelled_tasks_controller.dart';
import 'package:taskmanager_flutter/ui/controllers/completed_tasks_controller.dart';
import 'package:taskmanager_flutter/ui/controllers/edit_profile_controller.dart';
import 'package:taskmanager_flutter/ui/controllers/forgot_password_controller.dart';
import 'package:taskmanager_flutter/ui/controllers/login_controller.dart';
import 'package:taskmanager_flutter/ui/controllers/main_bottom_nav_controller.dart';
import 'package:taskmanager_flutter/ui/controllers/new_task_controller.dart';
import 'package:taskmanager_flutter/ui/controllers/pin_verification_controller.dart';
import 'package:taskmanager_flutter/ui/controllers/progress_tasks_controller.dart';
import 'package:taskmanager_flutter/ui/controllers/reset_password_controller.dart';
import 'package:taskmanager_flutter/ui/controllers/sign_up_controller.dart';
import 'package:taskmanager_flutter/ui/controllers/task_item_card_controller.dart';
import 'package:taskmanager_flutter/ui/screens/splash_screen.dart';
import 'package:get/get.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
        useMaterial3: false,
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
      ),
      initialBinding: ControllerBinder(),
    );
  }
}

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(LoginController());
    Get.put(NewTaskController());
    Get.put(ProgressTaskController());
    Get.put(CompletedTaskController());
    Get.put(CancelledTaskController());
    Get.put(AddNewTaskController());
    Get.put(ForgotPasswordController());
    Get.put(EditProfileController());
    Get.put(PinVerificationController());
    Get.put(ResetPasswordController());
    Get.put(SignUpController());
    Get.put(MainBottomNavController());
    Get.put(TaskItemCardController());
  }
}
