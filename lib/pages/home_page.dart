import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('\$ Currency Converter')),
      backgroundColor: Color(0xFF252526),
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
