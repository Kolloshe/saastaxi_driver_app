import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Models/allUsers.dart';
import 'Models/drivers.dart';

String mapKey = "AIzaSyCOgbUkHnHCmwKQkyQ1X85xv-d7ZJ3dZuI";
String keyOfMap = "9d0571678703425a9c0c24d0573ae6c7";

User firebaseUser;
Users userCurrentInfo;

User currentfirebaseUser;

StreamSubscription<Position> homeTabPageStreamSubscription;

StreamSubscription<Position> rideStreamSubscription;

final assetsAudioPlayer = AssetsAudioPlayer();

Position currentPosition;

bool isDriverAvailable = false;

Drivers driversInformations;

String title = "";
double starCounter = 0.0;

Color primary = Color(0xfffdff00);
Color secondary = Color(0xff10316b);
Color backgroundcolor = Color(0xffffffe6);

Color textcolor = Color(0xff191a00);
Color bordercolor = Color(0xfff8f8f8);
Color org = Color(0xffffc916);
Color green = Color(0xff01e554);
Color red = Color(0xfffe5d33);

SharedPreferences prefs;

String images = "";

bool setonMap = false;
bool isItDropOff = false;

double killo = 0.0;
double commi = 0.0;


