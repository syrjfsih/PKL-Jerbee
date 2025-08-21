import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:power_pulsee/models/workout_log.dart';
import 'package:flutter/material.dart';
import 'package:power_pulsee/chest_workout_page.dart';
import 'package:power_pulsee/foot_workout_page.dart';
import 'package:power_pulsee/hand_workout_page.dart';
import 'package:power_pulsee/pages/WorkoutSequencePlayer.dart';
import 'package:power_pulsee/screens/profil_page.dart';
import 'package:power_pulsee/screens/view_progres.dart';
import 'package:power_pulsee/stomach_workout_page.dart';
import 'package:power_pulsee/workout_sequence_player.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';

// 🔧 Ubah class ini:
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int fullBodyProgress = 0;

  @override
  void initState() {
    super.initState();
    loadProgressFromHive();
  }

  void loadProgressFromHive() async {
    if (!Hive.isBoxOpen('workout_logs')) {
      await Hive.openBox<WorkoutLog>('workout_logs');
    }
    final box = Hive.box<WorkoutLog>('workout_logs');
    final today = DateTime.now();

    final logsToday =
        box.values.where((log) => log is WorkoutLog).cast<WorkoutLog>().where((
          log,
        ) {
          final logDate = log.date;
          return logDate.year == today.year &&
              logDate.month == today.month &&
              logDate.day == today.day;
        }).toList();

    print("Total logs: ${box.values.length}");
    print("Logs for today: ${logsToday.length}");

    if (logsToday.isNotEmpty) {
      final latestLog = logsToday.last;
      setState(() {
        fullBodyProgress = latestLog.progressPercent ?? 0;
      });
    } else {
      setState(() {
        fullBodyProgress = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TOP GREETING & PROFILE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat datang kembali",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.redAccent[600],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "profesional hebat",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: const Color(0xFFFFFFFF),
                        child: const Icon(
                          Icons.person,
                          color: Color(0xFFF50808),
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                // TODAY TARGET
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 236, 53, 53),
                        Color.fromARGB(255, 236, 53, 53),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF6C63FF).withOpacity(0.3),
                        blurRadius: 15,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Progres Latihan",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewProgres(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.show_chart,
                                color: const Color.fromARGB(255, 253, 71, 71),
                                size: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "View Progress",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // CATEGORIES
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCategoryCardWithImage(
                      'OTOT TANGAN ',
                      'assets/tangan .jpg',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Hand()),
                        );
                      },
                    ),
                    _buildCategoryCardWithImage(
                      'OTOT PERUT',
                      'assets/perut.jpg',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StomachWorkoutPage(),
                          ),
                        );
                      },
                    ),
                    _buildCategoryCardWithImage(
                      'OTOT DADA',
                      'assets/dada.jpg',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChestWorkoutPage(),
                          ),
                        );
                      },
                    ),
                    _buildCategoryCardWithImage(
                      'OTOT KAKI',
                      'assets/kaki.jpg',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FootWorkoutPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                SizedBox(height: 30),

                // TODAY'S WORKOUT
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Latihan hari ini",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),

                _buildWorkoutCard(
                  'seluruh badan',
                  '45 min - Medium',
                  Icons.fitness_center,
                  fullBodyProgress / 100.0, // ✅ FIXED
                  context,
                ),

                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCardWithImage(
    String title,
    String imagePath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                imagePath,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(
    String title,
    String subtitle,
    IconData icon,
    double progres,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => WoDetailsScrean(
                  steps: [
                    WorkoutStep(
                      title: 'Full Body Workout',
                      gifPath: 'assets/gifs/full_body.gif',
                      instruction: 'Latihan untuk seluruh tubuh...',
                      targetMuscle: 'All Muscles',
                      repetition: 12,
                    ),
                  ],
                  workoutName: 'Full Body Workout', // ✅ Tambahkan ini
                ),
          ),
        ).then((_) {
          loadProgressFromHive(); // ✅ refresh setelah latihan
        });
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 2,
              color: Colors.grey.withOpacity(0.1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Icon(icon, color: Colors.red, size: 25)),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Stack(
                    children: [
                      CircularProgressIndicator(
                        value: progres,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        strokeWidth: 5,
                      ),
                      Center(
                        child: Text(
                          '${fullBodyProgress}%',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
