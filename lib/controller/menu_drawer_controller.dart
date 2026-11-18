import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasflutter/menu/home_page.dart';
import 'package:pasflutter/menu/feat_page.dart';
import 'package:pasflutter/menu/profile_page.dart';

class MenuDrawerController extends GetxController {
  // Menyimpan indeks halaman yang sedang aktif secara reaktif (.obs)
  final RxInt selectedIndex = 0.obs;

  // Judul AppBar sesuai menu yang aktif
  final List<String> pageTitles = const [
    'Home - Katalog Kuliner',
    'Feat - Premier League',
    'Profile Pembuat',
  ];

  // Fungsi untuk mengubah halaman (action di controller)
  void changePage(int index) {
    selectedIndex.value = index;
  }

  // Daftar 3 halaman menu utama sesuai instruksi soal:
  // 1. Home, 2. Feat, 3. Profile
  final List<Widget> listPages = [
    const HomePage(),
    const FeatPage(),
    ProfilePage(),
  ];
}
