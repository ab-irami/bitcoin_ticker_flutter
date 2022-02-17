import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const url = 'http://rest.coinapi.io/v1/exchangerate';
const apiKey = 'CCE7B9AB-7864-450F-A29E-FD4869A40504';

class CoinData {
  Future getCoinData(String? selectedCurrency) async {
    Map<String, String> mapResult = {};
    for (String cryptoCoin in cryptoList) {
      http.Response response = await http
          .get(Uri.parse('$url/$cryptoCoin/$selectedCurrency?apikey=$apiKey'));

      if (response.statusCode == 200) {
        var data = response.body;
        var result = jsonDecode(data);
        var price = result['rate'];
        mapResult[cryptoCoin] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Error getting request';
      }
    }
    return mapResult;
  }
}
