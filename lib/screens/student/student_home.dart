// // lib/screens/student/student_home.dart
// import 'package:flutter/material.dart';
// import 'attendance_page.dart';

// class StudentHomePage extends StatelessWidget {
//   const StudentHomePage({super.key});

//   // Mock list of classes (replace with backend data later)
//   final List<String> classes = const [
//     "CS-A",
//     "CS-B",
//     "EE-A",
//     "ME-C",
//   ];

//   void _openAttendance(BuildContext context, String className) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => AttendancePage(className: className),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Student Portal")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Your Classes",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.separated(
//                 itemCount: classes.length,
//                 separatorBuilder: (_, __) => const SizedBox(height: 12),
//                 itemBuilder: (_, index) {
//                   final className = classes[index];
//                   return Card(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     elevation: 3,
//                     child: ListTile(
//                       title: Text(className,
//                           style: const TextStyle(fontWeight: FontWeight.w600)),
//                       trailing: const Icon(Icons.arrow_forward_ios),
//                       onTap: () => _openAttendance(context, className),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// last time


// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'attendance_page.dart';
// import 'student_class_graph.dart';
// import 'bot_chat_page.dart'; // Import the bot chat page

// class StudentHomePage extends StatelessWidget {
//   const StudentHomePage({super.key});

//   // Mock list of classes
//   final List<String> classes = const [
//     "CS-A",
//     "CS-B",
//     "EE-A",
//     "ME-C",
//   ];

//   void _openAttendance(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => const AttendancePage(className: "QR Scan"),
//       ),
//     );
//   }

//   void _openClassGraph(BuildContext context, String className) {
//     final rand = Random();
//     int total = rand.nextInt(20) + 5; // total between 5 and 25
//     int present = rand.nextInt(total); // strictly less than total

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => StudentClassGraph(
//           className: className,
//           present: present,
//           total: total,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Student Portal")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Scan QR button at top
//             Center(
//               child: ElevatedButton.icon(
//                 icon: const Icon(Icons.qr_code_scanner),
//                 label: const Text("Scan QR"),
//                 onPressed: () => _openAttendance(context),
//               ),
//             ),
//             const SizedBox(height: 24),

//             const Text(
//               "Your Classes",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),

//             // Class list with tap to graph
//             Expanded(
//               child: ListView.separated(
//                 itemCount: classes.length,
//                 separatorBuilder: (_, __) => const SizedBox(height: 12),
//                 itemBuilder: (_, index) {
//                   final className = classes[index];
//                   return Card(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     elevation: 3,
//                     child: ListTile(
//                       title: Text(
//                         className,
//                         style: const TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                       trailing: const Icon(Icons.bar_chart),
//                       onTap: () => _openClassGraph(context, className),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       // Floating chat button
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.chat),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const BotChatPage()),
//           );
//         },
//       ),
//     );
//   }
// } 
 


 
import 'dart:math';
import 'package:flutter/material.dart';
import 'attendance_page.dart';
import 'student_class_graph.dart';
import 'bot_chat_page.dart'; // Import the bot chat page 
import 'package:hive/hive.dart';
import '../login_page.dart'; // adjust path if needed
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'attendance_page.dart';
// import 'student_class_graph.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  // Mock list of classes
  final List<String> classes = const [
    "CS-A",
    "CS-B",
    "EE-A",
    "ME-C",
  ];

  void _openAttendance(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AttendancePage(className: "QR Scan"),
      ),
    );
  }

  void _openClassGraph(BuildContext context, String className) {
    final rand = Random();
    int total = rand.nextInt(20) + 5; // total between 5 and 25
    int present = rand.nextInt(total); // strictly less than total

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StudentClassGraph(
          className: className,
          present: present,
          total: total,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Portal"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: "Profile",
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Profile clicked")),
              );
            },
          ),
   
          IconButton(
  icon: const Icon(Icons.logout),
  tooltip: "Logout",
  onPressed: () {
    final box = Hive.box('appBox');
    box.delete('userData'); // clear saved user

    // Navigate back to login page and remove all previous screens
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
     );
     },
    ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Scan QR button at top
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text("Scan QR"),
                onPressed: () => _openAttendance(context),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              "Your Classes",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Class list with tap to graph
            Expanded(
              child: ListView.separated(
                itemCount: classes.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, index) {
                  final className = classes[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        className,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(Icons.bar_chart),
                      onTap: () => _openClassGraph(context, className),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}