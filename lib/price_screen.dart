import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'package:http/http.dart' as http;
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String apiKey = "/?apikey=379BEA23-64D3-49F1-9BE3-81DD4280B1D8";
  // https://rest.coinapi.io/v1/exchangerate/BTC/USD/?apikey=379BEA23-64D3-49F1-9BE3-81DD4280B1D8
  String selectedCurrency = 'USD';
  String hashString = '/';
  String crypBtc = 'BTC';
  String crypEth = 'ETH';
  String crypLtc = 'LTC';
  var btcValue;
  var ethValue;
  var ltcValue;

  getDataBtc() async {
    String apiUrl = "https://rest.coinapi.io/v1/exchangerate/";
    var response = await http.get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/BTC/USD/?apikey=379BEA23-64D3-49F1-9BE3-81DD4280B1D8'));
    // var response = await http.get(Uri.parse(apiUrl+crypBtc+hashString+selectedCurrency+apiKey));
    var jsonData = jsonDecode(response.body);
    btcValue = jsonData["rate"];
    return print(jsonData);
  }
  getDataEth() async {
    String apiUrl = "https://rest.coinapi.io/v1/exchangerate/";
    // var response = await http.get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/BTC/USD/?apikey=379BEA23-64D3-49F1-9BE3-81DD4280B1D8'));
    var response = await http.get(Uri.parse(apiUrl+crypEth+hashString+selectedCurrency+apiKey));
    var jsonData = jsonDecode(response.body);
    ethValue = jsonData["rate"];
    return ethValue;
  }
  getDataLtc() async {
    String apiUrl = "https://rest.coinapi.io/v1/exchangerate/";
    // var response = await http.get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/BTC/USD/?apikey=379BEA23-64D3-49F1-9BE3-81DD4280B1D8'));
    var response = await http.get(Uri.parse(apiUrl+crypLtc+hashString+selectedCurrency+apiKey));
    var jsonData = jsonDecode(response.body);
    ltcValue = jsonData["rate"];
    return ltcValue;
  }

  List<DropdownMenuItem> getDropDownItems(){
    List<DropdownMenuItem<String>> dropDownItem =[];
    for(var i =0; i<currenciesList.length; i++){
      var newItem = DropdownMenuItem(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(currenciesList[i].toString(),textAlign: TextAlign.center),
        ],
      ),
        value: currenciesList[i].toString(),
      );
      dropDownItem.add(newItem);
    };
    return dropDownItem;
  }

  CupertinoPicker iosPicker(){
   return CupertinoPicker(
      itemExtent: 50.0,
      onSelectedItemChanged: (selectedIndex){
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
      },
      children: getDropDownItems(),
    );
  }

  @override
  Widget build(BuildContext context) {
    getDataBtc();
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
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $btcValue $selectedCurrency',
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
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $ethValue $selectedCurrency',
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
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $ltcValue $selectedCurrency',
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
            child: iosPicker(),
          ),
        ],
      ),
    );
  }
}