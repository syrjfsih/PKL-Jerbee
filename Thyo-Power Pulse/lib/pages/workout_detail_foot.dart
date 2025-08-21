import 'package:flutter/material.dart';
import 'package:power_pulsee/pages/WorkoutSequencePlayer.dart';

class WorkoutDetailFootPage extends StatefulWidget {
  final String name;
  final String image;
  final String sets;
  final String reps;

  const WorkoutDetailFootPage({
    super.key,
    required this.name,
    required this.image,
    required this.sets,
    required this.reps,
    });

  @override
  State<WorkoutDetailFootPage> createState() => _WorkoutDetailFootPageState();
}

class _WorkoutDetailFootPageState extends State<WorkoutDetailFootPage> {
  final List<WorkoutStep> footSteps = [
    WorkoutStep(
      title: 'Chair Squat',
      gifPath: 'assets/gifs/foot_kursi.gif',
      instruction: 'Posisikan diri seperti duduk di kursi, lalu berdiri kembali.',
      targetMuscle: 'Quads & Glutes',
      repetition: 12,
    ),
    WorkoutStep(
      title: 'Standing Leg Raise',
      gifPath: 'assets/gifs/foot_1.gif',
      instruction: 'Angkat satu kaki lurus ke depan, tahan, lalu turunkan.',
      targetMuscle: 'Thighs',
      repetition: 15,
    ),
    WorkoutStep(
      title: 'Bodyweight Squat',
      gifPath: 'assets/gifs/foot_squat.gif',
      instruction: 'Turunkan badan seperti duduk lalu angkat kembali.',
      targetMuscle: 'Legs',
      repetition: 20,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan Otot Kaki'),
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
              'Latihan Fokus Otot Kaki',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/gifs/foot_1.gif', // sebagai preview awal
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            const Text(
              'Rangkaian latihan ini membantu memperkuat otot kaki dan keseimbangan.',
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
                      builder: (_) => WorkoutSequencePlayer(steps: footSteps,
                       workoutName:'latihan otot kaki',
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Mulai Latihan Kaki',
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
