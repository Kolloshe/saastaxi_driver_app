import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:provider/provider.dart';
import 'package:saasdriver/AllScreen/AboutScreen.dart';
import 'package:saasdriver/AllScreen/HistoryScreen.dart';
import 'package:saasdriver/AllScreen/SettingScreen.dart';
import 'package:saasdriver/AllScreen/loginScreen.dart';
import 'package:saasdriver/AllScreen/registrationScreen.dart';
import 'package:saasdriver/AllWidgets/balanceOnlineDialog.dart';
import 'package:saasdriver/Assistants/assistantMethod.dart';
import 'package:saasdriver/DataHandler/appData.dart';
import 'package:saasdriver/Models/drivers.dart';
import 'package:saasdriver/Notifcations/pushNotificationService.dart';
import 'package:saasdriver/tabsPages/profileTapPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../configMap.dart';
import '../main.dart';
import 'earningsTabPage.dart';

class HomeTabPage extends StatefulWidget {
  static const String idScreen = "home";

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(15.8628, 30.2176),
    zoom: 9.4746,
  );

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController newGoogleMapController;

  var geolocator = Geolocator();

  String driverStatusText;

  Color driverStatusColor;
  bool drawerOpen = true;

  Drivers drivers = driversInformations;

  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0.2, 0.2)), "images/marker1.png");
  }

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // String dname = "";
  // String dphone = "";
  void get_config() {
    configref.once().then((DataSnapshot snap) {
      if (snap != null) {
        double commission = double.parse(snap.value["commission"]);
        double killometer = double.parse(snap.value["killometer"]);
        Provider.of<AppData>(context, listen: false)
            .get_config(commission, killometer);
        commi = Provider.of<AppData>(context, listen: false).commission;
        killo = Provider.of<AppData>(context, listen: false).killometer;

        print(commission);
        print(killometer);
      } else {
        print("++++++++++++++++++++++++++++++++++++++++++++++++++");
      }
    });
  }

  static getlocale(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    bool local = prefs.getBool('locale');
    if (local != null) {
      if (local) {
        Provider.of<AppData>(context, listen: false).changeLocale(Locale('ar'));
      } else {
        Provider.of<AppData>(context, listen: false).changeLocale(Locale('en'));
      }
    }
  }

  void initState() {
    super.initState();
    get_config();
    locaterPosition();
    getCurrentDriverInfo();
    getlocale(context);
    chackDriverState();
    AssistantMethods.loadimage();
    setCustomMarker();
  }

  void chackDriverState() {
    if (isDriverAvailable == true) {
      driverStatusColor = Color(0xff01e554);
      driverStatusText = "Online";
    } else {
      driverStatusColor = Color(0xfffe5d33);
      driverStatusText = "Offline - GO online";
    }
  }

  savetopref(double lat, double long) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble('lat', lat);
    prefs.setDouble('long', long);
  }

  void locaterPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currentPosition = position;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savetopref(position.latitude, position.longitude);

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));




/////////Marker

