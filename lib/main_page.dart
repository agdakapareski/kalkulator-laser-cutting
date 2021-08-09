import 'package:calculator_app/Input_widget.dart';
import 'package:calculator_app/logo_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String hpp = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width > 800
                ? MediaQuery.of(context).size.width * 0.4
                : MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: ListView(
              shrinkWrap: true,
              children: [
                LogoTitleWidget(),
                const SizedBox(
                  height: 25,
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
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextField(
                          hintText: 'Lebar',
                          suffixText: 'mm',
                          controller: lebarController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
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
                          ? Text('Ketebalan')
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
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
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
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 5),
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
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    hintText: 'Jumlah',
                    controller: jumlahController,
                    keyboardType: TextInputType.number,
                    suffixText: 'pcs',
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
                      Text('Harga'),
                      hpp == '0'
                          ? Text(
                              'Rp. 0',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : SelectableText(
                              '$hpp',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                              jumlahController.text = '';
                              selectedKetebalan = null;
                              selectedMaterial = null;
                              selectedKerumitan = null;
                              selectedFinishing = null;
                              selectedPackaging = null;
                              hpp = '0';
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                              height: 38,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 5,
                        child: GestureDetector(
                          onTap: () {
                            if (panjangController.text == '' ||
                                lebarController.text == '') {
                              showToast(
                                  message: 'panjang / lebar masih kosong!');
                            } else if (selectedKetebalan == null) {
                              showToast(message: 'ketebalan masih kosong!');
                            } else if (selectedKerumitan == null) {
                              showToast(message: 'kerumitan masih kosong!');
                            } else if (jumlahController.text == '') {
                              showToast(message: 'jumlah masih kosong!');
                            } else {
                              setState(() {
                                if (selectedMaterial == null)
                                  selectedMaterial = 'none';
                                if (selectedFinishing == null)
                                  selectedFinishing = 'none';
                                if (selectedPackaging == null)
                                  selectedPackaging = 'no';
                                double hasil = hitung(
                                  int.parse(panjangController.text),
                                  int.parse(lebarController.text),
                                  double.parse(selectedKetebalan!),
                                  selectedMaterial!,
                                  selectedKerumitan!,
                                  selectedFinishing!,
                                  selectedPackaging!,
                                );
                                double edited = ((hasil / 1000) + 0.5);
                                double round = (edited.roundToDouble()) *
                                    1000 *
                                    int.parse(jumlahController.text);

                                hpp = NumberFormat.simpleCurrency(
                                  name: 'Rp. ',
                                  locale: 'id',
                                ).format(round);
                              });
                            }
                          },
                          child: Container(
                            height: 38,
                            alignment: Alignment.center,
                            color: Color(0xFF268ECD),
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
                  height: 18,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Nego harga? Hubungi '),
                      InkWell(
                        child: Text(
                          'Om Heru',
                          style: TextStyle(
                            color: Color(0xFF268ECD),
                          ),
                        ),
                        onTap: () {
                          launch('https://wa.me/6281225829568');
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'v 1.0.0',
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
