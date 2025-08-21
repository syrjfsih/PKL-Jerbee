import 'package:flutter/material.dart';
import 'package:power_pulsee/models/FAQ_main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      emailController.text = user.email ?? '';
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text("Konfirmasi Logout"),
            content: const Text("Apakah kamu yakin ingin keluar?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text(
                  "Batal",
                  style: TextStyle(
                    color: Color.fromARGB(255, 97, 97, 97),
                  ), // ✅ Benar
                ),
              ),

              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await Supabase.instance.client.auth.signOut();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 253, 253),
        centerTitle: true,
        title: const Text(
          'Profil',
          style: TextStyle(color: Color.fromARGB(255, 17, 17, 17)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Color.fromARGB(255, 247, 11, 11),
                ),
              ),
            ),
            const SizedBox(height: 24),

            _buildLabelField("Email", emailController, readOnly: true),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
            const Divider(height: 1, thickness: 1),

            const SizedBox(height: 24),
            const Text(
              'Umum',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            ListTile(
              leading: const Icon(
                Icons.help_outline,
                color: Color.fromARGB(255, 17, 17, 17),
              ),
              title: const Text('Pusat Bantuan'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FAQPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelField(
    String label,
    TextEditingController controller, {
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
