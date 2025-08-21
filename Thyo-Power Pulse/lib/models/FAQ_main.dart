import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqs = [
      {
        "question": "Apa itu aplikasi Power Pulse?",
        "answer":
            "Power Pulse adalah aplikasi fitness yang membantumu berolahraga dengan berbagai program latihan seperti full body, upper body, dan latihan fokus otot (perut, tangan, dada, kaki).",
      },
      {
        "question": "Bagaimana cara memulai latihan?",
        "answer":
            "Pilih program latihan dari halaman utama, lalu tekan tombol 'Start Workout'. Aplikasi akan menampilkan animasi, repetisi, dan deskripsi latihan satu per satu.",
      },

      {
        "question": "Apakah data latihan saya akan disimpan?",
        "answer":
            "Ya, setiap kamu menyelesaikan sesi latihan, data akan otomatis disimpan ke penyimpanan lokal (Hive) dan bisa dilihat di  riwayat latihan.",
      },
      {
        "question": "Apakah Power Pulse butuh koneksi internet?",
        "answer":
            "Untuk login dan daftar akun memang memerlukan koneksi internet. Namun sebagian besar fitur latihan dapat digunakan secara offline.",
      },
      {
        "question": "Bagaimana jika saya lupa password?",
        "answer":
            "Untuk saat ini, fitur reset password belum tersedia. Kamu bisa membuat akun baru atau hubungi pengembang aplikasi untuk bantuan lebih lanjut.",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        
        title: const Text("Pusat Bantuan"),
        backgroundColor: const Color.fromARGB(255, 240, 8, 8),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              faqs[index]["question"]!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(faqs[index]["answer"]!),
              ),
            ],
          );
        },
      ),
    );
  }
}
