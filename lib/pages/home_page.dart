import 'package:currency_converter/http/hg_finance_api/hg_finance_api_webclient.dart';
import 'package:currency_converter/main.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Requests
  final HgFinanceApiWebClient hgFinanceApiWebClient = HgFinanceApiWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('\$ Currency Converter \$')),
      backgroundColor: const Color(0xFF252526),
      body: FutureBuilder(
        future: hgFinanceApiWebClient.getHgFinanceApi(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text(
                  'Loading...',
                  style: TextStyle(color: mainColor, fontSize: 24),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.report_problem_rounded, size: 56),
                      Text(
                        'Loading failed :(',
                        style: TextStyle(color: mainColor, fontSize: 24),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.check_circle_outline, size: 56),
                      Text(
                        'I\'m ready :)',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
