
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../configMap.dart';

class RatingTabPage extends StatefulWidget {
  @override
  _RatingTabPageState createState() => _RatingTabPageState();
}

class _RatingTabPageState extends State<RatingTabPage> {
  String name;

  @override
  Widget build(BuildContext context) {
    if (driversInformations.name != null) {
      name = driversInformations.name;
    } else {
      name = "";
    }
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/mainblurred.jpg"),
                fit: BoxFit.cover)),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: bordercolor),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //       children: [
                SizedBox(
                  height: 22.0,
                ),
                Text(
                  name,
                  style: TextStyle(color: textcolor, fontFamily: "segoebold"),
                ),
                Text(
                   AppLocalizations.of(context).yourratings,
                  style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: "segeo",
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 22.0,
                ),
                Divider(
                  height: 2.0,
                  thickness: 2.0,
                  endIndent: 20,
                  indent: 20,
                 
                ),
                SizedBox(
                  height: 16.0,
                ),
                SmoothStarRating(
                  rating: starCounter,
                  borderColor: textcolor,
                  color:primary,
                  allowHalfRating: true,
                  starCount: 5,
                  size: 45,
                  isReadOnly: true,
                ),
                SizedBox(
                  height: 14.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: "segoebold",
                      color: textcolor),
                ),
                SizedBox(
                  height: 16.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
