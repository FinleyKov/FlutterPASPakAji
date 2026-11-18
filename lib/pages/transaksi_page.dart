import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasflutter/controller/list_produk_controller.dart';
import 'package:pasflutter/models/product_model.dart';

class TransaksiPage extends StatelessWidget {
  const TransaksiPage({super.key});

  static const Color bgDark = Color(0xFF161224);
  static const Color cardPurple = Color(0xFF221C35);
  static const Color surfacePurple = Color(0xFF2E2647);
  static const Color accentOrange = Color(0xFFFF9F1C);
  static const Color accentMint = Color(0xFF00E676);
  static const Color secondaryText = Color(0xFFA8A1B8);

  @override
  Widget build(BuildContext context) {
    final ListProdukController controller = Get.find<ListProdukController>();
    final FoodModel food = (Get.arguments is FoodModel)
        ? Get.arguments as FoodModel
        : controller.foodList.first;

    return Scaffold(
      backgroundColor: bgDark,
      appBar: AppBar(
        backgroundColor: cardPurple,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Transaksi Pembelian',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Detail Makanan beserta Gambar
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: double.infinity,
                        height: 190,
                        child: Image.network(
                          food.gambar,
                          width: double.infinity,
                          height: 190,
                          fit: BoxFit.cover,
                          webHtmlElementStrategy:
                              WebHtmlElementStrategy.prefer,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: surfacePurple,
                            child: const Center(
                              child: Icon(
                                Icons.fastfood,
                                color: accentOrange,
                                size: 48,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      food.namaMakanan,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      food.hargaFormatted,
                      style: const TextStyle(
                        color: accentOrange,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      food.deskripsi,
                      style: const TextStyle(
                        color: secondaryText,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Input Jumlah Makanan & Tombol Bayar
            Card(
              color: cardPurple,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Jumlah Pembelian',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: controller.txtJumlah,
                      keyboardType: TextInputType.number,
                      onChanged: controller.onJumlahChanged,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Masukkan jumlah makanan',
                        hintStyle: const TextStyle(
                          color: secondaryText,
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: surfacePurple,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        controller.hitungPembayaran(food);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentOrange,
                        foregroundColor: bgDark,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Bayar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Hasil Perhitungan Rincian Pembayaran
            Obx(() {
              if (!controller.sudahDihitung.value) {
                return const SizedBox.shrink();
              }
              return Card(
                color: cardPurple,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Rincian Pembayaran',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(color: Colors.white24, height: 20),
                      _buildRow(
                        'Subtotal',
                        formatRupiah(controller.subtotal.value),
                      ),
                      const SizedBox(height: 8),
                      _buildRow(
                        'PPN (5%)',
                        formatRupiah(controller.ppn.value),
                      ),
                      const Divider(color: Colors.white24, height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Bayar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            formatRupiah(controller.totalBayar.value),
                            style: const TextStyle(
                              color: accentMint,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: secondaryText, fontSize: 14),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
