import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasdriver/AllScreen/AboutScreen.dart';
import 'package:saasdriver/AllScreen/otpScreen.dart';
import 'package:saasdriver/AllScreen/otpValidation.dart';
import 'package:saasdriver/AllScreen/registrationScreen.dart';
import 'package:saasdriver/AllScreen/welcomeScreen.dart';
import 'package:saasdriver/tabsPages/earningsTabPage.dart';
import 'package:saasdriver/tabsPages/homeTabPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'AllScreen/carInfoScreen.dart';
import 'AllScreen/loginScreen.dart';
import 'AllScreen/mainscreen.dart';
import 'DataHandler/appData.dart';
import 'configMap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

  currentfirebaseUser = FirebaseAuth.instance.currentUser;
}

DatabaseReference newRequestsRef =
    FirebaseDatabase.instance.reference().child("Ride Requests");
DatabaseReference userRef = FirebaseDatabase.instance.reference().child("user");
DatabaseReference driverRef =
    FirebaseDatabase.instance.reference().child("drivers");
DatabaseReference rideRequestRef = FirebaseDatabase.instance
    .reference()
    .child("drivers")
    .child(currentfirebaseUser.uid)
    .child("newRide");
    DatabaseReference configref =
    FirebaseDatabase.instance.reference().child("config");

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: Consumer<AppData>(
        builder: (context, locale, child) {
          return MaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: Provider.of<AppData>(context).locale,
            supportedLocales: [
              const Locale('en', ''),
              const Locale('ar', ''),
            ],
            title: 'Saas Driver App',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity),
            initialRoute: FirebaseAuth.instance.currentUser == null
                ? WelcomeScreen.idScreen
                : MainScreen.idScreen,
            routes: {
              WelcomeScreen.idScreen: (context) => WelcomeScreen(),
              OtpValidation.idScreen: (context) => OtpValidation(),
              Otpscreen.idScreen: (context) => Otpscreen(),
              RegisterationScreen.idScreen: (context) => RegisterationScreen(),
              LoginScreen.idScreen: (context) => LoginScreen(),
              MainScreen.idScreen: (context) => MainScreen(),
              CarInfoScreen.idScreen: (context) => CarInfoScreen(),
              HomeTabPage.idScreen: (context) => HomeTabPage(),
              EarningTabPage.idScreen: (context) => EarningTabPage(),
              AboutScreen.idScreen: (context) => AboutScreen(),
            },
            debugShowCheckedModeBanner: false,
            
          );
        },
      ),
    );
  }
}
