import 'package:currency_converter/pages/home_page.dart';
import 'package:flutter/material.dart';

const Color mainColor = Color(0xFFEDA800);

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: mainColor,
        ),
        iconTheme: const IconThemeData(color: mainColor),
        textTheme: const TextTheme(
          button: TextStyle(color: Colors.white),
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: const Home(),
    );
  }
}
