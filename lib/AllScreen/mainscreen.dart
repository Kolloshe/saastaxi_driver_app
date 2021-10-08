import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saasdriver/Models/drivers.dart';
import 'package:saasdriver/configMap.dart';
import 'package:saasdriver/tabsPages/homeTabPage.dart';
import '../main.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int selectedIndex = 0;

  void onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController.index = selectedIndex;
      tabController.animateTo(index,
          duration: Duration(milliseconds: 30), curve: Curves.easeInCirc);
    });
  }

  getgooglemapkey() {
    configref.once().then((DataSnapshot snap) {
      if (snap != null) {
        String key = snap.value["mapkey"];
        if (key != null) {
          mapKey = key;
        }
      } else {
        mapKey = mapKey;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  Drivers drivers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeTabPage(),
    );
  }
}
