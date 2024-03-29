import 'dart:async';
import 'dart:convert';

import 'package:testban/models/txn_data.dart';
import 'package:testban/services/txn_status_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/txn_service.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _recipientInputController = TextEditingController();
  TextEditingController _amountInputController = TextEditingController();
  bool _isLoading = false;
  String statusMsg = "";
  TxnService _txnService = TxnService();
  int _txnId;
  StreamSubscription txnStatusSub;

  void _submitService({@required String pathName}) async {
    String msisdn = _recipientInputController.text;
    double amount = double.parse(_amountInputController.text);

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 5));

    TxnData _txnData = await _txnService.processTxn('withdraw', msisdn, amount,
        pathName: pathName);
    _txnId = _txnData.txnId;

    Stream<TxnData> txnStatusStream = TxnStatusService(_txnId).stream;

    txnStatusSub = txnStatusStream.listen((txnData) {
      print(txnData.status);
    }, onError: (err) {
      print('Err: $err');
    }, onDone: () {
      setState(() {
        _isLoading = false;
      });
    }, cancelOnError: true);

    if (statusMsg.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(statusMsg),
        duration: Duration(seconds: 5),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (txnStatusSub != null) {
      txnStatusSub.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("service"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(children: <Widget>[
          TextField(
            controller: _recipientInputController..text = '0961453688',
            decoration: InputDecoration(
                labelText: "Recipient Number",
                hintText: "Enter Recipients Number",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
            keyboardType: TextInputType.number,
            onChanged: (val) {
              print(val);
            },
          ),
          SizedBox(height: 10),
          TextField(
            controller: _amountInputController..text = '1',
            decoration: InputDecoration(
                labelText: "Amount",
                hintText: "Enter Amount",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
            keyboardType: TextInputType.number,
            onChanged: (val) {
              print(val);
            },
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
                labelText: "Reference(Optional)",
                hintText: "Enter Reference",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
            keyboardType: TextInputType.text,
            onChanged: (val) {
              print(val);
            },
          ),
          SizedBox(height: 10),
          (_isLoading)
              ? CircularProgressIndicator()
              : ElevatedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    _submitService(pathName: "withdraw");
                  }),
          SizedBox(height: 10),
        ]),
      ),
    );
  }
}

class MySnackBar extends StatelessWidget {
  final bool isError;
  final String msg;

  // In the constructor, require a Todo
  // MySnackBar({Key key, @required this.isError}) : super(key: key);
  MySnackBar({Key key, this.isError, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
