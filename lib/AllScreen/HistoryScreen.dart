import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasdriver/AllWidgets/HistoryItem.dart';
import 'package:saasdriver/DataHandler/appData.dart';
import 'package:saasdriver/Models/history.dart';
import 'package:saasdriver/tabsPages/homeTabPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../configMap.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<History> historylist = [];

  @override
  Widget build(BuildContext context) {
    historylist.addAll(
        Provider.of<AppData>(context, listen: false).tripHistoryDataList);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).history,
          style: TextStyle(
              fontFamily: "segoebold", color: textcolor, fontSize: 28),
        ),
        backgroundColor: primary,
        leading: GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeTabPage.idScreen, (route) => false);
              dele();
            },
            child: Icon(
              Icons.keyboard_arrow_left,
              color: textcolor,
              size: 45,
            )),
      ),
      body: ListView.builder(
        itemCount: Provider.of<AppData>(context, listen: false)
                .tripHistoryDataList
                .isNotEmpty
            ? Provider.of<AppData>(context, listen: false)
                .tripHistoryDataList
                .length
            : 0,
        padding: EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return HistoryItem(
            history: historylist[index],
          );
        },
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }

  dele() {
    historylist.clear();
  }
}
