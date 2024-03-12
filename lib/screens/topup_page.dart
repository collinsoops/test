import 'package:flutter/material.dart';

class AirtimePurchasePage extends StatefulWidget {
  @override
  _AirtimePurchasePageState createState() => _AirtimePurchasePageState();
}

class _AirtimePurchasePageState extends State<AirtimePurchasePage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  // Mock function to simulate airtime purchase
  void _purchaseAirtime() {
    // Perform airtime purchase logic here
    // For demonstration purposes, let's just navigate to the success page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PurchaseSuccessPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase Airtime'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Enter Phone Number',
                border: OutlineInputBorder(),
              ),
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
              onPressed: _purchaseAirtime,
              child: Text('Purchase Airtime'),
            ),
          ],
        ),
      ),
    );
  }
}

class PurchaseSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase Success'),
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
              'Airtime Purchase Successful!',
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
