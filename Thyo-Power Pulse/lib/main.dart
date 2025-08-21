import 'package:flutter/material.dart';
import 'package:power_pulsee/home.dart';
import 'package:power_pulsee/login.dart';
import 'package:power_pulsee/register.dart';
import 'package:power_pulsee/splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:power_pulsee/models/workout_log.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Inisialisasi Hive
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutLogAdapter());

  // ✅ Buka box dan clear data lama (untuk hilangkan error cast String → DateTime)
  final workoutBox = await Hive.openBox<WorkoutLog>('workout_logs');
  await workoutBox.clear(); // ❗hapus data lama yang bikin error
  await workoutBox.close(); 
  await Hive.openBox<WorkoutLog>('workout_logs');
// WAJIB agar box reload fresh

  // ✅ Inisialisasi Supabase
  await Supabase.initialize(
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxyc2h4dHNucGpwYXN2dXBzcnZiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAxMzA1NzksImV4cCI6MjA2NTcwNjU3OX0.QVkgn7_pIrH_F34Jfky5weaU8izgiz_bZDku70OpMTw",
    url: "https://lrshxtsnpjpasvupsrvb.supabase.co",
  );

  // ✅ Jalankan aplikasi
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const Home(),
      },
    ),
  );
}
