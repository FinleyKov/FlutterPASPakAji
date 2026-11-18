class FoodModel {
  final int no;
  final String namaMakanan;
  final int harga;
  final String deskripsi;
  final String gambar;
  final String kategori;

  const FoodModel({
    required this.no,
    required this.namaMakanan,
    required this.harga,
    required this.deskripsi,
    required this.gambar,
    this.kategori = 'Kuliner Nusantara',
  });

  String get hargaFormatted => formatRupiah(harga);

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      no: map['no'] as int? ?? 0,
      namaMakanan: map['namaMakanan']?.toString() ?? '',
      harga: map['harga'] as int? ?? 0,
      deskripsi: map['deskripsi']?.toString() ?? '',
      gambar: map['gambar']?.toString() ?? '',
      kategori: map['kategori']?.toString() ?? 'Kuliner Nusantara',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'namaMakanan': namaMakanan,
      'harga': harga,
      'deskripsi': deskripsi,
      'gambar': gambar,
      'kategori': kategori,
    };
  }
}

String formatRupiah(num number) {
  final intVal = number.round();
  final str = intVal.toString();
  final buffer = StringBuffer();
  int count = 0;
  for (int i = str.length - 1; i >= 0; i--) {
    buffer.write(str[i]);
    count++;
    if (count % 3 == 0 && i != 0) {
      buffer.write('.');
    }
  }
  return 'Rp${buffer.toString().split('').reversed.join()}';
}
