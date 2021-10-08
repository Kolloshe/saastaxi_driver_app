import 'package:flutter/material.dart';


import '../configMap.dart';
import 'mainscreen.dart';

class AboutScreen extends StatefulWidget {
  static const String idScreen = "about";
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Saas",
          style: TextStyle(
              fontFamily: "segoebold", color: textcolor, fontSize: 28),
        ),
        backgroundColor: primary,
        leading: GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, MainScreen.idScreen, (route) => false);
            },
            child: Icon(
              Icons.keyboard_arrow_left,
              color: textcolor,
              size: 45,
            )),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/mainblurred.jpg"),
                fit: BoxFit.cover)),
        child: ListView(
          children: [
            //car Icon
            SizedBox(
              height: 25,
            ),
            Container(
              // height: 220,
              child: Center(
                child: Image.asset(
                  'images/logo.png',
                  height: 180,
                  width: 180,
                ),
              ),
            ),

            //app name +info

            Padding(
              padding: EdgeInsets.only(top: 0, left: 24, right: 24),
              child: Column(
                children: [
                  Text(
                    "SaasTaxi",
                    style: TextStyle(
                        fontSize: 40, fontFamily: 'segoe', color: primary),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'This App has been Developed by MinaSave international Company.'
                    ' This App offer cheap ride at cheap rates,',
                    style: TextStyle(
                        fontFamily: 'segoebold',
                        color: bordercolor,
                        letterSpacing: 1.2),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),

            SizedBox(
              height: 40,
            ),
            //Go Back button

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, MainScreen.idScreen, (route) => false);
                },
                child: const Text(
                  "Go Back",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "segoebold"),
                ),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: backgroundcolor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
