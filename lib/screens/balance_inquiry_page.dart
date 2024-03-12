import 'package:flutter/material.dart';

class BalanceInquiryPage extends StatefulWidget {
  @override
  _BalanceInquiryPageState createState() => _BalanceInquiryPageState();
}

class _BalanceInquiryPageState extends State<BalanceInquiryPage> {
  String selectedAccount = 'Savings'; // Default account
  double savingsBalance = 5000.0; // Example balance, replace with actual balance
  double checkingBalance = 3000.0; // Example balance, replace with actual balance
  double investmentBalance = 10000.0; // Example balance, replace with actual balance

  double getBalance(String account) {
    switch (account) {
      case 'Savings':
        return savingsBalance;
      case 'Checking':
        return checkingBalance;
      case 'Investment':
        return investmentBalance;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance Inquiry'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedAccount,
              onChanged: (String newValue) {
                setState(() {
                  selectedAccount = newValue;
                });
              },
              items: <String>['Savings', 'Checking', 'Investment']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Current Balance: KES\ ${getBalance(selectedAccount).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
