import 'package:currency_converter/http/hg_finance_api/hg_finance_api_webclient.dart';
import 'package:currency_converter/main.dart';
import 'package:currency_converter/models/currency_model.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Requests
  final HgFinanceApiWebClient hgFinanceApiWebClient = HgFinanceApiWebClient();

  // Controllers
  final TextEditingController realInputController = TextEditingController();
  final TextEditingController dollarInputController = TextEditingController();
  final TextEditingController euroInputController = TextEditingController();
  final TextEditingController japaneseYenInputController = TextEditingController();
  final TextEditingController argentinePesoInputController = TextEditingController();
  final TextEditingController bitcoinInputController = TextEditingController();

  // States
  double real = 0;
  double dollarCurrentQuotation = 0;
  double euroCurrentQuotation = 0;
  double japaneseYenCurrentQuotation = 0;
  double argentinePesoCurrentQuotation = 0;
  double bitcoinCurrentQuotation = 0;

  // Functions
  void _convertCurrency(String value, CurrencyNamesEnum currencyName) {
    // Clean inputs
    if (value.isEmpty) {
      realInputController.clear();
      dollarInputController.clear();
      euroInputController.clear();
      japaneseYenInputController.clear();
      argentinePesoInputController.clear();
      bitcoinInputController.clear();
      return;
    }

    // Get input info
    final double valueParsed = double.parse(value);
    final double selectedQuotation = _getSelectedQuotation(currencyName);

    // Update "real" state value
    if (currencyName == CurrencyNamesEnum.real) {
      real = valueParsed;
    } else {
      real = valueParsed * selectedQuotation;
    }

    // Update input values
    _updateInputValues(currencyName);
  }

  double _getSelectedQuotation(CurrencyNamesEnum currencyName) {
    switch (currencyName) {
      case CurrencyNamesEnum.dollar:
        return dollarCurrentQuotation;
      case CurrencyNamesEnum.euro:
        return euroCurrentQuotation;
      case CurrencyNamesEnum.japaneseYen:
        return japaneseYenCurrentQuotation;
      case CurrencyNamesEnum.argentinePeso:
        return argentinePesoCurrentQuotation;
      case CurrencyNamesEnum.bitcoin:
        return bitcoinCurrentQuotation;
      default:
        return 1;
    }
  }

  void _updateInputValues(CurrencyNamesEnum currencyName) {
    if (currencyName != CurrencyNamesEnum.real) {
      realInputController.text = (real).toStringAsFixed(2);
    }
    if (currencyName != CurrencyNamesEnum.dollar) {
      dollarInputController.text = (real / dollarCurrentQuotation).toStringAsFixed(2);
    }
    if (currencyName != CurrencyNamesEnum.euro) {
      euroInputController.text = (real / euroCurrentQuotation).toStringAsFixed(2);
    }
    if (currencyName != CurrencyNamesEnum.japaneseYen) {
      japaneseYenInputController.text = (real / japaneseYenCurrentQuotation).toStringAsFixed(2);
    }
    if (currencyName != CurrencyNamesEnum.argentinePeso) {
      argentinePesoInputController.text = (real / argentinePesoCurrentQuotation).toStringAsFixed(2);
    }
    if (currencyName != CurrencyNamesEnum.bitcoin) {
      bitcoinInputController.text = (real / bitcoinCurrentQuotation).toStringAsFixed(8);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus(); // Keyboard dismiss when click outside
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            '\$ Currency Converter \$',
            style: TextStyle(color: backgroundColor),
          ),
        ),
        backgroundColor: backgroundColor,
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
                if (snapshot.hasError || snapshot.data == null) {
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
                  // Get API quotations
                  dollarCurrentQuotation = snapshot.data!['results']['currencies']['USD']['buy'];
                  euroCurrentQuotation = snapshot.data!['results']['currencies']['EUR']['buy'];
                  argentinePesoCurrentQuotation = snapshot.data!['results']['currencies']['ARS']['buy'];
                  japaneseYenCurrentQuotation = snapshot.data!['results']['currencies']['JPY']['buy'];
                  bitcoinCurrentQuotation = snapshot.data!['results']['currencies']['BTC']['buy'];

                  // Render input list
                  return SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag, // Keyboard dismiss on drag
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(Icons.monetization_on, size: 120),
                        const Divider(),
                        buildTextField(CurrencyNamesEnum.real, 'R\$', realInputController, _convertCurrency),
                        const Divider(),
                        buildTextField(CurrencyNamesEnum.dollar, '\$', dollarInputController, _convertCurrency),
                        const Divider(),
                        buildTextField(CurrencyNamesEnum.euro, '€', euroInputController, _convertCurrency),
                        const Divider(),
                        buildTextField(CurrencyNamesEnum.japaneseYen, '¥', japaneseYenInputController, _convertCurrency),
                        const Divider(),
                        buildTextField(CurrencyNamesEnum.argentinePeso, '\$', argentinePesoInputController, _convertCurrency),
                        const Divider(),
                        buildTextField(CurrencyNamesEnum.bitcoin, '₿', bitcoinInputController, _convertCurrency),
                      ],
                    ),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}

Widget buildTextField(CurrencyNamesEnum currencyName, String prefix, TextEditingController inputController, Function onChange) {
  return TextField(
    controller: inputController,
    onChanged: (value) {
      onChange(value, currencyName);
    },
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(
      labelText: '($prefix) ${currencyName.value}',
      prefixText: '$prefix ',
      border: const OutlineInputBorder(),
    ),
  );
}
