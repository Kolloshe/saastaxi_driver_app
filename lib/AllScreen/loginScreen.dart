import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:saasdriver/AllScreen/otpScreen.dart';
import 'package:saasdriver/AllWidgets/progressDialog.dart';
import 'package:saasdriver/configMap.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../main.dart';
import 'mainscreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/mainblurred.jpg"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Image(
                  image: AssetImage('images/logo.png'),
                  width: 100.0,
                  height: 100.0,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Saas Taxi",
                  style: TextStyle(
                      fontFamily: "segoebold", fontSize: 28, color: primary),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: primary,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                  color: primary, style: BorderStyle.solid)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: primary)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: primary)),
                          labelText: AppLocalizations.of(context).email,
                          labelStyle: TextStyle(
                              fontSize: 14.0,
                              color: backgroundcolor,
                              fontFamily: "segoe"),
                          hintStyle: TextStyle(
                              color: backgroundcolor,
                              fontSize: 18.0,
                              fontFamily: "segoe"),
                        ),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: backgroundcolor,
                          fontFamily: "segoe",
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      TextFormField(
                        controller: passwordTextEditingController,
                        obscureText: true,
                        cursorColor: primary,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                  color: primary, style: BorderStyle.solid)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: primary)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: primary)),
                          labelStyle:
                              TextStyle(fontSize: 14.0, color: backgroundcolor),
                          labelText: AppLocalizations.of(context).password,
                          hintStyle: TextStyle(
                              color: backgroundcolor,
                              fontSize: 18.0,
                              fontFamily: "segoe"),
                        ),
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: "segoe",
                            color: backgroundcolor),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 60.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0))),
                        child: Container(
                          height: 50.0,
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
                          if (!emailTextEditingController.text.contains("@")) {
                            displaytostMessage(
                                "Email address is not Valid", context);
                          } else if (passwordTextEditingController
                              .text.isEmpty) {
                            displaytostMessage("Enter Password", context);
                          } else {
                            loginAuthenticatUser(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context).donothaveanaccount,
                        style: TextStyle(
                            color: backgroundcolor, fontFamily: "segoe")),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, Otpscreen.idScreen, (route) => false);
                        },
                        child: Text(
                          AppLocalizations.of(context).registerhere,
                          style: TextStyle(
                              color: primary, fontFamily: "segoebold"),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAuthenticatUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Please wait");
        });

    final User firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((erMsg) {
      Navigator.pop(context);
      displaytostMessage(erMsg.noSuchMethod().toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      driverRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          currentfirebaseUser = firebaseUser;
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.idScreen, (route) => false);
          displaytostMessage("You are Logged-in now ", context);
        } else {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displaytostMessage(
              "User Dose not exists. Please create an Account", context);
        }
      });
    } else {
      Navigator.pop(context);
      displaytostMessage("Error Occured can not SignIn", context);
    }
  }

  displaytostMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
