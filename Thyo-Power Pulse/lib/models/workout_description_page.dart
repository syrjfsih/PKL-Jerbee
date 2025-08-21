import 'package:flutter/material.dart';
import 'package:power_pulsee/pages/WorkoutSequencePlayer.dart';

class ExerciseDetailPage extends StatelessWidget {
  final WorkoutStep step;

  const ExerciseDetailPage({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(step.title.toUpperCase()),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(step.gifPath, height: 200),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _infoBox(Icons.timer, 'x${step.repetition}'),
                const SizedBox(width: 12),
                _infoBox(Icons.fitness_center, step.targetMuscle),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'INSTRUKSI',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(255, 243, 33, 33),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              step.instruction,
              style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.5),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 243, 33, 33)),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
