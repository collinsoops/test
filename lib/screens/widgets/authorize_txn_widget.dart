import 'package:testban/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:testban/utils/constants.dart';

class AuthTxnWidgetContent extends StatefulWidget {
  final Function onProcessCallBack;

  AuthTxnWidgetContent({Key key, this.onProcessCallBack}) : super(key: key);

  @override
  _AuthTxnWidgetContentState createState() => _AuthTxnWidgetContentState();
}

class _AuthTxnWidgetContentState extends State<AuthTxnWidgetContent> {
  bool _isLoading = false;
  TextEditingController _passCodeController =
      TextEditingController(text: AgentPassword);
  AuthService _authService = AuthService();
  String _msg;

  void _authorizeTxn(String password) async {
    setState(() {
      _isLoading = true;
      _msg = "Authorizing Transaction";
    });

    await _authService.authTxn(password).then((txnAuthStatus) {
      print(' authtxn response $txnAuthStatus');
      if (txnAuthStatus) {
        print("Process Txn");
        _msg = "Transaction Authorized";
        widget.onProcessCallBack();

        Navigator.of(context).pop();
      } else {
        _msg = "Error authorizing transaction";
      }
    }).catchError((e) {
      print(' authtxn response error ${e.toString()}');
      setState(() {
        _isLoading = false;
        _msg = "error connecting to server";
      });
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
        _msg = _msg;
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    bool isObsecure = true;
    return AlertDialog(
      title: Text(
        'Enter Password To Proceed.',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            (_isLoading)
                ? Container(
                    margin: EdgeInsets.all(4),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : TextField(
                    controller: _passCodeController,
                    obscureText: isObsecure,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(

                        suffix: IconButton(
                          iconSize: 18.0,
                          onPressed: () {
                            setState(() {
                              isObsecure = !isObsecure;
                            });
                          },
                          icon: Icon(!isObsecure
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye_sharp),
                        ),
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                    keyboardType: TextInputType.text,
                  ),
            Text(
              _msg ?? "",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Proceed'),
          onPressed: _isLoading
              ? null
              : () {
                  String _passCode = _passCodeController.text;

                  _authorizeTxn(_passCode);
                },
        ),
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    ;
  }
}

Future<void> authorizeTxnDialog(
    BuildContext context, Function processTxnCallBack) async {
  // bool _isLoading = true;
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AuthTxnWidgetContent(onProcessCallBack: () {
        processTxnCallBack();
      });
    },
  );
}
