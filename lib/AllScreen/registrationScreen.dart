import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:saasdriver/AllWidgets/progressDialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saasdriver/DataHandler/appData.dart';
import '../configMap.dart';
import '../main.dart';
import 'carInfoScreen.dart';
import 'loginScreen.dart';

class RegisterationScreen extends StatelessWidget {
  static const String idScreen = "register";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
   TextEditingController confirmpasswordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    phoneTextEditingController.text =
        Provider.of<AppData>(context, listen: false).phone.toString();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/mainblurred.jpg"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40.0,
                ),
                Image(
                  image: AssetImage('images/logo.png'),
                  width: 100.0,
                  height: 100.0,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 1.0,
                ),
                Text(
                  "Saas Taxi",
                  style: TextStyle(
                      fontFamily: "segoebold", fontSize: 28, color: primary),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 14.0,
                      ),
                      TextFormField(
                        controller: nameTextEditingController,
                        keyboardType: TextInputType.text,
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
                          labelText: AppLocalizations.of(context).name,
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
                            fontFamily: "segoe"),
                      ),
                      SizedBox(
                        height: 14.0,
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
                            fontFamily: "segoe"),
                      ),
                      SizedBox(
                        height: 14.0,
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: phoneTextEditingController,
                        keyboardType: TextInputType.phone,
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
                          labelText: AppLocalizations.of(context).phonenumber,
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
                            fontFamily: "segoe"),
                      ),
                      SizedBox(
                        height: 14.0,
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
                          labelText: AppLocalizations.of(context).password,
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
                            fontFamily: "segoe"),
                      ),
                       SizedBox(
                        height: 14.0,
                      ),
                      TextFormField(
                        controller: confirmpasswordTextEditingController,
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
                          labelText: AppLocalizations.of(context).confirmpassword,
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
                            fontFamily: "segoe"),
                      ),
                      SizedBox(
                        height: 36.0,
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
                              AppLocalizations.of(context).createaccount,
                              style: TextStyle(
                                  fontFamily: "segoebold",
                                  fontSize: 18.0,
                                  color: textcolor),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (nameTextEditingController.text.length < 3) {
                            displaytostMessage(
                                "name must be atleast 3 Character", context);
                          } else if (!emailTextEditingController.text
                              .contains("@")) {
                            displaytostMessage(
                                "Email address is not Valid", context);
                          } else if (phoneTextEditingController.text.isEmpty) {
                            displaytostMessage(
                                "Phone Number is not Valid", context);
                          } else if (passwordTextEditingController.text.length <
                              6) {
                            displaytostMessage(
                                "Password must be atleast 6 Character",
                                context);
                          }
                          else if (passwordTextEditingController.text != confirmpasswordTextEditingController.text) {
                            displaytostMessage(
                                "Password must be match",
                                context);
                          } else {
                            registerNewUser(context);
                          }
                        },
                      ),
                      SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context).allready,
                      style: TextStyle(
                          fontFamily: "segoe", color: backgroundcolor),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.idScreen, (route) => false);
                        },
                        child: Text(
                          AppLocalizations.of(context).login,
                          style: TextStyle(
                              fontFamily: "segoebold", color: primary),
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
  registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Please wait");
        });

    final User firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((erMsg) {
      Navigator.pop(context);
      displaytostMessage("Something went wrong please try again" , context);
    }))
        .user;
    if (firebaseUser != null) //user created
    {
      // save into database

      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text,
        "balc": 0
      };
      driverRef.child(firebaseUser.uid).set(userDataMap);

      currentfirebaseUser = firebaseUser;

      displaytostMessage(
          "Cogratulation, your account has been created", context);

      Navigator.pushNamed(context, CarInfoScreen.idScreen);
    } else {
      Navigator.pop(context);
      //error occurd display msg
      displaytostMessage("User has not been Created ", context);
    }
  }
}

displaytostMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
