// lib/screens/teacher_home.dart
import 'package:flutter/material.dart';
import 'session_page.dart';
import 'package:smart_attendance/screens/login_page.dart';
import 'package:hive/hive.dart';

class TeacherHomePage extends StatefulWidget {
  final String teacherName; // teacher info from login
  const TeacherHomePage({super.key, required this.teacherName});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  // Sample data for all classes
  final List<Map<String, dynamic>> allClasses = [
    {'name': 'CS-A', 'students': 30, 'teacher': 'Alice'},
    {'name': 'CS-B', 'students': 28, 'teacher': 'Bob'},
    {'name': 'EE-A', 'students': 32, 'teacher': 'Alice'},
    {'name': 'ME-A', 'students': 25, 'teacher': 'Charlie'},
  ];

  List<Map<String, dynamic>> teacherClasses = [];

  @override
  void initState() {
    super.initState();
    // Filter classes for the logged-in teacher
    teacherClasses = allClasses
        .where((c) => c['teacher'] == widget.teacherName)
        .toList();
  }

  void _openSession(String className) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SessionPage(className: className),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text("Welcome, ${widget.teacherName}"),
  backgroundColor: const Color(0xFF3B82F6),
  elevation: 2,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
  actions: [
    IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Logout',
      onPressed: () {
              Hive.box('appBox').delete('userData');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: teacherClasses.length,
          itemBuilder: (_, index) {
            final classData = teacherClasses[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                title: Text(
                  classData['name'],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  "${classData['students']} students enrolled",
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
                trailing: ElevatedButton(
                  onPressed: () => _openSession(classData['name']),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Open"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
