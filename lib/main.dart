import 'package:flutter/material.dart';

import 'main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Price Calculator',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
