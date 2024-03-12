import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class TransactionPage extends StatefulWidget {

  TransactionPage();

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {

  List<Transaction> transactions = [
    Transaction(amount: 1000, date: DateTime.now()),
    Transaction(amount: 2000, date: DateTime.now()),
    Transaction(amount: 3000, date: DateTime.now()),
    Transaction(amount: 4000, date: DateTime.now()),
    Transaction(amount: 5000, date: DateTime.now()),
  ];

  @override
  void initState() {
    transactions=List.generate(
      10,
          (index) => Transaction(
        amount: (index + 1) * 100.0,
        date: DateTime.now().subtract(Duration(days: index)),
      ),
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Amount: ${transactions[index].amount}'),
            subtitle: Text('Date: ${transactions[index].date}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _generatePDF(context),
        child: Icon(Icons.picture_as_pdf),
      ),
    );
  }

  Future<void> _generatePDF(BuildContext context) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (pw.Context context, int index) {
              return pw.Container(
                padding: pw.EdgeInsets.all(10),
                child: pw.Text(
                  'Amount: ${transactions[index].amount}, Date: ${transactions[index].date}',
                ),
              );
            },
          );
        },
      ),
    );

    // Save the PDF file
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/transactions.pdf';
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    // Open the PDF file
    //OpenFile.open(path);
  }
}

class Transaction {
  final double amount;
  final DateTime date;

  Transaction({@required this.amount, @required this.date});
}


