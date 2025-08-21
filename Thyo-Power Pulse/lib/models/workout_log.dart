import 'package:hive/hive.dart';

part 'workout_log.g.dart';

@HiveType(typeId: 0)
class WorkoutLog extends HiveObject {
  @HiveField(0)
  String workoutName; // ✅ Tambahkan ini

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  int? totalCalories;

  @HiveField(3)
  int? totalDuration;

  @HiveField(4)
  int? progressPercent;

  WorkoutLog({
    required this.workoutName,
    required this.date,
    this.totalCalories,
    this.totalDuration,
    this.progressPercent,
  });
}
