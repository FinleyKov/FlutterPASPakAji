import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasflutter/controller/list_produk_controller.dart';
import 'package:pasflutter/models/product_model.dart';
import 'package:pasflutter/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const Color bgDark = Color(0xFF161224);
  static const Color cardPurple = Color(0xFF221C35);
  static const Color surfacePurple = Color(0xFF2E2647);
  static const Color accentOrange = Color(0xFFFF9F1C);
  static const Color secondaryText = Color(0xFFA8A1B8);

  @override
  Widget build(BuildContext context) {
    final ListProdukController controller = Get.put(ListProdukController());

    return Scaffold(
      backgroundColor: bgDark,
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.foodList.length,
          itemBuilder: (context, index) {
            final FoodModel food = controller.foodList[index];
            return Card(
              color: cardPurple,
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  controller.resetTransaksi(food);
                  Get.toNamed(Routes.detailProduk, arguments: food);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      // Gambar Makanan (mendukung Web CORS & Mobile)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 84,
                          height: 84,
                          color: surfacePurple,
                          child: Image.network(
                            food.gambar,
                            width: 84,
                            height: 84,
                            fit: BoxFit.cover,
                            webHtmlElementStrategy:
                                WebHtmlElementStrategy.prefer,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.fastfood_rounded,
                              color: accentOrange,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Nama Makanan, Deskripsi & Harga
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food.namaMakanan,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              food.deskripsi,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: secondaryText,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              food.hargaFormatted,
                              style: const TextStyle(
                                color: accentOrange,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: secondaryText,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
