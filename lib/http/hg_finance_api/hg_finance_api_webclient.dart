import 'dart:convert';

import 'package:http/http.dart';
import 'package:currency_converter/auth/secrets.dart';

final Client client = Client();

class HgFinanceApiWebClient {
  Future<Map<String, dynamic>> getHgFinanceApi() async {
    final Response response = await client.get(
      Uri.parse('https://api.hgbrasil.com/finance?key=$hgFinanceApiKey'),
    ); // Get API response JSON in string

    final Map<String, dynamic> responseBodyToJson = jsonDecode(response.body); // Convert string to JSON format

    return responseBodyToJson;
  }
}
