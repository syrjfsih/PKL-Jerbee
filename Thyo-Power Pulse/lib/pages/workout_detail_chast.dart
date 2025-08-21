import 'package:flutter/material.dart';
import 'package:power_pulsee/pages/WorkoutSequencePlayer.dart';

class ototdada extends StatefulWidget {
  final String name;
  final String image;
  final String sets;
  final String reps;

  const ototdada({
    super.key,
    required this.name,
    required this.image,
    required this.sets,
    required this.reps,
  });

  @override
  State<ototdada> createState() => _ototdadaState();
}

class _ototdadaState extends State<ototdada> {
  final List<WorkoutStep> chestSteps = [
    WorkoutStep(
      title: 'Incline Push Up',
      gifPath: 'assets/gifs/chest1.gif',
      instruction: 'Tempatkan tangan di permukaan tinggi lalu lakukan push-up.',
      targetMuscle: 'Upper Chest',
      repetition: 12,
    ),
    WorkoutStep(
      title: 'Diamond Push Up',
      gifPath: 'assets/gifs/chest2.gif',
      instruction:
          'Dekatkan tangan membentuk segitiga dan dorong tubuh ke atas.',
      targetMuscle: 'Chest & Triceps',
      repetition: 10,
    ),
    WorkoutStep(
      title: 'Chest Dips',
      gifPath: 'assets/gifs/chest5.gif',
      instruction:
          'Turunkan dan angkat tubuh menggunakan kursi atau alat bantu.',
      targetMuscle: 'Lower Chest',
      repetition: 15,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan Otot Dada'),
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
              'Latihan Fokus Otot Dada',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/gifs/chest1.gif',
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            const Text(
              'Latihan ini akan membantu memperkuat otot dada bagian atas, tengah, dan bawah.',
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
                      builder: (_) => WorkoutSequencePlayer(steps: chestSteps,
                       workoutName:'latihan otot Dada',
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Mulai Latihan Dada',
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
