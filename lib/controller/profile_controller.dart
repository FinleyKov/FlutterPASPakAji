import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Identitas Lengkap Pembuat Aplikasi (Sesuai Ketentuan Menu 3: Profile)
  final RxString fullName = "Moses Prawira".obs;
  final RxString classAndAbsen = "11 PPLG 3 / No. Absen 18".obs;
  final RxString shortBio =
      "Siswa Jurusan PPLG di SMK Raden Umar Said Kudus yang baik hati dan rajin menabung".obs;
  final RxString photoUrl =
      "https://ui-avatars.com/api/?name=Moses+Prawira&background=FF9F1C&color=140D26&size=256&bold=true".obs;
  final RxString schoolName = "SMK Raden Umar Said Kudus".obs;
  final RxString subjectName = "PPLG - Mobile Programming".obs;
  final RxString email = "prawiramoses@gmail.com".obs;

  void updateProfile({
    required String name,
    required String kelasAbsen,
    required String bio,
  }) {
    if (name.trim().isNotEmpty) fullName.value = name.trim();
    if (kelasAbsen.trim().isNotEmpty) classAndAbsen.value = kelasAbsen.trim();
    if (bio.trim().isNotEmpty) shortBio.value = bio.trim();
    Get.snackbar(
      'Profil Diperbarui',
      'Data identitas profil berhasil disimpan.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1B5E20),
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
    );
  }
}
