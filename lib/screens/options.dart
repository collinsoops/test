import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testban/utils/constants.dart';

class MyOption extends StatefulWidget {
  @override
  MyOptionState createState() => MyOptionState();
}

class MyOptionState extends State<MyOption> {


  String _mySelection;

  final String url = "$API_BASE_URL/searchoptions.php";

  List data = List(); //edited line

  Future<String> getSWData() async {
    //    var res = await http.post(dataurl);
    var res = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      data = resBody["data"];
    });

    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
    border: Border.all(width: 1, color: Colors.grey),
    borderRadius: BorderRadius.circular(10)),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
    Expanded(
    child: DropdownButtonHideUnderline(
    child: ButtonTheme(
    alignedDropdown: true,

    child: new DropdownButton(
          items: data.map((item) {
            return new DropdownMenuItem(
              child: new Text(item['name']),
              value: item['name'],
            );
          }).toList(),
      isDense: true,
      hint: new Text("Select Option"),
          onChanged: (newVal) {
            setState(() {
              _mySelection = newVal;
              print("selected is $_mySelection");
            });
          },
          value: _mySelection,

        ),
      )
    )
    )
    ]
    ));
  }




  /*
  String _selected;
  var data;
  var error;
  var message;
  List<Map<dynamic, dynamic>> myJson;

  String dataurl = "$API_BASE_URL/searchoptions.php";
  Future<void> getCity() async {
    var res = await http.post(dataurl);
    Map data1 = {
      'id': '1',
      'name': 'password'
    };
    print(data1);
    print(jsonEncode(data1));
    *//*var source=jsonEncode(data);
print (jsonDecode(source));*//*

    if (res.statusCode == 200) {
      setState(() {
        data = json.decode(res.body);
         myJson = data["data"];
        print ("my json is $data");
        print ("my json is $myJson");

        if (data["error"]) {
          error = true;
          message = data["errmsg"];
        }
      });
    } else {
      setState(() {
        error = true;
        message = "Error during fetching data";
      });
    }
  }

  @override
  void initState() {
    this.getCity();
 *//*   setState(() {
      myJson = data["data"];
      print("my json is $myJson");
    });*//*
    super.initState();
  }

  List<Map> mJson= [
    {"id":"1","name":"National ID","description":"National ID"},
    {"id":"2","name":"Service No","description":"Service No"},
    {"id":"3","name":"Member No","description":"Member No"}];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,

                child: DropdownButton<String>(
                  isDense: true,
                  hint: new Text("Select Option"),
                  value: _selected,
                  onChanged: (String newValue) {
                    setState(() {
                      _selected = newValue;
                    });

                    print(_selected);
                  },
                  items: myJson.map((Map map) {
                    return new DropdownMenuItem<String>(
                      value: map["id"].toString(),
                      // value: _mySelection,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.album_outlined),
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(map["name"])),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }*/
}
