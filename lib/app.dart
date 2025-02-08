import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'viewmodels/theme_viewmodel.dart';
import 'views/home_screen.dart';
import 'models/theme_model.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode == AppTheme.light ? ThemeMode.light : ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}
