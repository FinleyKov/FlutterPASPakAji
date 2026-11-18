import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasflutter/models/product_model.dart';

class ListProdukController extends GetxController {
  // Sumber data dummy lokal makanan (Lampiran Data Dummy Makanan pada Soal PAS)
  final RxList<FoodModel> foodList = <FoodModel>[
    const FoodModel(
      no: 1,
      namaMakanan: 'Nasi Goreng Spesial',
      harga: 25000,
      deskripsi:
          'Nasi goreng bumbu rempah dengan telur mata sapi, ayam suwir, dan kerupuk.',
      gambar:
          'https://images.unsplash.com/photo-1603133872878-684f208fb84b?auto=format&fit=crop&w=800&q=80',
      kategori: 'Makanan Utama',
    ),
    const FoodModel(
      no: 2,
      namaMakanan: 'Ayam Bakar Madu',
      harga: 30000,
      deskripsi:
          'Ayam bakar olesan madu murni lengkap dengan sambal terasi dan lalapan.',
      gambar:
          'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?auto=format&fit=crop&w=800&q=80',
      kategori: 'Makanan Utama',
    ),
    const FoodModel(
      no: 3,
      namaMakanan: 'Sate Ayam Madura',
      harga: 28000,
      deskripsi:
          '10 tusuk sate ayam daging pilihan dengan siraman bumbu kacang kental.',
      gambar:
          'https://images.unsplash.com/photo-1529563021893-cc83c992d75d?auto=format&fit=crop&w=800&q=80',
      kategori: 'Khas Nusantara',
    ),
    const FoodModel(
      no: 4,
      namaMakanan: 'Mie Ayam Bakso',
      harga: 20000,
      deskripsi:
          'Mie kenyal dengan topping ayam kecap, sawi hijau, dan 2 butir bakso sapi.',
      gambar:
          'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=800&q=80',
      kategori: 'Mie & Bakso',
    ),
    const FoodModel(
      no: 5,
      namaMakanan: 'Es Teh Manis Jumbo',
      harga: 8000,
      deskripsi:
          'Minuman teh melati segar dengan gula asli dan es batu kristal.',
      gambar:
          'https://images.unsplash.com/photo-1556679343-c7306c1976bc?auto=format&fit=crop&w=800&q=80',
      kategori: 'Minuman Segar',
    ),
  ].obs;

  // State untuk halaman Transaksi Pembelian
  final TextEditingController txtJumlah = TextEditingController(text: '1');
  final RxInt jumlahBeli = 1.obs;
  final RxDouble subtotal = 0.0.obs;
  final RxDouble ppn = 0.0.obs;
  final RxDouble totalBayar = 0.0.obs;
  final RxBool sudahDihitung = false.obs;

  void resetTransaksi(FoodModel food) {
    jumlahBeli.value = 1;
    txtJumlah.text = '1';
    sudahDihitung.value = false;
    subtotal.value = 0;
    ppn.value = 0;
    totalBayar.value = 0;
  }

  void tambahJumlah() {
    final current = int.tryParse(txtJumlah.text.trim()) ?? jumlahBeli.value;
    final next = current + 1;
    jumlahBeli.value = next;
    txtJumlah.text = next.toString();
  }

  void kurangJumlah() {
    final current = int.tryParse(txtJumlah.text.trim()) ?? jumlahBeli.value;
    if (current > 1) {
      final next = current - 1;
      jumlahBeli.value = next;
      txtJumlah.text = next.toString();
    }
  }

  void onJumlahChanged(String value) {
    final parsed = int.tryParse(value.trim());
    if (parsed != null && parsed > 0) {
      jumlahBeli.value = parsed;
    }
  }

  /// Menghitung rincian pembayaran sesuai rumus pada soal:
  /// Subtotal = Harga Makanan x Jumlah Makanan
  /// PPN (5%) = Subtotal x 0.05
  /// Total Bayar = Subtotal + PPN (5%)
  bool hitungPembayaran(FoodModel food) {
    final qty = int.tryParse(txtJumlah.text.trim()) ?? 0;
    if (qty <= 0) {
      Get.snackbar(
        'Input Tidak Valid',
        'Masukkan jumlah makanan yang valid (minimal 1 porsi).',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFD32F2F),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
      );
      return false;
    }

    jumlahBeli.value = qty;
    subtotal.value = (food.harga * qty).toDouble();
    ppn.value = subtotal.value * 0.05;
    totalBayar.value = subtotal.value + ppn.value;
    sudahDihitung.value = true;
    return true;
  }

  @override
  void onClose() {
    txtJumlah.dispose();
    super.onClose();
  }
}
