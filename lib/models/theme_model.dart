import 'package:hive/hive.dart';

part 'theme_model.g.dart';

@HiveType(typeId: 1)
enum AppTheme {
  @HiveField(0)
  light,

  @HiveField(1)
  dark
}
