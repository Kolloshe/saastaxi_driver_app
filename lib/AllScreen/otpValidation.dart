import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasdriver/AllScreen/loginScreen.dart';
import 'package:saasdriver/AllScreen/otpScreen.dart';
import 'package:saasdriver/AllScreen/registrationScreen.dart';
import 'package:saasdriver/AllWidgets/progressDialog.dart';
import 'package:saasdriver/Assistants/assistantMethod.dart';
import 'package:saasdriver/DataHandler/appData.dart';
import 'package:saasdriver/configMap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpValidation extends StatefulWidget {
  static const String idScreen = "otpvali";
  const OtpValidation({Key key}) : super(key: key);

  @override
  _OtpValidationState createState() => _OtpValidationState();
}

class _OtpValidationState extends State<OtpValidation> {
  Otpscreen otpscreen;
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  TextEditingController fi1 = TextEditingController();
  TextEditingController fi2 = TextEditingController();
  TextEditingController fi3 = TextEditingController();
  TextEditingController fi4 = TextEditingController();
  int userInput = 0;
  int otpFromFun = 0;
  int time = 120;
  int m = 1;
  int s = 60;
  int userphone = 0;

  void rsetTimer() {
    time = 120;
    m = 1;
    s = 60;
    timeer();
  }

  void timeer() async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (time > 0) {
        time = time - 1;

        s = s - 1;

        if (time == 60) {
           setState(() { s = 60;

          m = m - 1;});
        }
      
      } else {
        timer.cancel();
        displaytostMessage("will resend the code", context);
        isNumberExist();
        print(userphone);
        print(ran);
        rsetTimer();
        // AssistantMethods.otpmesseage(
        //     userphone, "SAASTAXI Verification Code : ${ran}", context);

      }
    });
  }

  void initState() {
    super.initState();
    userphone = Provider.of<AppData>(context, listen: false).phone;
    otpFromFun = Provider.of<AppData>(context, listen: false).randomNumber;
    timeer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/mainblurred.jpg"), fit: BoxFit.cover),
        ),
        padding: EdgeInsets.all(18.0),

        // color: bordercolor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Center(
            //   child: Image.asset(""),
            // ),

            Image.asset('images/otpv.png'),
            SizedBox(
              height: 10,
            ),
            Text(
               AppLocalizations.of(context).verificationcode,
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
               AppLocalizations.of(context).typeverification,
              style: TextStyle(
                fontFamily: "segoe",
                fontSize: 16,
                color: Colors.grey,
                inherit: false,
              ),
            ),

            Text(
              " to : $userphone",
              style: TextStyle(
                  fontFamily: "segoe",
                  fontSize: 16,
                  letterSpacing: 1.3,
                  color: bordercolor),
            ),
            SizedBox(
              height: 20,
            ),
            //timmer
            Text(
              " 0$m : $s",
              style: TextStyle(
                color: bordercolor,
                fontFamily: "segoe",
                fontSize: 18,
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    color: bordercolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 21.0),
                      child: Center(
                        child: TextFormField(
                          controller: fi1,
                          focusNode: f1,
                          onChanged: (String newVal) {
                            if (newVal.length == 1) {
                              f1.nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Card(
                    color: bordercolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 21.0),
                      child: TextFormField(
                        controller: fi2,
                        focusNode: f2,
                        onChanged: (String newVal) {
                          if (newVal.length == 1) {
                            f2.nextFocus();
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 24),
                      ),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Card(
                    color: bordercolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 21.0),
                      child: TextFormField(
                        controller: fi3,
                        focusNode: f3,
                        onChanged: (String newVal) {
                          if (newVal.length == 1) {
                            f3.nextFocus();
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 24),
                      ),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Card(
                    color: bordercolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 21.0),
                      child: TextFormField(
                        controller: fi4,
                        focusNode: f4,
                        onChanged: (String newVal) async {
                          if (newVal.length == 1 &&
                              fi1 != null &&
                              fi2 != null &&
                              fi3 != null &&
                              fi4 != null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => ProgressDialog(
                                message: "verification ...",
                              ),
                            );
                            f4.unfocus();

                            userInput = int.parse(
                                fi1.text + fi2.text + fi3.text + fi4.text);
                            print(userInput);
                            print(otpFromFun);
                            vaildationOtp(userInput, otpFromFun, context);
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 24),
                      ),
                      width: 60,
                      height: 60,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0))),
              onPressed: () {
                if (fi1 != null && fi2 != null && fi3 != null && fi4 != null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => ProgressDialog(
                      message: "verification ...",
                    ),
                  );
                  f4.unfocus();

                  userInput =
                      int.parse(fi1.text + fi2.text + fi3.text + fi4.text);
                  vaildationOtp(userInput, otpFromFun, context);
                }
              },
              child: Text(
                AppLocalizations.of(context).confirm,
                style: TextStyle(
                    fontFamily: "segoebold", fontSize: 18.0, color: textcolor),
              ),
            ),
            TextButton(
              onPressed: () {
                AssistantMethods.otpmesseage(
                    userphone, "SAASTAXI Verification Code : $ran", context);
              },
              child: Text( AppLocalizations.of(context).resend,),
            ),
          ],
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
    Provider.of<AppData>(context, listen: false).getRandomNumber(ran.toInt());
    print(Provider.of<AppData>(context, listen: false).randomNumber);
  }
}

void vaildationOtp(
    int otpFromUser, int otpFromFun, BuildContext context) async {
  if (otpFromFun == otpFromUser) {
    print("done");
    Navigator.pop(context);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(RegisterationScreen.idScreen, (route) => false);
  } else {
    Navigator.pop(context);
    print("faild");
  }
}
