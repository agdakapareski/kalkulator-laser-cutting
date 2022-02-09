import 'package:flutter/material.dart';

TextEditingController panjangController = TextEditingController();
TextEditingController lebarController = TextEditingController();

TextEditingController panjangLaserCuttingController = TextEditingController();
TextEditingController lebarLaserCuttingController = TextEditingController();

TextEditingController estimasiPengerjaanMesinController =
    TextEditingController();

TextEditingController jumlahController = TextEditingController(text: '1');
TextEditingController hargaMaterialController = TextEditingController();
TextEditingController hargaLaserController = TextEditingController();
TextEditingController pengerjaanDesainController = TextEditingController();
TextEditingController profitController = TextEditingController();

double jumlahItem = 1;

double panjangLaserCutting = double.parse(panjangLaserCuttingController.text);
double lebarLaserCutting = double.parse(lebarLaserCuttingController.text);

double beratMaterialUtuh = 0;
double beratMaterialCutting = 0;

double totalHargaMaterial = 0;

double hargaJasaLaser = 0;

double estimasiBeratPengiriman = 0;
double hargaProduksi = 0;
double totalHargaProduksi = 0;

double hargaPackaging = 0;
double beratPackaging = 0;

String? selectedMaterial;
String? selectedKetebalan;
String? selectedKerumitan;
String? selectedPackaging;
String? selectedFinishing;
List<String> material = ['MS', 'SUS', 'AL'];
List<String> ketebalan = ['0.8', '1', '1.5', '2', '2.5', '3'];
List<String> kerumitan = ['low', 'medium', 'high'];
List<String> finishing = ['none', 'cat', 'cat 2 warna', 'polish'];
List<String> packaging = ['tanpa packaging', 'wrap', 'kardus'];

double hitungHargaBerdasarkanPanjang(double panjang, double harga) {
  if (panjang <= harga) {
    return harga;
  } else {
    return harga * (panjang / harga);
  }
}

double rumusHargaPackaging(String packaging, double panjang) {
  double hargaBahanPackaging = 0;

  if (packaging == 'wrap') {
    hargaBahanPackaging = hitungHargaBerdasarkanPanjang(panjang, 1000);
  } else if (packaging == 'kardus') {
    hargaBahanPackaging = hitungHargaBerdasarkanPanjang(panjang, 11000);
  } else {
    hargaBahanPackaging = 0;
  }

  return hargaBahanPackaging;
}

rumusBeratPackaging(double panjang) {
  beratPackaging = 0.5 * (panjang / 1000);
}

// fungsi untuk menghitung berat material sesuai ukuran
rumusBeratMaterialUtuh(
  int panjang,
  int lebar,
  double tebal,
  String material,
) {
  // variabel untuk menampung hasil perhitungan berat
  double berat = 0;

  // variabel berat jenis material MS
  double beratJenisMS = 7.85;

  double beratJenisSUS = 7.92;

  // variabel berat jenis material AL
  double beratJenisAL = 2.7;

  if (material == 'MS') {
    berat = (tebal * lebar.toDouble() * panjang.toDouble() * beratJenisMS) /
        1000000;
  } else if (material == 'SUS') {
    berat = (tebal * lebar.toDouble() * panjang.toDouble() * beratJenisSUS) /
        1000000;
  } else if (material == 'AL') {
    berat = (tebal * lebar.toDouble() * panjang.toDouble() * beratJenisAL) /
        1000000;
  } else {
    berat = 0;
  }

  return berat;
}

double rumusHargaMaterial(double berat, String inputHarga) {
  double hargaAngka = 0;
  if (inputHarga == '') {
    hargaAngka = 0;
  } else {
    hargaAngka = double.parse(inputHarga);
  }
  double harga = berat * hargaAngka;
  return harga;
}

double rumusHargaJasaLaserCutting(
  double estimasi,
  double desain,
  String hargaPerMenit,
  String packaging,
  double panjang,
) {
  double harga = 0;

  harga = (estimasi * double.parse(hargaPerMenit)) +
      (desain * 1000) +
      rumusHargaPackaging(packaging, panjang);

  return harga;
}

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Text(
        text!,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}

// hitung(int panjang, int lebar, double tebal, String material, String kerumitan,
//     String finishing, String packaging) {
//   double hargaMaterialPerKg = 0;
//   double hargaMS = 22000;
//   double hargaSUS = 90000;
//   double hargaAL = 90000;
//   double berat = 0;

//   double beratJenisMS = 7.85;
//   double beratJenisAL = 2.7;

//   double hargaCat = 8000;
//   double hargaPolish = 2000;

//   double hargaLaserMS = 18000;
//   double hargaLaserAL = 25000;
//   double hpp = 0;

//   double nilaiKerumitan = 0;
//   double hargaFinishing = 0;
//   double hargaPackaging = 0;

//   if (material == 'MS') hargaMaterialPerKg = hargaMS;
//   if (material == 'SUS') hargaMaterialPerKg = hargaSUS;
//   if (material == 'AL') hargaMaterialPerKg = hargaAL;
//   if (material == 'none') hargaMaterialPerKg = 0;

//   if (kerumitan == 'low') nilaiKerumitan = 1;
//   if (kerumitan == 'medium') nilaiKerumitan = 1.3;
//   if (kerumitan == 'high') nilaiKerumitan = 1.6;

//   if (finishing == 'cat') hargaFinishing = hargaCat;
//   if (finishing == 'polish') hargaFinishing = hargaPolish;
//   if (finishing == 'none') hargaFinishing = 0;

//   packaging == 'yes' ? hargaPackaging = 1000 : hargaPackaging = 0;

//   if (material == 'MS' || material == 'SUS') {
//     berat = (tebal * lebar.toDouble() * panjang.toDouble() * beratJenisMS) /
//         1000000;
//   } else {
//     berat = (tebal * lebar.toDouble() * panjang.toDouble() * beratJenisAL) /
//         1000000;
//   }

//   if (material == "MS" || material == "SUS") {
//     hpp = berat *
//         nilaiKerumitan *
//         (hargaMaterialPerKg + hargaLaserMS + hargaFinishing + hargaPackaging);
//   } else {
//     hpp = berat *
//         nilaiKerumitan *
//         (hargaMaterialPerKg + hargaLaserAL + hargaFinishing + hargaPackaging);
//   }

//   return hpp;
// }
