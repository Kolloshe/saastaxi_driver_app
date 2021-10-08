import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:saasdriver/DataHandler/appData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../configMap.dart';
import 'mainscreen.dart';

class Setting extends StatefulWidget {
  static const String idScreen = "setting";

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: primary,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 30,
            color: textcolor,
          ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, MainScreen.idScreen, (route) => false);
          },
        ),
        toolbarHeight: 70,
        title: Text(
          AppLocalizations.of(context).settings,
          style: TextStyle(
              color: textcolor, fontFamily: "segoebold", fontSize: 30),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Container(
                width: MediaQuery.of(context).size.width * .95,
                height: MediaQuery.of(context).size.height * .08,
                decoration: BoxDecoration(
                  color: bordercolor,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.0,
                      spreadRadius: 0.9,
                      offset: Offset(0.0, 0.0),
                      color: textcolor.withOpacity(0.25),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context).language,
                        style: TextStyle(
                          color: textcolor,
                          fontFamily: "segoe",
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      CupertinoSwitch(
                        onChanged: (bool value) {
                          value == false
                              ? Provider.of<AppData>(context, listen: false)
                                  .changeLocale(Locale('en'))
                              : Provider.of<AppData>(context, listen: false)
                                  .changeLocale(Locale('ar'));
                          setState(() {});
                          savelung();
                        },
                        value: Provider.of<AppData>(context, listen: false)
                                    .locale ==
                                Locale('en')
                            ? false
                            : true,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



  savelung() async {
    prefs = await SharedPreferences.getInstance();
    if (Provider.of<AppData>(context, listen: false).locale == Locale('en')) {
      prefs.setBool('locale', false);
    } else if(Provider.of<AppData>(context, listen: false).locale == Locale('ar')) {
      prefs.setBool('locale', true);
    }
  }
}
