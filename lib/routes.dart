import 'package:get/get.dart';
import 'package:pasflutter/menu/home_page.dart';
import 'package:pasflutter/pages/login_clone_page.dart';
import 'package:pasflutter/pages/menu_drawer_page.dart';
import 'package:pasflutter/pages/transaksi_page.dart';

class Routes {
  static const String registration = "/registration";
  static const String confirmRegistration = "/confirmRegistration";
  static const String listProduk = "/listProduk";
  static const String detailProduk = "/detailProduk";
  static const String mainmenu = "/mainmenuPage";
  static const String menuDrawer = "/menuDrawer";
  static const String loginClone = "/loginClone";

  static final myPages = [
    GetPage(
      name: loginClone,
      page: () => LoginClonePage(),
    ),
    GetPage(
      name: menuDrawer,
      page: () => MenuDrawerPage(),
    ),
    GetPage(
      name: mainmenu,
      page: () => MenuDrawerPage(),
    ),
    GetPage(
      name: detailProduk,
      page: () => const TransaksiPage(),
    ),
    GetPage(
      name: listProduk,
      page: () => const HomePage(),
    ),
  ];
}
