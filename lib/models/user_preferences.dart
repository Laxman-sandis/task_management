import 'package:hive/hive.dart';

class UserPreferences {
  final Box _box = Hive.box('settings');

  bool get isDarkMode => _box.get('darkMode', defaultValue: false);
  void setDarkMode(bool value) => _box.put('darkMode', value);

  String get sortOrder => _box.get('sortOrder', defaultValue: 'date');
  void setSortOrder(String order) => _box.put('sortOrder', order);
}
