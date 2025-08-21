import 'dart:async';
import 'package:flutter/material.dart';
import 'package:power_pulsee/screens/view_progres.dart';
import 'package:hive/hive.dart';
import 'package:power_pulsee/models/workout_log.dart';

class WorkoutStep {
  final String title;
  final String gifPath;
  final String instruction;
  final String targetMuscle;
  final int repetition;

  WorkoutStep({
    required this.title,
    required this.gifPath,
    required this.instruction,
    required this.targetMuscle,
    required this.repetition,
  });
}

class WorkoutSequencePlayer extends StatefulWidget {
  final List<WorkoutStep> steps;
  final String workoutName;

  const WorkoutSequencePlayer({
    Key? key,
    required this.steps,
    required this.workoutName,
  }) : super(key: key);

  @override
  State<WorkoutSequencePlayer> createState() => _WorkoutSequencePlayerState();
}

class _WorkoutSequencePlayerState extends State<WorkoutSequencePlayer> {
  int currentIndex = 0;
  bool isRest = false;
  int secondsLeft = 0;
  Timer? _timer;
  bool showIntro = true;
  DateTime? _startTime;
  DateTime? _endTime;

  @override
 void startExercise() {
  if (_startTime == null) {
    _startTime = DateTime.now(); // ⏱️ catat waktu latihan dimulai
  }

  setState(() {
    showIntro = false;
    isRest = false;
    secondsLeft = widget.steps[currentIndex].repetition > 0
        ? widget.steps[currentIndex].repetition * 2
        : 20;
  });

  _startTimer(() {
    if (currentIndex >= widget.steps.length - 1) {
      _finishWorkout();
    } else {
      startRest();
    }
  });
}


  void startRest() {
    setState(() {
      isRest = true;
      secondsLeft = 10;
    });
    _startTimer(() {
      setState(() {
        currentIndex++;
        showIntro = true;
      });
    });
  }

  void _startTimer(VoidCallback onFinish) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft == 0) {
        timer.cancel();
        onFinish();
      } else {
        setState(() {
          secondsLeft--;
        });
      }
    });
  }

 Future<void> _finishWorkout() async {
  _timer?.cancel();

  _endTime = DateTime.now();
  final totalDuration = _endTime!.difference(_startTime!).inMinutes;

  final totalCalories = widget.steps.length * 5;
  final progressPercent = 100;

  final workoutBox = Hive.isBoxOpen('workout_logs')
      ? Hive.box<WorkoutLog>('workout_logs')
      : await Hive.openBox<WorkoutLog>('workout_logs');

  await workoutBox.add(
    WorkoutLog(
      workoutName: widget.workoutName,
      date: DateTime.now(),
      totalCalories: totalCalories,
      totalDuration: totalDuration,
      progressPercent: progressPercent,
    ),
  );


    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Latihan selesai! Progress berhasil disimpan.'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // Tunggu sejenak sebelum navigasi
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => ViewProgres()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = widget.steps[currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child:
                showIntro
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentStep.title,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(currentStep.gifPath, height: 200),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          currentStep.instruction,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Target: ${currentStep.targetMuscle}',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: startExercise,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Mulai Latihan Ini',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    )
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isRest ? 'ISTIRAHAT' : currentStep.title,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        if (!isRest)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              currentStep.gifPath,
                              height: 200,
                            ),
                          )
                        else
                          const Icon(
                            Icons.access_time,
                            color: Colors.red,
                            size: 120,
                          ),
                        const SizedBox(height: 30),
                        Text(
                          isRest ? 'Waktu Istirahat' : currentStep.instruction,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        Text(
                          '$secondsLeft s',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        LinearProgressIndicator(
                          value:
                              (secondsLeft > 0)
                                  ? isRest
                                      ? (10 - secondsLeft) / 10
                                      : ((widget
                                                      .steps[currentIndex]
                                                      .repetition *
                                                  2 -
                                              secondsLeft) /
                                          (widget
                                                  .steps[currentIndex]
                                                  .repetition *
                                              2))
                                  : 1.0,
                          minHeight: 10,
                          backgroundColor: Colors.grey[800],
                          color: isRest ? Colors.orange : Colors.redAccent,
                        ),
                        const SizedBox(height: 20),
                        if (isRest) ...[
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                secondsLeft += 15;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                110,
                                110,
                                110,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              '+15 detik',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              _timer?.cancel();
                              if (currentIndex < widget.steps.length - 1) {
                                setState(() {
                                  currentIndex++;
                                  showIntro = true;
                                });
                              } else {
                                _finishWorkout();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'MELEWATKAN',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ] else ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed:
                                    currentIndex > 0
                                        ? () {
                                          _timer?.cancel();
                                          setState(() {
                                            currentIndex--;
                                            showIntro = true;
                                          });
                                        }
                                        : null,
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  "Sebelumnya",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  disabledBackgroundColor: Colors.grey,
                                ),
                              ),
                              currentIndex < widget.steps.length - 1
                                  ? ElevatedButton.icon(
                                    onPressed: () {
                                      _timer?.cancel();
                                      setState(() {
                                        currentIndex++;
                                        showIntro = true;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.skip_next,
                                      color: Colors.red,
                                    ),
                                    label: const Text(
                                      "Lewati",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      disabledBackgroundColor:
                                          Colors.grey.shade200,
                                    ),
                                  )
                                  : ElevatedButton.icon(
                                    onPressed: () {
                                      _timer?.cancel();
                                      _finishWorkout();
                                    },
                                    icon: const Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      "SELESAI",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                        255,
                                        230,
                                        13,
                                        13,
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ],
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
