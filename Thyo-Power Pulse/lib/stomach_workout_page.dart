import 'package:flutter/material.dart';
import 'package:power_pulsee/pages/WorkoutSequencePlayer.dart';

class StomachWorkoutPage extends StatelessWidget {
  StomachWorkoutPage({super.key});

  final List<WorkoutStep> stomachWorkouts = [
    WorkoutStep(
      title: 'sit up serong',
      gifPath: 'assets/gifs/stomach2.gif',
      instruction: 'Berbaring dan angkat badan ke arah lutut secara perlahan.',
      targetMuscle: 'Abs',
      repetition: 12,
    ),
    WorkoutStep(
      title: 'mengangkat kaki saat berbaring',
      gifPath: 'assets/gifs/stomach.gif',
      instruction: 'Latihan perut klasik, duduk lalu kembali turun.',
      targetMuscle: 'Abs',
      repetition: 10,
    ),
    WorkoutStep(
      title: 'Leg Raise',
      gifPath: 'assets/gifs/stomach3.gif',
      instruction: 'Angkat kaki lurus ke atas lalu turunkan perlahan.',
      targetMuscle: 'Lower Abs',
      repetition: 15,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    int estimatedDuration = stomachWorkouts.length * 1;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 20),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tombol kembali
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Latihan Perut Tanpa Alat',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _infoBox('Durasi', '$estimatedDuration menit'),
                      const SizedBox(width: 12),
                      _infoBox('Latihan', '${stomachWorkouts.length}'),
                    ],
                  ),
                ],
              ),
            ),

            // LIST LATIHAN
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: stomachWorkouts.length,
                itemBuilder: (context, index) {
                  final item = stomachWorkouts[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            item.gifPath,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text('x${item.repetition}'),
                      ],
                    ),
                  );
                },
              ),
            ),

            // TOMBOL MULAI
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => WorkoutSequencePlayer(
                              workoutName: 'Stomach Workout',
                              steps: stomachWorkouts,
                            ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Mulai',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
