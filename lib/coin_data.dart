import 'package:bitcoin_ticker_app/networking.dart';
import 'package:bitcoin_ticker_app/price_screen.dart';

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

const apiKey = 'B3A4FAC1-404A-4184-B98F-D849479279D6';
const coinApiURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinDataModel {
  Future<dynamic> getCoinData(String currency) async {
    var url = '$coinApiURL/BTC/$currency?apikey=$apiKey';

    NetworkHelper networkHelper = NetworkHelper(url);

    var coinData = await networkHelper.getData();

    print(coinData);
    return coinData;
  }
}
