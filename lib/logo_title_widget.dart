import 'package:flutter/material.dart';

class LogoTitleWidget extends StatelessWidget {
  const LogoTitleWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Image.asset(
            'assets/logo.png',
            height: 38,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Kalkulator Harga Laser Cutting',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
