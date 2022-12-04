import 'package:currency_converter/pages/home_page.dart';
import 'package:flutter/material.dart';

const Color mainColor = Color(0xFFEDA800);

void main() {
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
          subtitle1: TextStyle(color: mainColor, fontSize: 20),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
          ),
          prefixStyle: TextStyle(color: mainColor.withOpacity(0.8), fontSize: 20),
          labelStyle: TextStyle(color: mainColor.withOpacity(0.8), fontSize: 20),
        ),
      ),
      home: const Home(),
    );
  }
}
