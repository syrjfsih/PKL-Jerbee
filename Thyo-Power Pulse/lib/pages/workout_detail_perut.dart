import 'package:flutter/material.dart';
import 'package:power_pulsee/pages/WorkoutSequencePlayer.dart';

class ototperut extends StatefulWidget {
  final String name;
  final String image;
  final String sets;
  final String reps;

  const ototperut({
    super.key,
    required this.name,
    required this.image,
    required this.sets,
    required this.reps,
  });

  @override
  State<ototperut> createState() => _ototperutState();
}

class _ototperutState extends State<ototperut> {
  final List<WorkoutStep> stomachSteps = [
    WorkoutStep(
      title: 'Sit Up',
      gifPath: 'assets/gifs/sit_up.gif',
      instruction: 'Berbaring dan angkat badan ke atas lalu turun kembali.',
      targetMuscle: 'Stomach',
      repetition: 15,
    ),
    WorkoutStep(
      title: 'Crunch Ab',
      gifPath: 'assets/gifs/stomach.gif',
      instruction: 'Kencangkan otot perut saat mengangkat tubuh bagian atas.',
      targetMuscle: 'Stomach',
      repetition: 20,
    ),
    WorkoutStep(
      title: 'Leg Raises',
      gifPath: 'assets/gifs/stomach2.gif',
      instruction: 'Angkat kedua kaki lurus ke atas secara bersamaan.',
      targetMuscle: 'Stomach',
      repetition: 15,
    ),
    WorkoutStep(
      title: 'Plank Crunch',
      gifPath: 'assets/gifs/stomach3.gif',
      instruction: 'Lakukan crunch dengan posisi plank.',
      targetMuscle: 'Stomach',
      repetition: 20,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan Otot Perut'),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Latihan Fokus Otot Perut',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/gifs/stomach.gif', // Gunakan salah satu GIF sebagai preview
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            const Text(
              'Latihan ini akan memperkuat otot inti dan perut kamu secara efektif.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => WorkoutSequencePlayer(steps: stomachSteps,
                          workoutName:'latihan otot perut',
                          ),
                    ),
                  );
                },
                child: const Text(
                  'Mulai Latihan Perut',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
