import 'package:flutter/material.dart';
import 'package:saasdriver/AllScreen/otpScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../configMap.dart';
import 'loginScreen.dart';


class WelcomeScreen extends StatelessWidget {
  static const String idScreen = "welcome";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/main.jpg"), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 150.0,
                ),
                Image(
                  image: AssetImage('images/logo.png'),
                  width: 120.0,
                  height: 120.0,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 18.0,
                ),
                Text(
                  "Saas Taxi",
                  style: TextStyle(
                      fontFamily: "segoebold",
                      fontSize: 32,
                      color: bordercolor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 135,
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        side: BorderSide(
                          width: 2,
                          color: primary,
                        )),
                    onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                        context, Otpscreen.idScreen, (route) => false);
                    },
                    child: Container(
                      height: 55,
                      child: Center(
                        child: Text(
                         AppLocalizations.of(context).signup,
                          style: TextStyle(
                              fontFamily: "segoebold",
                              fontSize: 18.0,
                              color: primary),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0))),
                  child: Container(
                    height: 55.0,
                    child: Center(
                      child: Text(
                        
                          AppLocalizations.of(context).login,
                        style: TextStyle(
                            fontFamily: "segoebold",
                            fontSize: 18.0,
                            color: textcolor),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginScreen.idScreen, (route) => false);
                  },
                ),
              ],
            ),
          )),
    );
  }
}
