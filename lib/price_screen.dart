import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/coin_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Coin_helper coin = new Coin_helper();

  String selectedProperty = 'USD';
  var btc_rate, eth_rate, ltc_rate;

  updateUI() async {
    var btc = await coin.getCoinRate(selectedProperty, cryptoList[0]);
    var eth = await coin.getCoinRate(selectedProperty, cryptoList[1]);
    var ltc = await coin.getCoinRate(selectedProperty, cryptoList[2]);
    setState(() {
      btc_rate = btc['rate'];
      eth_rate = eth['rate'];
      ltc_rate = ltc['rate'];
    });
  }

  @override
  initState() {
    updateUI();
    super.initState();
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) async {
          var btc = await coin.getCoinRate(selectedProperty, cryptoList[0]);
          var eth = await coin.getCoinRate(selectedProperty, cryptoList[1]);
          var ltc = await coin.getCoinRate(selectedProperty, cryptoList[2]);
          setState(() {
            selectedProperty = currenciesList[selectedIndex];
            btc_rate = btc['rate'];
            eth_rate = eth['rate'];
            ltc_rate = ltc['rate'];
          });
        },
        children: pickerItems);
  }

  DropdownButton<String> AndroidDropDown() {
    List<DropdownMenuItem<String>> dropdownitems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownitems.add(newItem);
    }

    return DropdownButton<String>(
        value: selectedProperty,
        items: dropdownitems,
        onChanged: (value) async {
          var btc = await coin.getCoinRate(selectedProperty, cryptoList[0]);
          var eth = await coin.getCoinRate(selectedProperty, cryptoList[1]);
          var ltc = await coin.getCoinRate(selectedProperty, cryptoList[2]);
          setState(() {
            selectedProperty = value;
            btc_rate = btc['rate'];
            btc_rate = eth['rate'];
            btc_rate = ltc['rate'];
          });
        });
  }

  Widget getPicker() {
    // return iOSPicker();
    if (Platform.isIOS) {
      return iOSPicker();
    } else {
      return AndroidDropDown();
    }
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: btc_rate != null
                        ? Text(
                            '1 ${cryptoList[0]} = ${btc_rate.toInt()} $selectedProperty',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            '1 ${cryptoList[0]} = ? USD',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: eth_rate != null
                        ? Text(
                            '1 ${cryptoList[1]} = ${eth_rate.toInt()} $selectedProperty',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            '1 ${cryptoList[1]} = ? USD',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: ltc_rate != null
                        ? Text(
                            '1 ${cryptoList[2]} = ${ltc_rate.toInt()} $selectedProperty',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            '1 ${cryptoList[2]} = ? USD',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getPicker()),
        ],
      ),
    );
  }
}

// DropdownButton<String>(
//                 value: selectedProperty,
//                 items: getDropDownItems(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedProperty = value;
//                   });
//                 }),