setState(() {
   _markers.add(
      Marker(
        markerId: MarkerId('id-1'),
        position: LatLng(currentPosition.latitude, currentPosition.longitude),
        icon: mapMarker,
      ),
    );
});

   
    try {
      if (driversInformations != null) {
        Provider.of<AppData>(context, listen: false).user = driversInformations;
      }
      chackDriverState();
    } catch (e) {
      print(e.toString());
    }
    prefs = await SharedPreferences.getInstance();
    String photo = prefs.getString("photo");
    if (photo != null) {
      images = photo;
    } else {
      images = driversInformations.image;
    }
  }

  void getCurrentDriverInfo() async {
    currentfirebaseUser = FirebaseAuth.instance.currentUser;

    driverRef
        .child(currentfirebaseUser.uid)
        .once()
        .then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value['balc'].toString());
    });

    driverRef
        .child(currentfirebaseUser.uid)
        .once()
        .then((DataSnapshot dataSnapshot) async {
      if (dataSnapshot.value != null) {
        driversInformations = Drivers.fromSnapshot(dataSnapshot);
        print("++++++++");
        print(driversInformations.balc);
        Provider.of<AppData>(context, listen: false)
            .getbalc(driversInformations.balc);
        Provider.of<AppData>(context, listen: false)
            .updateProfile(driversInformations);
      } else {
        Provider.of<AppData>(context, listen: false).getbalc(0);
      }
    });

    PushNotificationService pushNotificationService = PushNotificationService();
    pushNotificationService.getToken();
    pushNotificationService.initialize(context);

    AssistantMethods.retrieveHistoryInfo(context);
    getRatings();
  }

  getRatings() {
    //update Rating
    driverRef
        .child(currentfirebaseUser.uid)
        .child("ratings")
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        double ratings = double.parse(dataSnapshot.value.toString());
        setState(() {
          starCounter = ratings;
        });
        if (starCounter <= 1.5) {
          setState(() {
            title = "Very Bad";
          });

          return;
        } else if (starCounter <= 2.5) {
          setState(() {
            title = "Bad";
          });

          return;
        } else if (starCounter <= 3.5) {
          setState(() {
            title = "Good";
          });

          return;
        } else if (starCounter <= 4.5) {
          setState(() {
            title = "Very Good";
          });

          return;
        } else if (starCounter <= 5) {
          setState(() {
            title = "Excellent";
          });

          return;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            if (drawerOpen) {
              scaffoldKey.currentState.openDrawer();
            } else {}
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 14, right: 8),
            child: FaIcon(
              ((drawerOpen) ? FontAwesomeIcons.bars : Icons.close),
              color: textcolor,
              size: 26,
            ),
          ),
        ),
      ),
      key: scaffoldKey,
      drawer: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          color: backgroundcolor,
        ),
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              //Drawer Header
              Container(
                color: textcolor,
                height: 190.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: textcolor,
                    // borderRadius: BorderRadius.only()
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: images != null
                            ? Image.memory(
                                base64Decode(images),
                                fit: BoxFit.cover,
                                height: 95,
                                width: 95,
                                alignment: Alignment.center,
                              )
                            : Image.asset(
                                "images/user_icon.png",
                                height: 95,
                                width: 95,
                              ),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        Provider.of<AppData>(context, listen: false).user !=
                                null
                            ? Provider.of<AppData>(context, listen: false)
                                .user
                                .name
                            : "",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: "segoebold",
                            color: bordercolor),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(
                          Provider.of<AppData>(context, listen: false).user !=
                                  null
                              ? Provider.of<AppData>(context, listen: false)
                                  .user
                                  .phone
                              : "",
                          style: TextStyle(
                              fontFamily: "segoebold", color: bordercolor))
                    ],
                  ),
                ),
              ),
              // DividerWidget(),

              SizedBox(
                height: 12.0,
              ),

              //Drawer Body
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EarningTabPage()));
                },
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.carCrash, color: textcolor),
                  title: Text(
                    AppLocalizations.of(context).earnigs,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "segoebold",
                        color: textcolor),
                  ),
                ),
              ),
              Divider(
                thickness: 0.50,
                color: textcolor.withOpacity(0.25),
                endIndent: 20,
                indent: 20,
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.user, color: textcolor),
                title: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileTabPage()));
                  },
                  child: Text(
                    AppLocalizations.of(context).profile,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "segoebold",
                        color: textcolor),
                  ),
                ),
              ),
              Divider(
                thickness: 0.50,
                color: textcolor.withOpacity(0.25),
                endIndent: 20,
                indent: 20,
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.history, color: textcolor),
                title: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoryScreen()));
                  },
                  child: Text(
                    AppLocalizations.of(context).history,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "segoebold",
                        color: textcolor),
                  ),
                ),
              ),
              Divider(
                thickness: 0.50,
                color: textcolor.withOpacity(0.25),
                endIndent: 20,
                indent: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutScreen()));
                },
                child: ListTile(
                  leading:
                      FaIcon(FontAwesomeIcons.infoCircle, color: textcolor),
                  title: Text(
                    AppLocalizations.of(context).about,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "segoebold",
                        color: textcolor),
                  ),
                ),
              ),
              Divider(
                thickness: 0.50,
                color: textcolor.withOpacity(0.25),
                endIndent: 20,
                indent: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Setting()));
                },
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.cogs, color: textcolor),
                  title: Text(
                    AppLocalizations.of(context).settings,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "segoebold",
                        color: textcolor),
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Divider(
                thickness: 2.0,
                color: textcolor,
                endIndent: 20,
                indent: 20,
              ),

              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.idScreen, (route) => false);
                },
                child: ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.signOutAlt,
                    color: Color(0xfffe5d33),
                  ),
                  title: Text(
                    AppLocalizations.of(context).logout,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "segoebold",
                        color: Color(0xfffe5d33)),
                  ),
                ),
              ),
              ListTile(
                dense: true,
                trailing: CupertinoSwitch(
                  onChanged: (bool value) {
                    value == false
                        ? Provider.of<AppData>(context, listen: false)
                            .changeLocale(Locale('en'))
                        : Provider.of<AppData>(context, listen: false)
                            .changeLocale(Locale('ar'));
                    setState(() {});
                  },
                  value: Provider.of<AppData>(context, listen: false).locale ==
                          Locale('en')
                      ? false
                      : true,
                ),
                leading: Icon(Icons.language_sharp),
                // title: Text(AppLocalizations.of(context).langa),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              markers: _markers,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: HomeTabPage._kGooglePlex,
              myLocationEnabled: true,
              compassEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;

                locaterPosition();
              },
            ),
            Positioned(
                bottom: 10.0,
                left: 12.0,
                right: 12.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: textcolor.withOpacity(0.1),
                  ),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                )),
            //ONLINE OFFLINE CONTANER
            Positioned(
              bottom: 10.0,
              left: 12.0,
              right: 12.0,
              // child: Container(
              //   width: double.infinity,
              //   height: 200,
              //   decoration: BoxDecoration(
              //       color: backgroundcolor,
              //       borderRadius: BorderRadius.circular(18)),
              // )),
              child: GlassContainer.frostedGlass(
                height: 80,
                width: MediaQuery.of(context).size.width,
                gradient: LinearGradient(
                  colors: [
                    textcolor.withOpacity(0.090),
                    textcolor.withOpacity(0.010)
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                borderRadius: BorderRadius.circular(18),
                blur: 5.0,
              ),
            ),

            Positioned(
              bottom: 23.0,
              left: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlowButton(
                    onPressed: () {
                      if (Provider.of<AppData>(context, listen: false).balc >=
                          commi) {
                        if (isDriverAvailable != true) {
                          makeDriverOnlineNow();
                          getLocationLiveUpdates();
                          setState(() {
                            driverStatusColor = Color(0xff01e554);
                            driverStatusText =
                                AppLocalizations.of(context).online;
                            isDriverAvailable = true;
                          });
                          displaytostMessage("you are Online Now", context);
                        } else {
                          makeDriverOfflineNow();
                          setState(() {
                            driverStatusColor = Color(0xfffe5d33);
                            driverStatusText =
                                AppLocalizations.of(context).offline;
                            isDriverAvailable = false;
                          });

                          displaytostMessage("you are Offline", context);
                        }
                      } else {
                        makeDriverOfflineNow();
                        setState(() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => Balcdialog());
                        });
                        driverStatusColor = Color(0xfffe5d33);
                        driverStatusText = AppLocalizations.of(context).offline;
                        isDriverAvailable = false;
                        displaytostMessage("balance is less than ", context);
                      }
                    },
                    color: driverStatusColor,
                    child: Text(
                      driverStatusText,
                      style: TextStyle(
                          fontFamily: "segoebold",
                          color: Colors.white,
                          fontSize: 14),
                    ),
                    borderRadius: BorderRadius.circular(25),
                    width: 200,
                    height: 50,
                    blurRadius: 25,
                  ),

                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       if (isDriverAvailable != true) {
                  //         makeDriverOnlineNow();
                  //         getLocationLiveUpdates();
                  //         setState(() {
                  //           driverStatusColor = Color(0xff01e554);
                  //           driverStatusText = "Online Now";
                  //           isDriverAvailable = true;
                  //         });
                  //         displaytostMessage("you are Online Now", context);
                  //       } else {
                  //         makeDriverOfflineNow();
                  //         setState(() {
                  //           driverStatusColor = Color(0xfffe5d33);
                  //           driverStatusText = "Offline Now - Go Online";
                  //           isDriverAvailable = false;
                  //         });

                  //         displaytostMessage("you are Offline", context);
                  //       }
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //         primary: driverStatusColor,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(24.0))),
                  //     child: Padding(
                  //       padding: EdgeInsets.all(15.0),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             driverStatusText,
                  //             style: TextStyle(
                  //                 fontSize: 16.0,
                  //                 color: textcolor,
                  //                 fontFamily: "segoebold"),
                  //           ),
                  //           Icon(
                  //             Icons.phone_android,
                  //             color: Colors.white,
                  //             size: 26.0,
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void makeDriverOnlineNow() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currentPosition = position;

    Geofire.initialize("availableDrivers");
    Geofire.setLocation(currentfirebaseUser.uid, currentPosition.latitude,
        currentPosition.longitude);
    rideRequestRef.set("searching");

    rideRequestRef.onValue.listen((event) {});
  }

  void getLocationLiveUpdates() {
    homeTabPageStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      currentPosition = position;
      if (isDriverAvailable == true) {
        Geofire.setLocation(
            currentfirebaseUser.uid, position.latitude, position.longitude);
      }
      LatLng latLng = LatLng(position.latitude, position.longitude);
      newGoogleMapController.animateCamera(CameraUpdate.newLatLng(latLng));
    });
  }

  void makeDriverOfflineNow() {
    Geofire.removeLocation(currentfirebaseUser.uid);
    rideRequestRef.onDisconnect();
    rideRequestRef.remove();
    //  rideRequestRef = null;
  }
}
