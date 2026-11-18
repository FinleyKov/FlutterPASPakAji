import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasflutter/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Aplikasi Kuliner & Informasi Liga Inggris",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF140D26),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF9F1C),
          secondary: Color(0xFF00E676),
          surface: Color(0xFF23193E),
        ),
      ),
      initialRoute: Routes.loginClone,
      getPages: Routes.myPages,
    );
  }
}
