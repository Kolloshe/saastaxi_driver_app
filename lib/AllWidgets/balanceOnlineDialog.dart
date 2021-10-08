import 'package:flutter/material.dart';

import '../configMap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Balcdialog extends StatelessWidget {
  const Balcdialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: bordercolor,
      elevation: 0.3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        margin: EdgeInsets.all(5.0),
        height: 280,
        decoration: BoxDecoration(
          color: bordercolor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          children: [
            Image.asset(
              "images/saascoint.png",
              width: 100.0,
              height: 100.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
               AppLocalizations.of(context).enoughsaascoin,
              style: TextStyle(
                fontFamily: "segoebold",
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: textcolor,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
               AppLocalizations.of(context).rechargeyouraccount,
              style: TextStyle(
                fontFamily: "segoe",
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context).back,
                style: TextStyle(
                  fontFamily: "segoebold",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: textcolor,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
