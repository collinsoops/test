import 'package:flutter/material.dart';

void showMySnackBar(String msg, GlobalKey<ScaffoldState> scaffoldKey,BuildContext context) {
  final snackBar = SnackBar(
    content: Text(msg),
    // backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
