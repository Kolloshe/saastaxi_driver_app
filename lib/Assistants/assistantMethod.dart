import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:saasdriver/AllScreen/loginScreen.dart';
import 'package:saasdriver/AllScreen/otpValidation.dart';
import 'package:saasdriver/DataHandler/appData.dart';
import 'package:saasdriver/Models/address.dart';
import 'package:saasdriver/Models/allUsers.dart';
import 'package:saasdriver/Models/directDetails.dart';
import 'package:saasdriver/Models/history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../configMap.dart';
import '../main.dart';
import 'requsestAssistant.dart';

import 'package:provider/provider.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress = "";

    String url =
        "https://api.geoapify.com/v1/geocode/reverse?lat=${position.latitude}&lon=${position.longitude}&lang=de&limit=10&apiKey=$keyOfMap";

    var response = await RequstAssistant.getRequest(url);

    if (response != "failed") {
      placeAddress = response["features"][0]["properties"]["address_line1"];
      Address userPickUpAddress = new Address();
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updatePickUpLocationAddress(userPickUpAddress);
    }
    return placeAddress;
  }

  static Future<DirectionDetails> obtainPlaceDirectionDetails(
      LatLng initialPosition, LatLng finalPosition) async {
    String directionUrl =
        "https://api.geoapify.com/v1/routing?waypoints=${initialPosition.latitude},${initialPosition.longitude}|${finalPosition.latitude},${finalPosition.longitude}&mode=drive&apiKey=$keyOfMap";

    var res = await RequstAssistant.getRequest(directionUrl);
    if (res == "failed") {
      return null;
    }
    //***********change valu */
    DirectionDetails directionDetails = DirectionDetails();
    directionDetails.points = res["features"][0]["geometry"]["coordinates"][0];
    directionDetails.distanceValue =
        res["features"][0]["properties"]["distance"];
    dynamic time = res["features"][0]["properties"]["time"];
    directionDetails.time = (time);
    return directionDetails;
  }

  static int calculateFares(DirectionDetails directionDetails) {
    double timeTraveledFare = (directionDetails.time / 60) * 0.20;
    double distancTraveledFare = (directionDetails.distanceValue / 1000) * 0.20;
    double totalFareAmount = timeTraveledFare + distancTraveledFare;
    double totlaLoalAmont = totalFareAmount * 250;

    return totlaLoalAmont.truncate();
  }

  static void getCurrentOnlineUserInfo() async {
    firebaseUser =  FirebaseAuth.instance.currentUser;
    String userId = firebaseUser.uid;
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("user").child(userId);
    reference.once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        userCurrentInfo  = Users.fromSnapshot(dataSnapshot);
      }
    });
  }

  static void disablehomeTabLiveLocationUpdate() {
    homeTabPageStreamSubscription.pause();
    Geofire.removeLocation(currentfirebaseUser.uid);
  }

  static void enablehomeTabLiveLocationUpdate() {
    homeTabPageStreamSubscription.resume();
    Geofire.setLocation(currentfirebaseUser.uid, currentPosition.latitude,
        currentPosition.longitude);
  }

  static void retrieveHistoryInfo(context) {
    //retrieve and display Earnings
    driverRef
        .child(currentfirebaseUser.uid)
        .child("earnings")
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        String earnings = dataSnapshot.value.toString();
        Provider.of<AppData>(context, listen: false).updateEarnings(earnings);
      }
    });

    //retrieve and display Trip History
    driverRef
        .child(currentfirebaseUser.uid)
        .child("history")
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        //update total number of trip count to provider
        Map<dynamic, dynamic> keys = dataSnapshot.value;
        int tripCounter = keys.length;
        Provider.of<AppData>(context, listen: false)
            .updateTripsCounter(tripCounter);
//update tripkeys to provider
        List<String> tripHistoryKeys = [];
        keys.forEach((key, value) {
          tripHistoryKeys.add(key);
        });
        Provider.of<AppData>(context, listen: false)
            .updateTripkeys(tripHistoryKeys);
        obtainTripRequestsHistoryData(context);
      }
    });
  }

  static obtainTripRequestsHistoryData(context) {
    var keys = Provider.of<AppData>(context, listen: false).tripHistorykeys;
    for (String key in keys) {
      newRequestsRef.child(key).once().then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          var history = History.fromSnapshot(snapshot);
          Provider.of<AppData>(context, listen: false)
              .updateTripHistoryData(history);
        }
      });
    }
  }

  static String formatTripDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate =
        "${DateFormat.MMMd().format(dateTime)},${DateFormat.y().format(dateTime)}-${DateFormat.jm().format(dateTime)}";

    return formattedDate;
  }

  static loadimage() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      images = prefs.getString("photo");
    } else {
      driverRef
          .child(currentfirebaseUser.uid)
          .child("photo")
          .once()
          .then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          images = snapshot.value;
        }
      });
    }
  }

  String photos = "";
  loadFromPrf() async {
    prefs = await SharedPreferences.getInstance();
    String photo = prefs.getString("photo");
    photos = photo;
  }

  static updateBalc(int x, context) {
    int y = Provider.of<AppData>(context, listen: false).balc;

    y = y - x;

    driverRef.child(currentfirebaseUser.uid).child('balc').set(y);
    Provider.of<AppData>(context, listen: false).balc = y;
  }

  static Future otpmesseage(int phone, String mes, BuildContext context) async {
    String otpurl =
        "https://mazinhost.com/smsv1/sms/api?action=send-sms&api_key=YWxhbWluc29mdDpOaWxlcG93cjU2MjY=&to=${phone}&from=SAASTAXI&sms=$mes";
    var res = await RequstAssistant.getRequest(otpurl);
    if (res == "failed") {
      return null;
    } else {
      var x = res['code'];

      if (x == 'ok') {
        Navigator.pushNamed(context, OtpValidation.idScreen);
      }
    }
  }
}
