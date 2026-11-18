import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pasflutter/routes.dart';

class LoginCloneController extends GetxController {
  final TextEditingController txtUsername = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  TextEditingController get usernameController => txtUsername;
  TextEditingController get passwordController => txtPassword;

  final RxBool isLoading = false.obs;
  final RxBool isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() async {
    final username = txtUsername.text.trim();
    final password = txtPassword.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Peringatan",
        "Username dan password harus diisi!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade800,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    try {
      isLoading.value = true;
      final Uri url = Uri.parse("https://mediadwi.com/api/latihan/login");

      final response = await http.post(
        url,
        body: {
          "username": username,
          "password": password,
        },
      ).timeout(const Duration(seconds: 15));

      isLoading.value = false;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == true) {
          Get.snackbar(
            "Berhasil",
            data['message']?.toString() ?? "Login berhasil!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF1B5E20),
            colorText: Colors.white,
            margin: const EdgeInsets.all(12),
          );

          Get.offAllNamed(Routes.menuDrawer);
        } else {
          _showLoginFailedAlert(
            data['message']?.toString() ?? "Username atau password salah!",
          );
        }
      } else {
        _showLoginFailedAlert(
          "Gagal menghubungi server (Status: ${response.statusCode})",
        );
      }
    } catch (e) {
      isLoading.value = false;
      _showLoginFailedAlert("Terjadi kesalahan koneksi: $e");
    }
  }

  void _showLoginFailedAlert(String message) {
    Get.snackbar(
      "Login Gagal",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade800,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
    );
  }

  @override
  void onClose() {
    txtUsername.dispose();
    txtPassword.dispose();
    super.onClose();
  }
}
