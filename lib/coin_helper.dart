import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = "492BA903-3FE6-4F72-956F-0A4E5730B7E3";

class Coin_helper {
  Future<dynamic> getCoinRate(String currency, String coin) async {
    http.Response response = await http.get(
        "https://rest.coinapi.io/v1/exchangerate/${coin}/${currency}?apikey=$apiKey");

    // print(response.body);
    var data = jsonDecode(response.body);
    return data;
  }
}
