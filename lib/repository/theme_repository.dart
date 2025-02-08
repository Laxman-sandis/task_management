import 'package:hive/hive.dart';
import 'package:task_management_app/models/theme_model.dart';

class ThemeRepository {
  static const String _themeBox = 'themeBox';
  static const String _themeKey = 'selectedTheme';

  Future<void> saveTheme(AppTheme theme) async {
    final box = await Hive.openBox(_themeBox);
    await box.put(_themeKey, theme.index);
  }

  Future<AppTheme> getTheme() async {
    final box = await Hive.openBox(_themeBox);
    int? themeIndex = box.get(_themeKey);
    return themeIndex != null ? AppTheme.values[themeIndex] : AppTheme.light;
  }
}
