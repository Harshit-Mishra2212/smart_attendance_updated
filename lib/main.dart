// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'screens/login_page.dart';
// import 'screens/student/student_home.dart';
// import 'screens/teacher/teacher_home.dart'; 

// import 'screens/admin/admin_page.dart';
// import 'theme.dart';

// void main() {
//   runApp(const SmartAttendApp());
// }

// class SmartAttendApp extends StatelessWidget {
//   const SmartAttendApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SmartAttend',
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.lightTheme,
//       initialRoute: '/',
//       routes: {
//         '/': (_) => const LoginPage(),
//         '/student': (_) => const StudentHomePage(),
//         '/teacher': (_) {
//           // For now, passing a placeholder teacher name
//           return const TeacherHomePage(teacherName: "Alice");
//         },
//         '/admin': (_) => const AdminPage(),
//       },
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'screens/login_page.dart';
// import 'screens/student/student_home.dart';
// import 'screens/teacher/teacher_home.dart';
// import 'screens/admin/admin_page.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // initialize Hive and open the app box
//   await Hive.initFlutter();
//   await Hive.openBox('appBox');

//   final box = Hive.box('appBox');
//   final user = box.get('userData'); // will be null if not stored

//   runApp(MyApp(initialUser: user));
// }

// class MyApp extends StatelessWidget {
//   final Map? initialUser;
//   const MyApp({super.key, this.initialUser});

//   @override
//   Widget build(BuildContext context) {
//     Widget home;
//     if (initialUser == null) {
//       home = const LoginPage();
//     } else {
//       final role = initialUser['role'] as String? ?? '';
//       if (role == 'Teacher') {
//         home = TeacherHomePage(teacherName: initialUser['name'] ?? 'Teacher');
//       } else if (role == 'Student') {
//         home = const StudentHomePage();
//       } else {
//         home = const AdminPage();
//       }
//     }

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'SmartAttend',
//       home: home,
//     );
//   }
// }



// lib/main.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/login_page.dart';
import 'screens/student/student_home.dart';
import 'screens/teacher/teacher_home.dart';
import 'screens/admin/admin_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize Hive and open the app box
  await Hive.initFlutter();
  await Hive.openBox('appBox');

  final box = Hive.box('appBox');
  final user = box.get('userData'); // will be null if not stored

  runApp(MyApp(initialUser: user));
}

class MyApp extends StatelessWidget {
  final Map? initialUser;
  const MyApp({super.key, this.initialUser});

  @override
  Widget build(BuildContext context) {
    Widget home;
    if (initialUser == null) {
      home = const LoginPage();
    } else {
      final role = initialUser?['role'] as String? ?? '';
      if (role == 'Teacher') {
        home = TeacherHomePage(
          teacherName: initialUser?['name'] ?? 'Teacher',
        );
      } else if (role == 'Student') {
        home = const StudentHomePage();
      } else {
        home = const AdminPage();
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartAttend',
      home: home,
    );
  }
}