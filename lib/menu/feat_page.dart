import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasflutter/controller/feat_controller.dart';
import 'package:pasflutter/models/team_model.dart';

class FeatPage extends StatelessWidget {
  const FeatPage({super.key});

  static const Color bgDark = Color(0xFF161224);
  static const Color cardPurple = Color(0xFF221C35);
  static const Color surfacePurple = Color(0xFF2E2647);
  static const Color accentOrange = Color(0xFFFF9F1C);
  static const Color secondaryText = Color(0xFFA8A1B8);

  @override
  Widget build(BuildContext context) {
    final FeatController controller = Get.put(FeatController());

    return Scaffold(
      backgroundColor: bgDark,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: accentOrange),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: controller.fetchPremierLeagueTeams,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentOrange,
                      foregroundColor: bgDark,
                    ),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.teams.length,
          itemBuilder: (context, index) {
            final Team team = controller.teams[index];
            return Card(
              color: cardPurple,
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    // Logo Klub (strBadge) dengan dukungan Web HTML Element agar tidak terblokir CORS
                    Container(
                      width: 64,
                      height: 64,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: surfacePurple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        team.strBadge,
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                        webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.shield,
                          color: accentOrange,
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Nama Klub (strTeam) & Nama Stadion (strStadium)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            team.strTeam,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.stadium_outlined,
                                color: accentOrange,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  team.strStadium,
                                  style: const TextStyle(
                                    color: secondaryText,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
