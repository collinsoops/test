import 'package:flutter/material.dart';
import 'package:testban/screens/widgets/card.dart';
import 'package:testban/screens/widgets/clipper.dart';
import 'package:testban/screens/widgets/ticketwidget.dart';


class MyTicketView extends StatelessWidget {
  const MyTicketView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Receipt"),),
     // backgroundColor: Theme.of(context).primaryColorLight,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(50),
            child: TicketWidget(
              height: 500,
                width: 400,
                margin: EdgeInsets.all(8),
                child: TicketData()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WidgetCard(key: UniqueKey(),Title: "Get Receipt",strImage: "assets/icon/print.png", onpressed: null,),
              WidgetCard(key: UniqueKey(),Title: "Home",strImage: "assets/icon/home--v2.png", onpressed: null,),
            ],
          )

        ],
      ),
    );
  }
}

class TicketData extends StatelessWidget {
  const TicketData({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
          child: Container(
            width: 120.0,
            height: 120.0,
            padding: EdgeInsets.only(bottom: 12),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/icon/icon.png'),
                    fit: BoxFit.cover)),
          ),
        ),

        Center(
          child: const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'Transaction  Receipt',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ticketDetailsWidget(
                  'Passengers', 'Hafiz M Mujahid', 'Date', '28-08-2022'),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 52.0),
                child: ticketDetailsWidget('Flight', '76836A45', 'Gate', '66B'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 53.0),
                child: ticketDetailsWidget('Class', 'Business', 'Seat', '21B'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
          child: Container(
            width: 250.0,
            height: 60.0,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/barcode.png'),
                    fit: BoxFit.cover)),
          ),
        ),
        const Center(
          child: Text(
            '0000 +254 723 631 593',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(child: const Text('Thank You For Banking With Us!'))
      ],
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                firstDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              secondTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                secondDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    ],
  );
}
