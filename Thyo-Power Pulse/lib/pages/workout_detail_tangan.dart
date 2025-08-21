import 'package:flutter/material.dart';
import 'package:power_pulsee/pages/WorkoutSequencePlayer.dart';

class otottangan extends StatefulWidget {
   final String name;
  final String image;
  final String sets;
  final String reps;

  const otottangan({
    super.key,
    required this.name,
    required this.image,
    required this.sets,
    required this.reps,
    });

  @override
  State<otottangan> createState() => _otottanganState();
}

class _otottanganState extends State<otottangan> {
  final List<WorkoutStep> handSteps = [
    WorkoutStep(
      title: 'Push Up',
      gifPath: 'assets/gifs/chest.gif',
      instruction: 'Luruskan tubuh dan dorong ke atas dan ke bawah menggunakan tangan.',
      targetMuscle: 'Triceps & Chest',
      repetition: 12,
    ),
    WorkoutStep(
      title: 'Diamond Push Up',
      gifPath: 'assets/gifs/chest2.gif',
      instruction: 'Dekatkan tangan membentuk segitiga dan lakukan push up.',
      targetMuscle: 'Triceps',
      repetition: 10,
    ),
    WorkoutStep(
      title: 'Chair Dips',
      gifPath: 'assets/gifs/chest5.gif',
      instruction: 'Gunakan kursi, turunkan dan angkat tubuh menggunakan lengan.',
      targetMuscle: 'Triceps & Shoulders',
      repetition: 15,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan Otot Tangan'),
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
              'Latihan Fokus Otot Tangan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/gifs/chest.gif',
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            const Text(
              'Latihan ini akan memperkuat otot tangan kamu seperti triceps dan bahu.',
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
                      builder: (_) => WorkoutSequencePlayer(steps: handSteps,
                      workoutName: 'Latihan Otot Tangan',
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Mulai Latihan Tangan',
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
