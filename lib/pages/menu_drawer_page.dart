import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasflutter/controller/menu_drawer_controller.dart';
import 'package:pasflutter/controller/profile_controller.dart';
import 'package:pasflutter/routes.dart';

class MenuDrawerPage extends StatelessWidget {
  MenuDrawerPage({super.key});

  final MenuDrawerController controller = Get.put(MenuDrawerController());
  final ProfileController profileController = Get.put(ProfileController());

  static const Color bgDark = Color(0xFF161224);
  static const Color cardPurple = Color(0xFF221C35);
  static const Color accentOrange = Color(0xFFFF9F1C);
  static const Color secondaryText = Color(0xFFA8A1B8);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: bgDark,
        appBar: AppBar(
          backgroundColor: cardPurple,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            controller.pageTitles[controller.selectedIndex.value],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: bgDark,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
                color: cardPurple,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: accentOrange,
                      child: Icon(
                        Icons.person,
                        color: bgDark,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      profileController.fullName.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      profileController.classAndAbsen.value,
                      style: const TextStyle(
                        color: secondaryText,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _buildDrawerItem(
                index: 0,
                icon: Icons.home_rounded,
                title: 'Home',
              ),
              _buildDrawerItem(
                index: 1,
                icon: Icons.sports_soccer_rounded,
                title: 'Feat',
              ),
              _buildDrawerItem(
                index: 2,
                icon: Icons.person_rounded,
                title: 'Profile',
              ),
              const Spacer(),
              const Divider(color: Colors.white12),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.redAccent),
                ),
                onTap: () => Get.offAllNamed(Routes.loginClone),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.listPages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changePage,
          backgroundColor: cardPurple,
          selectedItemColor: accentOrange,
          unselectedItemColor: secondaryText,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_soccer_outlined),
              activeIcon: Icon(Icons.sports_soccer),
              label: 'Feat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required int index,
    required IconData icon,
    required String title,
  }) {
    final bool isSelected = controller.selectedIndex.value == index;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? accentOrange : secondaryText,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? accentOrange : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        controller.changePage(index);
        Get.back();
      },
    );
  }
}
