import 'package:taskmanager_flutter/ui/widgets/task_item_card.dart';

class Urls {
  static const String _baseUrls = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrls/registration';
  static const String login = '$_baseUrls/login';
  static const String createTask = '$_baseUrls/createTask';

  static String deleteTask(String id) => '$_baseUrls/deleteTask/$id';
  static const String getTaskSummaryCountList = '$_baseUrls/taskStatusCount';
  static const String updateProfile = '$_baseUrls/profileUpdate';
  static String getTaskList =
      '$_baseUrls/listTaskByStatus/${TaskStatus.New.name}';
  static String getInProgressTask =
      '$_baseUrls/listTaskByStatus/${TaskStatus.Progress.name}';
  static String getCompletedTask =
      '$_baseUrls/listTaskByStatus/${TaskStatus.Completed.name}';
  static String getCancelledTask =
      '$_baseUrls/listTaskByStatus/${TaskStatus.Cancelled.name}';

  static String updateTaskStatus(String taskID, String status) =>
      '$_baseUrls/updateTaskStatus/$taskID/$status';

  static String recoverVerifyEmail(String email) =>
      '$_baseUrls/RecoverVerifyEmail/$email';

  static String recoverVerifyOTP(String email, String otp) =>
      '$_baseUrls/RecoverVerifyOTP/$email/$otp';

  static const String resetPassword = '$_baseUrls/RecoverResetPass';
}
