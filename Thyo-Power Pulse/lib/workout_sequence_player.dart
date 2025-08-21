import 'package:flutter/material.dart';
import 'package:power_pulsee/models/workout_description_page.dart';
import 'package:power_pulsee/pages/WorkoutSequencePlayer.dart';

class WoDetailsScrean extends StatelessWidget {
  final List<WorkoutStep> steps;
  final String workoutName;

  const WoDetailsScrean({
    super.key,
    required this.steps,
    required this.workoutName,
  });

  @override
  Widget build(BuildContext context) {
    final List<WorkoutStep> steps = [
      WorkoutStep(
        title: ' Squat',
        gifPath: 'assets/gifs/foot_squat.gif',
        instruction: 'Lakukan squat hingga paha sejajar lantai.',
        targetMuscle: 'Legs',
        repetition: 20,
      ),

      WorkoutStep(
        title: 'Stomach Crunch',
        gifPath: 'assets/gifs/stomach.gif',
        instruction: 'Kontraksikan otot perut ke depan.',
        targetMuscle: 'Abs',
        repetition: 15,
      ),
      WorkoutStep(
        title: 'sit up',
        gifPath: 'assets/gifs/stomach2.gif',
        instruction: 'Variasi crunch lanjutan.',
        targetMuscle: 'Abs',
        repetition: 15,
      ),

      WorkoutStep(
        title: 'Chest 1',
        gifPath: 'assets/gifs/chest1.gif',
        instruction: 'Gerakan dada dasar.',
        targetMuscle: 'Chest',
        repetition: 15,
      ),

      WorkoutStep(
        title: 'Decline Push-up',
        gifPath: 'assets/gifs/chest5.gif',
        instruction: 'Gerakan pemanasan dada.',
        targetMuscle: 'Chest',
        repetition: 15,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 2, 0, 0),
        title: const Text(
          "Workout Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(),
                    const SizedBox(height: 30),
                    const Text(
                      "Tentang",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Latihan seluruh tubuh ini dirancang untuk membangun kekuatan dan daya tahan melalui serangkaian latihan yang menargetkan semua kelompok otot utama.",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Exercises",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    for (var step in steps)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ExerciseDetailPage(step: step),
                            ),
                          );
                        },
                        child: _buildExerciseImageItem(
                          step.title,
                          step.repetition == 1
                              ? '30 sec'
                              : 'x${step.repetition}',
                          step.gifPath,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildStartWorkoutButton(context, steps),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 99, 99),
            Color.fromARGB(255, 255, 99, 99),
          ],
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, color: Colors.white, size: 60),
            SizedBox(height: 15),
            Text(
              "Seluruh badan",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "45 min - Medium - 35 kcal",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoCard('Exercise', '15', Icons.fitness_center),
        _buildInfoCard('Equipment', 'Minimal', Icons.sports_handball),
        _buildInfoCard('Level', 'Medium', Icons.trending_up),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 236, 17, 17), size: 22),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildExerciseImageItem(String title, String time, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              time,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartWorkoutButton(
    BuildContext context,
    List<WorkoutStep> steps,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewPadding.bottom + 20,
        top: 10,
      ),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Siap Memulai Latihan?"),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Latihan ini akan melibatkan seluruh tubuh untuk meningkatkan kekuatan dan daya tahan.",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    Text("Durasi: 45 menit"),
                    Text("Level: Medium"),
                    Text("Otot utama: Dada, Perut, Kaki"),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Batal"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // tutup dialog
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => WorkoutSequencePlayer(
                                steps: steps,
                                workoutName: workoutName,
                              ),
                        ),
                      );
                    },
                    child: const Text("Mulai Sekarang"),
                  ),
                ],
              );
            },
          );
        },

        child: Row(
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 99, 99).withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Icon(
                  Icons.play_arrow,
                  color: Color.fromARGB(255, 248, 21, 21),
                  size: 30,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 99, 99),
                      Color.fromARGB(255, 255, 99, 99),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Start Workout",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
