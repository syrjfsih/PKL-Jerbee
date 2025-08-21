import 'package:flutter/material.dart';
import 'package:power_pulsee/pages/WorkoutSequencePlayer.dart';

class Hand extends StatelessWidget {
  Hand({super.key});

  final List<WorkoutStep> handWorkouts = [
    WorkoutStep(
      title: 'Reverse Wrist Curl',
      gifPath: 'assets/gifs/chest.gif',
      instruction:
          'lakukan gerakan tersebut dengan cara berdiri tegak atau duduk lalu lengan atas menempel di sisi tubuh,siku di tekuk sedikit lalu ayun kan tangan ke atas dengan bebas.',
      targetMuscle: 'Chest & Arms',
      repetition: 12,
    ),
    WorkoutStep(
      title: 'chair dip',
      gifPath: 'assets/gifs/chest2.gif',
      instruction:
          'Siapkan dua kursi sejajar, dengan jarak selebar bahu atau sedikit lebih lebar berdirilah di antara kedua kursi,pegang bagian atas sandaran kursi dengan kedua tangan,lalu angkat tubuh dan turun kan tubuh secara perlahan',
      targetMuscle: 'Triceps',
      repetition: 10,
    ),
    WorkoutStep(
      title: 'Decline Push-Up ',
      gifPath: 'assets/gifs/chest5.gif',
      instruction:
          'Siapkan kursi atau bangku stabil,letakkan kedua kaki ke atas kursi dan tangn di lantai,selebar bahu pastikan tubuh lurus dengan bahu hingga tumit,turunkan tubuh secara perlahan .',
      targetMuscle: 'Chest',
      repetition: 15,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    int totalReps = handWorkouts.fold(0, (sum, item) => sum + item.repetition);
    int estimatedDuration = handWorkouts.length * 1;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER MERAH DENGAN TOMBOL KEMBALI
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
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
                  // Tombol back
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Latihan Tangan Tanpa Alat',
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
                      const SizedBox(width: 16),
                      _infoBox('Latihan', '${handWorkouts.length}'),
                    ],
                  ),
                ],
              ),
            ),

            // DAFTAR LATIHAN
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: handWorkouts.length,
                itemBuilder: (context, index) {
                  final item = handWorkouts[index];
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

            // TOMBOL MULAI SAJA
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
                              workoutName: 'Hand Workout',
                              steps: handWorkouts,
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
