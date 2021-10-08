import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasdriver/AllScreen/registrationScreen.dart';
import 'package:saasdriver/AllWidgets/progressDialog.dart';
import 'package:saasdriver/Assistants/assistantMethod.dart';
import 'package:saasdriver/DataHandler/appData.dart';
import 'package:saasdriver/configMap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'otpValidation.dart';

class Otpscreen extends StatefulWidget {
  static const String idScreen = "otp";



  @override
  _OtpscreenState createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  FocusNode f1 = FocusNode();

  TextEditingController otpTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/mainblurred.jpg"), fit: BoxFit.cover),
          ),
          padding: EdgeInsets.all(18.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // color: bordercolor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(
              //   'Create Account',
              //   style: TextStyle(
              //     fontFamily: 'segoe',
              //     color: Colors.grey,
              //     fontSize: 18,
              //   ),
              // ),
              SizedBox(
                height: 30,
              ),
              Image.asset('images/otp.png'),
              SizedBox(
                height: 15,
              ),
              Text(
                 AppLocalizations.of(context).verifyyournumber,
                style: TextStyle(
                  fontFamily: "segoe",
                  fontSize: 24,
                  color: bordercolor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                 AppLocalizations.of(context).pleaseenteryourmobile,
                style: TextStyle(
                  fontFamily: "segoe",
                  fontSize: 16,
                  color: Colors.grey,
                  inherit: false,
                ),
              ),
              SizedBox(
                height: 20,
              ),

              TextFormField(
                focusNode: f1,
                controller: otpTextEditingController,
                keyboardType: TextInputType.phone,
                cursorColor: primary,
                decoration: InputDecoration(
                  prefixText: "+249 ",
                  prefixStyle: TextStyle(
                    letterSpacing: 2.0,
                    fontFamily: "segoe",
                    color: bordercolor,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: primary, style: BorderStyle.solid)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: primary)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: primary)),
                  labelText:  AppLocalizations.of(context).phonenumber,
                  labelStyle: TextStyle(
                      fontSize: 14.0,
                      color: backgroundcolor,
                      fontFamily: "segoe"),
                  hintText: "9 XXX XXXXX",
                  hintStyle: TextStyle(
                      letterSpacing: 2.0,
                      color: backgroundcolor,
                      fontSize: 14.0,
                      fontFamily: "segoe"),
                ),
                style: TextStyle(
                    fontSize: 14.0,
                    color: backgroundcolor,
                    fontFamily: "segoe",
                    letterSpacing: 2.0),
                maxLength: 9,
                onChanged: (String newVal) {
                  if (newVal.length == 9) {
                    f1.unfocus();
                  }
                },
              ),
              SizedBox(
                height: 40,
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
                      AppLocalizations.of(context).send,
                      style: TextStyle(
                          fontFamily: "segoebold",
                          fontSize: 18.0,
                          color: textcolor),
                    ),
                  ),
                ),
                onPressed: () async {
                  
                  int x = int.parse('249' + otpTextEditingController.text);

                  if (otpTextEditingController.text.length < 9) {
                    displaytostMessage(
                        "Phone number Must Be 9 Digit Number", context);
                  } else if (otpTextEditingController.text.length > 9) {
                    displaytostMessage(
                        "Phone number Must Be 9 Digit Number", context);
                  } else {
                    showDialog(
                    context: context,
                    builder: (BuildContext context) => ProgressDialog(
                      message: "please wait.",
                    ),
                  );
                    Provider.of<AppData>(context, listen: false).getphone(x);
                    isNumberExist();
                    Navigator.pop(context);
                    Navigator.pushNamed(context, OtpValidation.idScreen);
                    await AssistantMethods.otpmesseage(
                        x, "SAASTAXI Verification Code : $ran", context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  int ran = 0;
  void isNumberExist() {
    var rnd = new Random();
    var next = rnd.nextDouble() * 1000;
    while (next < 1000) {
      next *= 10;
    }
    ran = next.toInt();
    Provider.of<AppData>(context, listen: false).getRandomNumber(next.toInt());
    print("+++++++++++++");
    print(Provider.of<AppData>(context, listen: false).randomNumber);
    print("+++++++++++++");
  }
}
