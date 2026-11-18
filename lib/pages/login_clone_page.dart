import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasflutter/component/roblox_button.dart';
import 'package:pasflutter/controller/login_clone_controller.dart';

class LoginClonePage extends StatelessWidget {
  LoginClonePage({super.key});

  final LoginCloneController controller = Get.put(LoginCloneController());

  static const Color backgroundColor = Color(0xFF161224);
  static const Color cardColor = Color(0xFF221C35);
  static const Color inputFillColor = Color(0xFF2E2647);
  static const Color accentOrange = Color(0xFFFF9F1C);
  static const Color accentMint = Color(0xFF00E676);
  static const Color primaryTextColor = Colors.white;
  static const Color secondaryTextColor = Color(0xFFA8A1B8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ikon Makanan & Sepak Bola (Simpel)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.fastfood_rounded,
                        color: accentOrange,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.sports_soccer_rounded,
                        color: accentMint,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                const Text(
                  'Kuliner & Liga Inggris',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryTextColor,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Silakan login untuk melanjutkan',
                  style: TextStyle(
                    fontSize: 13,
                    color: secondaryTextColor,
                  ),
                ),
                const SizedBox(height: 28),

                // Card Form Login Simpel
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // TextField Username
                      TextField(
                        controller: controller.txtUsername,
                        style: const TextStyle(color: primaryTextColor),
                        decoration: InputDecoration(
                          hintText: 'Masukkan username',
                          hintStyle: const TextStyle(
                            color: secondaryTextColor,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: secondaryTextColor,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: inputFillColor,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // TextField Password
                      Obx(
                        () => TextField(
                          controller: controller.txtPassword,
                          obscureText: controller.isPasswordHidden.value,
                          style: const TextStyle(color: primaryTextColor),
                          decoration: InputDecoration(
                            hintText: 'Masukkan password',
                            hintStyle: const TextStyle(
                              color: secondaryTextColor,
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: secondaryTextColor,
                              size: 20,
                            ),
                            suffixIcon: IconButton(
                              onPressed: controller.togglePasswordVisibility,
                              icon: Icon(
                                controller.isPasswordHidden.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: secondaryTextColor,
                                size: 20,
                              ),
                            ),
                            filled: true,
                            fillColor: inputFillColor,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Tombol Login
                      Obx(
                        () => controller.isLoading.value
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: CircularProgressIndicator(
                                    color: accentOrange,
                                    strokeWidth: 3,
                                  ),
                                ),
                              )
                            : RobloxButton(
                                text: 'Login',
                                backgroundColor: accentOrange,
                                textColor: const Color(0xFF161224),
                                onPressed: () {
                                  controller.login();
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
