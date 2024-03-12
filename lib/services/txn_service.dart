import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:testban/models/txn_data.dart';
import 'package:testban/utils/constants.dart';

class TxnService {
  SharedPreferences prefs;
  String token;
  TxnData _txnData;

  Future<TxnData> processTxn(String service, String msisdn, double amount,
      {String ref = "",
      String meterNumber = "",
      @required String pathName}) async {
    // Hive.openBox('txnData');
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    // TxnData ds = {'amount': _txnData.amount} as TxnData;
    print("path " + pathName);
    //print (json1);

    try {
      final res = await http.post('$API_BASE_URL/$pathName',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode({
            "service": service,
            "msisdn": msisdn,
            "amount": amount,
            "ref": ref,
            "meter_number": meterNumber,
          }));
      Map resData = json.decode(res.body);

      print('checking responce  ${resData}');
      print('checking status ${res.statusCode}');
      _txnData = TxnData.fromJson(resData);
      if (res.statusCode == 200) {
        // Hive.box('txnData').add(_txnData);
        print(" transactions made now ${resData}");

        return Future.value(_txnData);
      } else if (resData['is_error']) {
        print('${resData}');
        // Map resData = json.decode(res.body);
        print('Failed to load');
        // _txnData = TxnData(isError: true);
        // Hive.box('txnData').add(_txnData);
        print('error  happend at ${_txnData}');
        return Future.value(_txnData);
      }
    } catch (e) {
      // print(e);
      _txnData = TxnData(isError: true);
      // Hive.box('txnData').add(_txnData);
      print('exception found here ${e.toString()}');
      return Future.value(_txnData);
    }
  }

  Future<TxnData> getTxn(int txnId) async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    try {
      //hardcoded res
      final res = "{'message':'success','data':{'txnId':1,'status':'TXN_SUCCESSFUL',amount':1000,'service':'Transaction','msisdn':'0971234567','serviceProvider':'Safaricom','serviceProvider,'serviceProvider,'serviceProvider}}";

      if (true) {
        Map resData = json.decode(res);
        print(' hi loging from as map $resData');
        // Hive.box('txnData').add(resData);
        if (resData['message'] == 'success') {
          _txnData = TxnData.fromJson(resData['data']);
          print(' hi from gettxn${_txnData.amount}');
          return Future.value(_txnData);
        } else if (resData['is_error']) {
          _txnData = TxnData(isError: true);
          print(' hi auth err$_txnData');
          return Future.value(_txnData);
        }
      }
    } catch (e) {
      _txnData = TxnData(isError: true);
      print('  catch err$_txnData');
      return Future.value(_txnData);
    }
  }
}
