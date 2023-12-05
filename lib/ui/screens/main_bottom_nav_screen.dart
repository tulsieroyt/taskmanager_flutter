import 'package:flutter/material.dart';
import 'package:taskmanager_flutter/ui/screens/cancelled_tasks_screen.dart';
import 'package:taskmanager_flutter/ui/screens/completed_tasks_screen.dart';
import 'package:taskmanager_flutter/ui/screens/new_tasks_screen.dart';
import 'package:taskmanager_flutter/ui/screens/progress_tasks_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedItem = 0;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedItem],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedItem,
        onTap: (index) {
          _selectedItem = index;
          setState(() {});
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'New task'),
          BottomNavigationBarItem(
              icon: Icon(Icons.change_circle_outlined), label: 'In Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.cancel), label: 'Cancelled'),
        ],
      ),
    );
  }
}
