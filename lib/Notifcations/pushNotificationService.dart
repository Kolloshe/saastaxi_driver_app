import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:saasdriver/Models/rideDetails.dart';

import '../configMap.dart';
import '../main.dart';
import 'NotificationDialog.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  RemoteNotification notification = message.notification;
  AndroidNotification android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification.title,
        message.notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            icon: 'launch_background',
          ),
        ));
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

class PushNotificationService {
  Future initialize(context) async {
    
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            message.notification.hashCode,
            message.notification.title,
            message.notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launch_background',
              ),
            ));
      }
      print("++++++++++++++++++++++++++++++++++++");
      print(message.notification);
      retrieveRideRequestsInfo(getRideRequestId(message.data), context);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            message.notification.hashCode,
            message.notification.title,
            message.notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launch_background',
              ),
            ));
      }
      print("*********************");
      print(message.notification);
      retrieveRideRequestsInfo(getRideRequestId(message.data), context);
    });
  }

  Future<String> getToken() async {
    String token = await firebaseMessaging.getToken();
    driverRef.child(currentfirebaseUser.uid).child("token").set(token);
    print(" this is token");
    print(token);

    firebaseMessaging.subscribeToTopic("alldrivers");
    firebaseMessaging.subscribeToTopic("allusers");
  }

  String getRideRequestId(Map<String, dynamic> message) {
    String rideRequestId = "";
    if (Platform.isAndroid) {
      print("This is Ride Request Id:::::");
      rideRequestId = message['ride_request_id'];
      print(rideRequestId);
    } else {
      print("This is Ride Request Id:::::");
      rideRequestId = message['ride_request_id'];
    }
    return rideRequestId;
  }

  void retrieveRideRequestsInfo(String rideRequestId, BuildContext context) {
    newRequestsRef
        .child(rideRequestId)
        .once()
        .then((DataSnapshot dataSnapShot) {
      if (dataSnapShot.value != null) {
        double pickupLocationlat =
            double.parse(dataSnapShot.value['pickup']['latitude'].toString());
        double pickupLocationlng =
            double.parse(dataSnapShot.value['pickup']['longitude'].toString());
        String pickupAddress = dataSnapShot.value['pickup_address'].toString();
        double dropOffLocationlat =
            double.parse(dataSnapShot.value['dropoff']['latitude'].toString());
        double dropOffLocationlng =
            double.parse(dataSnapShot.value['dropoff']['longitude'].toString());
        String dropOffAddress =
            dataSnapShot.value['dropoff_address'].toString();
        String paymentMethod = dataSnapShot.value['payment_method'].toString();

        String rider_name = dataSnapShot.value["rider_name"];

        String rider_phone = dataSnapShot.value["rider_phone"];

        RideDetails rideDetails = RideDetails();
        rideDetails.ride_request_id = rideRequestId;
        rideDetails.pickup_address = pickupAddress;
        rideDetails.dropoff_address = dropOffAddress;
        rideDetails.pickup = LatLng(pickupLocationlat, pickupLocationlng);
        rideDetails.dropoff = LatLng(dropOffLocationlat, dropOffLocationlng);
        rideDetails.payment_method = paymentMethod;
        rideDetails.rider_name = rider_name;
        rideDetails.rider_phone = rider_phone;

        print("Information::");
        print(rideDetails.pickup_address);
        print(rideDetails.dropoff_address);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => NotificationDilog(
            rideDetails: rideDetails,
          ),
        );
        
        assetsAudioPlayer.open(Audio("sounds/alert.mp3"));
        assetsAudioPlayer.play();
      }
    });
  }
  
}
