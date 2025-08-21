import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:power_pulsee/models/workout_log.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutLogAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ViewProgres(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ViewProgres extends StatefulWidget {
  const ViewProgres({Key? key}) : super(key: key);

  @override
  State<ViewProgres> createState() => _ViewProgresState();
}

class _ViewProgresState extends State<ViewProgres> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<WorkoutLog> workoutLogs = [];

  Set<DateTime> get workoutDays =>
      workoutLogs
          .map((log) => DateTime(log.date.year, log.date.month, log.date.day))
          .toSet();

  int get totalWorkout => workoutLogs.length;

  int get averageDuration {
    if (workoutLogs.isEmpty) return 0;
    return workoutLogs.fold(0, (sum, log) => sum + (log.totalDuration ?? 0)) ~/
        workoutLogs.length;
  }

  @override
  void initState() {
    super.initState();
    _loadWorkoutLogs();
  }

  String _formatCalories(int? calories) {
    if (calories == null) return '0 kcal';
    if (calories > 0) return '+$calories kcal';
    if (calories < 0) return '-${calories.abs()} kcal';
    return '0 kcal';
  }

  Future<void> _loadWorkoutLogs() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final box = await Hive.openBox<WorkoutLog>('workout_logs');

    final logs =
        box.values
            .where(
              (log) =>
                  log.date != null &&
                  log.totalCalories != null &&
                  log.totalDuration != null &&
                  log.progressPercent != null,
            )
            .toList();

    logs.sort((a, b) => b.date.compareTo(a.date));

    setState(() {
      workoutLogs = logs;
    });

    print("📅 Workout days: $workoutDays");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 236, 24, 21),
        title: const Text(
          'Progress Latihan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //
            /*
            TableCalendar(
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 194, 192, 190),
                  shape: BoxShape.circle,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  bool isWorkout =
                      workoutDays.any((d) => isSameDay(d, day));

                  return Container(
                    margin: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isWorkout
                          ? const Color.fromARGB(255, 236, 4, 4)
                          : null,
                    ),
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        color: isWorkout ? Colors.white : Colors.black,
                        fontWeight:
                            isWorkout ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
 
            const SizedBox(height: 24),
           //
            // Legenda
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                LegendDot(
                  color: Color.fromARGB(255, 236, 4, 4),
                  label: 'Latihan selesai',
                ),
              ],
            ),

            const SizedBox(height: 24),
            */
            _buildSummaryCard(),
            const SizedBox(height: 24),
            _buildActivityHistory(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        children: [
          const Text(
            'Ringkasan Bulan Ini',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _SummaryItem(title: 'Total Latihan', value: '$totalWorkout'),
              _SummaryItem(
                title: 'Durasi Rata2',
                value: '$averageDuration min',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityHistory() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Activity History',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            physics:
                const NeverScrollableScrollPhysics(), // agar tidak bentrok scroll
            shrinkWrap: true,
            itemCount: workoutLogs.length,
            separatorBuilder: (context, index) => const Divider(height: 24),
            itemBuilder: (context, index) {
              final log = workoutLogs[index];
              return _buildActivityItem(
                log.workoutName?.toUpperCase() ?? 'Workout',
                '${log.date.day}-${log.date.month}-${log.date.year} · '
                '${log.totalDuration ?? 0} min · '
                '${_formatCalories(log.totalCalories)}',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.red[100],
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.fitness_center, color: Colors.red),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String title;
  final String value;

  const _SummaryItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }
}

class LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 5, backgroundColor: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
