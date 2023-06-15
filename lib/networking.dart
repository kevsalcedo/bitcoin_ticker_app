import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      double currencyPrice = data['rate'];
      return currencyPrice.toStringAsFixed(0);
    } else {
      print(response.statusCode);
    }
  }
}
