import 'package:flutter/material.dart';

class WithdrawalPage extends StatefulWidget {
  @override
  _WithdrawalPageState createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  String selectedAccount = 'Savings'; // Default account
  TextEditingController amountController = TextEditingController();

  // Mock function to simulate withdrawing funds
  void _withdrawFunds() {
    // Perform withdrawal logic here
    // For demonstration purposes, let's just navigate to the success page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WithdrawalSuccessPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Withdraw Funds'),
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
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _withdrawFunds,
              child: Text('Withdraw'),
            ),
          ],
        ),
      ),
    );
  }
}

class WithdrawalSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Withdrawal Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Withdrawal Successful!',
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
