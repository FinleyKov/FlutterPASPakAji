import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasflutter/controller/profile_controller.dart';
import 'package:pasflutter/routes.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  static const Color bgDark = Color(0xFF161224);
  static const Color cardPurple = Color(0xFF221C35);
  static const Color surfacePurple = Color(0xFF2E2647);
  static const Color accentOrange = Color(0xFFFF9F1C);
  static const Color secondaryText = Color(0xFFA8A1B8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDark,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card Foto Profil, Nama Lengkap, Kelas / No. Absen
            Card(
              color: cardPurple,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 44,
                        backgroundColor: surfacePurple,
                        child: ClipOval(
                          child: Image.network(
                            profileController.photoUrl.value,
                            width: 88,
                            height: 88,
                            fit: BoxFit.cover,
                            webHtmlElementStrategy:
                                WebHtmlElementStrategy.prefer,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.person,
                              size: 44,
                              color: accentOrange,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Obx(
                      () => Text(
                        profileController.fullName.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Obx(
                      () => Text(
                        profileController.classAndAbsen.value,
                        style: const TextStyle(
                          color: accentOrange,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Card Bio Singkat & Identitas
            Card(
              color: cardPurple,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info_outline, color: accentOrange, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Bio Singkat',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => Text(
                        profileController.shortBio.value,
                        style: const TextStyle(
                          color: secondaryText,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const Divider(color: Colors.white24, height: 24),
                    Obx(
                      () => _buildInfoRow(
                        Icons.school_outlined,
                        'Sekolah',
                        profileController.schoolName.value,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => _buildInfoRow(
                        Icons.email_outlined,
                        'Email',
                        profileController.email.value,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () => Get.offAllNamed(Routes.loginClone),
              style: ElevatedButton.styleFrom(
                backgroundColor: surfacePurple,
                foregroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.logout, size: 18),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: secondaryText, size: 18),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: const TextStyle(color: secondaryText, fontSize: 13),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
