import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:testban/models/txn_data.dart';
import 'package:testban/utils/constants.dart';

class TxnsService {
  SharedPreferences prefs;
  String token;
  TxnData _txnData;
  List<TxnData> _txnsList = List();

  Future<List<TxnData>> getTxns({page = 1}) async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    try {

      //hardcoded response

      final res = '{"data":[{"id":1,"service":"Withdrawal","msisdn":"0977322133","amount":2.0,"ref":"1234","meter_number":"74000387261","status":"success","txn_date":"2020-07-01 12:00:00","txn_time":"2020-07-01 12:00:00"},{"id":1,"service":"Withdrawal","msisdn":"0977322133","amount":2.0,"ref":"1234","meter_number":"74000387261","status":"success","txn_date":"2020-07-01 12:00:00","txn_time":"2020-07-01 12:00:00"},{"id":1,"service":"Withdrawal","msisdn":"0977322133","amount":2.0,"ref":"1234","meter_number":"74000387261","status":"success","txn_date":"2020-07-01 12:00:00","txn_time":"2020-07-01 12:00:00"},{"id":1,"service":"Withdrawal","msisdn":"0977322133","amount":2.0,"ref":"1234","meter_number":"74000387261","status":"success","txn_date":"2020-07-01 12:00:00","txn_time":"2020-07-01 12:00:00"}]}';

      //list of 10 TXNDATA

      /*await http.get(
        '$API_BASE_URL/transaction.php?page=$page&limit=10',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );*/
      Map resData = json.decode(
          res

      );
      print('All data is'+ resData.toString());
      if (true) {
        _txnsList = List<TxnData>.from(
            resData['data'].map((txn) => TxnData.fromJson(txn))
        );
         print('what is happening ${_txnsList}');
        return Future.value(_txnsList);
      } else {
        return Future.error("Failed get user Transactions");
      }
    }
    catch (e) {
      return Future.error(
          "Failed to get user Transactions make sure you have internet connection" +e.toString());
    }
  }
}
