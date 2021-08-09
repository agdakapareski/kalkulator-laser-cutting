import 'package:flutter/material.dart';

TextEditingController panjangController = TextEditingController();
TextEditingController lebarController = TextEditingController();
TextEditingController jumlahController = TextEditingController();
String? selectedMaterial;
String? selectedKetebalan;
String? selectedKerumitan;
String? selectedPackaging;
String? selectedFinishing;
List<String> material = ['MS', 'SUS', 'AL', 'none'];
List<String> ketebalan = ['0.8', '1', '1.5', '2', '3', '5'];
List<String> kerumitan = ['low', 'medium', 'high'];
List<String> finishing = ['none', 'cat', 'polish'];
List<String> packaging = ['yes', 'no'];

hitung(int panjang, int lebar, double tebal, String material, String kerumitan,
    String finishing, String packaging) {
  double hargaMaterialPerKg = 0;
  double hargaMS = 25000;
  double hargaSUS = 50000;
  double hargaAL = 40000;

  double hargaCat = 20000;
  double hargaPolish = 25000;

  double nilaiKerumitan = 0;
  double hargaFinishing = 0;
  double hargaPackaging = 0;

  if (material == 'MS') hargaMaterialPerKg = hargaMS;
  if (material == 'SUS') hargaMaterialPerKg = hargaSUS;
  if (material == 'AL') hargaMaterialPerKg = hargaAL;
  if (material == 'none') hargaMaterialPerKg = 0;

  if (kerumitan == 'low') nilaiKerumitan = 1;
  if (kerumitan == 'medium') nilaiKerumitan = 1.3;
  if (kerumitan == 'high') nilaiKerumitan = 1.6;

  if (finishing == 'cat') hargaFinishing = hargaCat;
  if (finishing == 'polish') hargaFinishing = hargaPolish;
  if (finishing == 'none') hargaFinishing = 0;

  packaging == 'yes' ? hargaPackaging = 1000 : hargaPackaging = 0;

  double berat =
      (tebal * lebar.toDouble() * panjang.toDouble() * 7.85) / 1000000;

  double hpp = berat *
      nilaiKerumitan *
      (hargaMaterialPerKg + 8000 + hargaFinishing + hargaPackaging);

  return hpp;
}
