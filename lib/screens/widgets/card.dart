import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetCard extends StatelessWidget {
  final String strImage;
  final String Title;
  final Function onpressed;

  const WidgetCard({Key key, this.strImage, this.Title, this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      elevation: 1.0,
      highlightElevation: 1.0,
      padding: EdgeInsets.all(1),
      onPressed: () {
        this.onpressed;
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          width: 4,
          color: Theme.of(context).backgroundColor,
        ),
      ),
      textColor: Colors.black,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            Image.asset(
              strImage,
              width: 50,
              height: 50,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 12.0),
            AutoSizeText(
              Title,
              minFontSize: 10.0,
              textAlign: TextAlign.center,
              maxLines: 3,
              wrapWords: false,
            ),
            SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    );
  }
}
