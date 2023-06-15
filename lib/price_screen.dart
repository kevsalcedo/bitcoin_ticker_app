import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_app/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinDataModel coinDataModel = CoinDataModel();

  String selectedCurrency = 'AUD';

  late int foreignExchange;

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  Map<String, String> coinValues = {};

  bool isWaiting = false;

  void updateUI() async {
    isWaiting = true;

    try {
      var coinData = await coinDataModel.getCoinData(selectedCurrency);
      setState(() {
        if (coinData == null) {
          foreignExchange = 0;
          return;
        }
        double exchange = coinData['rate'];
        foreignExchange = exchange.toInt();
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          updateUI();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> coinList = [];

    List<Widget> getPickerItems() {
      for (String coin in currenciesList) {
        var currency = Text(coin);
        coinList.add(currency);
      }
      return coinList;
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (int selectedIndex) {
        print(selectedIndex);
        selectedCurrency = coinList[selectedIndex].toString();
        updateUI();
      },
      children: getPickerItems(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $foreignExchange $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}
