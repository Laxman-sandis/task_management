import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/theme_model.dart';
import '../repository/theme_repository.dart';

final themeProvider = StateNotifierProvider<ThemeViewModel, AppTheme>((ref) => ThemeViewModel());

class ThemeViewModel extends StateNotifier<AppTheme> {
  final ThemeRepository _themeRepo = ThemeRepository();

  ThemeViewModel() : super(AppTheme.light) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    state = await _themeRepo.getTheme();
  }

  Future<void> toggleTheme() async {
    state = state == AppTheme.light ? AppTheme.dark : AppTheme.light;
    await _themeRepo.saveTheme(state);
  }
}
