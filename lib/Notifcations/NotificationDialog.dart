import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:saasdriver/AllScreen/newRideScreen.dart';
import 'package:saasdriver/AllScreen/registrationScreen.dart';
import 'package:saasdriver/Assistants/assistantMethod.dart';
import 'package:saasdriver/Models/rideDetails.dart';
import 'package:saasdriver/configMap.dart';

import '../main.dart';

class NotificationDilog extends StatelessWidget {
  final RideDetails rideDetails;

  NotificationDilog({this.rideDetails});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      backgroundColor: Colors.transparent,
      elevation: 1.0,
      child: Container(
        margin: EdgeInsets.all(5.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: textcolor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "images/logo.png",
                width: 120.0,
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            Text(
              "New Ride Request",
              style: TextStyle(fontFamily: "segoe", fontSize: 18.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Divider(
              height: 2.0,
              color: Colors.black,
              thickness: 2.0,
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(color: red),
                      ),
                      primary: red,
                    ),
                    onPressed: () {
                    assetsAudioPlayer.stop();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel".toUpperCase(),
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: Colors.green)),
                      primary: green,
                    ),
                    onPressed: () async {
                      assetsAudioPlayer.stop();
                      checkAvailablityOfRide(context);
                    },
                    child: Text(
                      "Accept".toUpperCase(),
                      style: TextStyle(fontSize: 14.0),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }

  void checkAvailablityOfRide(context) {
    Navigator.pop(context);

    rideRequestRef.once().then((DataSnapshot dataSnapShot) {
      String theRideId = "";
      if (dataSnapShot.value != null) {
        theRideId = dataSnapShot.value.toString();
      } else {
        displaytostMessage("Ride not exists", context);
      }
      if (theRideId == rideDetails.ride_request_id) {
        rideRequestRef.set("accepted");
        AssistantMethods.disablehomeTabLiveLocationUpdate();
        AssistantMethods.updateBalc(commi.toInt(), context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewRideScreen(rideDetails: rideDetails)));
      } else if (theRideId == "cancelled") {
        displaytostMessage("Ride has been Cancelled", context);
      } else if (theRideId == "timeout") {
        displaytostMessage("Ride has timeout ", context);
      } else {
        displaytostMessage("Ride not exists", context);
      }
    });
  }
}
