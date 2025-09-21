import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HiveService {
static const String _boxName = 'smart_att_box';


static Future<void> init() async {
await Hive.initFlutter();
await Hive.openBox(_boxName);
}


// Save logged-in user info for role: 'teacher'|'admin'|'student'
static Future<void> saveLogin(String role, String id) async {
final box = Hive.box(_boxName);
await box.put('${role}_id', id);
await box.put('${role}_logged_in', true);
}


static String? getLoggedInId(String role) {
final box = Hive.box(_boxName);
return box.get('${role}_logged_in', defaultValue: false) == true
? box.get('${role}_id')
: null;
}


static Future<void> logout(String role) async {
final box = Hive.box(_boxName);
await box.delete('${role}_id');
await box.put('${role}_logged_in', false);
}
}