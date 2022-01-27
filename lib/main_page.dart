import 'package:calculator_app/Input_widget.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double hargaTotal = 0;
  String? hargaText;

  hitungBerat() {
    beratMaterialUtuh = rumusBeratMaterialUtuh(
      panjangController.text == '' ? 0 : int.parse(panjangController.text),
      lebarController.text == '' ? 0 : int.parse(lebarController.text),
      selectedKetebalan == null ? 0 : double.parse(selectedKetebalan!),
      selectedMaterial ?? 'none',
    );
  }

  hitungBeratMaterialCutting() {
    beratMaterialCutting = rumusBeratMaterialUtuh(
      panjangLaserCuttingController.text == ''
          ? 0
          : int.parse(panjangLaserCuttingController.text),
      lebarLaserCuttingController.text == ''
          ? 0
          : int.parse(lebarLaserCuttingController.text),
      selectedKetebalan == null ? 0 : double.parse(selectedKetebalan!),
      selectedMaterial ?? 'none',
    );
  }

  hitungHargaJasaLaser() {
    hargaJasaLaser = rumusHargaJasaLaserCutting(
      beratMaterialCutting,
      pengerjaanDesainController.text == ''
          ? 0
          : double.parse(pengerjaanDesainController.text),
      hargaLaserController.text == '' ? '0' : hargaLaserController.text,
      selectedKerumitan == null ? '0' : selectedKerumitan!,
      selectedFinishing ?? '0',
    );
  }

  hitungHarga() {
    totalHargaMaterial = rumusHargaMaterial(
      beratMaterialUtuh,
      hargaMaterialController.text,
    );
  }

  count() {
    double penambahan =
        profitController.text == '' ? 0 : double.parse(profitController.text);
    setState(() {
      double hpp = (totalHargaMaterial +
              hargaJasaLaser +
              hargaPackaging +
              ((hargaJasaLaser + hargaPackaging) * 0.3)) *
          jumlahItem;
      double hargaJual = hpp + (hpp * (penambahan / 100));
      hargaTotal = hargaJual;
      hargaText = NumberFormat.simpleCurrency(
        name: 'Rp. ',
        locale: 'id',
      ).format(hargaTotal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Align(
            alignment: Alignment.topCenter,
            child: ListView(
              padding: EdgeInsets.symmetric(
                vertical: 50,
                horizontal: MediaQuery.of(context).size.width > 800
                    ? MediaQuery.of(context).size.width * 0.3
                    : 0,
              ),
              shrinkWrap: true,
              children: [
                CustomTitle(
                  text: 'Material',
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: selectedMaterial == null
                          ? Text('Material')
                          : Text(
                              selectedMaterial!,
                              style: TextStyle(color: Colors.black),
                            ),
                      isExpanded: true,
                      style: TextStyle(color: Colors.black),
                      iconSize: 30.0,
                      items: material.map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(
                              val,
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            selectedMaterial = val as String?;
                            if (selectedMaterial == 'MS' ||
                                selectedMaterial == 'SUS') {
                              hargaLaserController.text = '35000';
                            } else {
                              hargaLaserController.text = '35000';
                            }
                            hitungBerat();
                            hitungHarga();
                            hitungBeratMaterialCutting();
                            hitungHargaJasaLaser();
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    hintText: 'Harga material / Kg',
                    suffixText: 'rupiah',
                    controller: hargaMaterialController,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      setState(() {
                        hitungHarga();
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: 'Panjang',
                          suffixText: 'mm',
                          controller: panjangController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              hitungBerat();
                              hitungHarga();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextField(
                          hintText: 'Lebar',
                          suffixText: 'mm',
                          controller: lebarController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              hitungBerat();
                              hitungHarga();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: selectedKetebalan == null
                          ? Text('Tebal material')
                          : Text(
                              selectedKetebalan!,
                              style: TextStyle(color: Colors.black),
                            ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.black),
                      items: ketebalan.map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val + ' mm'),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            selectedKetebalan = val as String?;

                            hitungBerat();
                            hitungHarga();
                            hitungBeratMaterialCutting();
                            hitungHargaJasaLaser();
                          },
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Berat material utuh'),
                      Text(
                        beratMaterialUtuh.toString() + ' kg',
                        style: TextStyle(
                          color: Color(0xFF148CB1),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total harga material'),
                      Text(
                        NumberFormat.simpleCurrency(
                          name: 'Rp. ',
                          locale: 'id',
                        ).format(totalHargaMaterial),
                        style: TextStyle(
                          color: Color(0xFF148CB1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTitle(
                  text: 'Laser Cutting',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    hintText: 'Pengerjaan desain & setting parameter',
                    suffixText: 'jam',
                    controller: pengerjaanDesainController,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      setState(() {
                        hitungHargaJasaLaser();
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: 'Panjang',
                          suffixText: 'mm',
                          controller: panjangLaserCuttingController,
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            setState(() {
                              hitungBeratMaterialCutting();
                              hitungHargaJasaLaser();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextField(
                          hintText: 'Lebar',
                          suffixText: 'mm',
                          controller: lebarLaserCuttingController,
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            setState(() {
                              hitungBeratMaterialCutting();
                              hitungHargaJasaLaser();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: selectedKerumitan == null
                          ? Text('Kerumitan')
                          : Text(
                              selectedKerumitan!,
                              style: TextStyle(color: Colors.black),
                            ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.black),
                      items: kerumitan.map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            selectedKerumitan = val as String;

                            hitungHargaJasaLaser();
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: selectedFinishing == null
                            ? Text('Finishing')
                            : Text(
                                selectedFinishing!,
                                style: TextStyle(color: Colors.black),
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(color: Colors.black),
                        items: finishing.map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              selectedFinishing = val as String?;

                              hitungHargaJasaLaser();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    hintText: 'Harga laser cutting / Kg',
                    suffixText: 'rupiah',
                    controller: hargaLaserController,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      setState(() {
                        hitungHargaJasaLaser();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '*harga laser cutting / kg',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Harga jasa laser'),
                      Text(
                        NumberFormat.simpleCurrency(
                          name: 'Rp. ',
                          locale: 'id',
                        ).format(hargaJasaLaser +
                            (selectedMaterial == 'AL' ? 40000 : 0)),
                        style: TextStyle(
                          color: Color(0xFF148CB1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: selectedPackaging == null
                          ? Text('Packaging')
                          : Text(
                              selectedPackaging!,
                              style: TextStyle(color: Colors.black),
                            ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.black),
                      items: packaging.map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            selectedPackaging = val as String?;
                            if (selectedPackaging == 'kardus') {
                              rumusBeratPackaging(
                                double.parse(
                                    panjangLaserCuttingController.text),
                              );
                            } else {
                              beratPackaging = 0;
                            }
                            hargaPackaging = rumusHargaPackaging(
                              selectedPackaging ?? 'none',
                              double.parse(panjangLaserCuttingController.text),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    hintText: 'Jumlah',
                    controller: jumlahController,
                    keyboardType: TextInputType.number,
                    suffixText: 'pcs',
                    onChanged: (val) {
                      setState(() {
                        if (val != '') {
                          jumlahItem = double.parse(jumlahController.text);
                        } else {
                          jumlahItem = 1;
                        }
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Estimasi berat pengiriman'),
                      Text(
                        '${(beratMaterialCutting - (beratMaterialCutting * 0.3)) + beratPackaging} kg',
                        style: TextStyle(
                          color: Color(0xFF148CB1),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Harga produksi / pcs (tanpa material)'),
                      Text(
                        NumberFormat.simpleCurrency(
                          name: 'Rp. ',
                          locale: 'id',
                        ).format(hargaJasaLaser +
                            hargaPackaging +
                            ((hargaJasaLaser + hargaPackaging) * 0.3)),
                        style: TextStyle(
                          color: Color(0xFF148CB1),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total harga produksi (tanpa material)'),
                      Text(
                        NumberFormat.simpleCurrency(
                          name: 'Rp. ',
                          locale: 'id',
                        ).format((hargaJasaLaser +
                                hargaPackaging +
                                ((hargaJasaLaser + hargaPackaging) * 0.3)) *
                            jumlahItem),
                        style: TextStyle(
                          color: Color(0xFF148CB1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total harga produksi (dengan material)'),
                      Text(
                        NumberFormat.simpleCurrency(
                          name: 'Rp. ',
                          locale: 'id',
                        ).format((totalHargaMaterial +
                                hargaJasaLaser +
                                hargaPackaging +
                                ((hargaJasaLaser + hargaPackaging) * 0.3)) *
                            jumlahItem),
                        style: TextStyle(
                          color: Color(0xFF148CB1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTitle(text: 'Profit'),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    hintText: 'Profit total',
                    controller: profitController,
                    keyboardType: TextInputType.number,
                    suffixText: '%',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              panjangController.text = '';
                              lebarController.text = '';
                              jumlahController.text = '1';
                              panjangLaserCuttingController.text = '';
                              lebarLaserCuttingController.text = '';
                              hargaMaterialController.text = '';
                              hargaLaserController.text = '';
                              pengerjaanDesainController.text = '';
                              profitController.text = '';
                              selectedKetebalan = null;
                              selectedMaterial = null;
                              selectedKerumitan = null;
                              selectedFinishing = null;
                              selectedPackaging = null;
                              hargaTotal = 0;
                              jumlahItem = 1;
                              beratMaterialUtuh = 0;
                              beratMaterialCutting = 0;
                              totalHargaMaterial = 0;
                              hargaJasaLaser = 0;
                              estimasiBeratPengiriman = 0;
                              hargaProduksi = 0;
                              totalHargaProduksi = 0;
                              hargaPackaging = 0;
                              beratPackaging = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                            height: 38,
                            alignment: Alignment.center,
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: count,
                          child: Container(
                            height: 38,
                            alignment: Alignment.center,
                            color: Color(0xFF148CB1),
                            child: Text(
                              'Hitung',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text('Harga Jual'),
                      hargaTotal == 0
                          ? Text(
                              'Rp. 0',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF148CB1),
                              ),
                            )
                          : SelectableText(
                              '$hargaText',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF148CB1),
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Anda mendapatkan keuntungan ' +
                          NumberFormat.simpleCurrency(
                            name: 'Rp. ',
                            locale: 'id',
                          ).format(
                            hargaTotal -
                                ((totalHargaMaterial +
                                        hargaJasaLaser +
                                        hargaPackaging) *
                                    jumlahItem),
                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'v 1.2.0',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showToast({required String message}) {
    return Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      gravity: ToastGravity.TOP,
    );
  }
}

// if (panjangController.text == '' || lebarController.text == '') {
    //   showToast(message: 'panjang / lebar masih kosong!');
    // } else if (selectedKetebalan == null) {
    //   showToast(message: 'ketebalan masih kosong!');
    // } else if (selectedKerumitan == null) {
    //   showToast(message: 'kerumitan masih kosong!');
    // } else if (jumlahController.text == '') {
    //   showToast(message: 'jumlah masih kosong!');
    // } else {
    //   setState(() {
    //     if (selectedMaterial == null) selectedMaterial = 'none';
    //     if (selectedFinishing == null) selectedFinishing = 'none';
    //     if (selectedPackaging == null) selectedPackaging = 'no';
    //     double hasil = hitung(
    //       int.parse(panjangController.text),
    //       int.parse(lebarController.text),
    //       double.parse(selectedKetebalan!),
    //       selectedMaterial!,
    //       selectedKerumitan!,
    //       selectedFinishing!,
    //       selectedPackaging!,
    //     );
    //     double edited = ((hasil / 1000) + 0.5);
    //     double round =
    //         (edited.roundToDouble()) * 1000 * int.parse(jumlahController.text);

    //     hpp = NumberFormat.simpleCurrency(
    //       name: 'Rp. ',
    //       locale: 'id',
    //     ).format(round);
    //   });
    // }