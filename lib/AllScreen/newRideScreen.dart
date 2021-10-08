import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saasdriver/AllWidgets/collectFareDialog.dart';
import 'package:saasdriver/AllWidgets/progressDialog.dart';
import 'package:saasdriver/Assistants/assistantMethod.dart';
import 'package:saasdriver/Assistants/mapKitAssistant.dart';
import 'package:saasdriver/Models/rideDetails.dart';
import 'package:saasdriver/configMap.dart';
import 'package:saasdriver/main.dart';

class NewRideScreen extends StatefulWidget {
  final RideDetails rideDetails;
  NewRideScreen({this.rideDetails});

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 10.4746,
  );

  @override
  _NewRideScreenState createState() => _NewRideScreenState();
}

class _NewRideScreenState extends State<NewRideScreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController newRideGoogleMapController;

  Set<Marker> markersSet = Set<Marker>();
  Set<Circle> circleSet = Set<Circle>();
  Set<Polyline> polylineSet = Set<Polyline>();
  List<LatLng> polylineCorOrdinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  double mapPaddingFrombottom = 0;

  var geoLocator = Geolocator();
  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.bestForNavigation);

  BitmapDescriptor animatingMarkerIcon;

  Position myposition;

  String status = "accepted";

  String durationRide = "";

  bool isRequestingDirection = false;

  String btnTitle = "Arrived";
  Color btnColor = org;

  Timer timer;
  int durationCounter = 0;

  @override
  void initState() {
    super.initState();
    acceptRideRequest();
  }

  void createIconMarker() {
    if (animatingMarkerIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: Size(2, 2));
      BitmapDescriptor.fromAssetImage(imageConfiguration, "images/bikeicon.png")
          .then((value) {
        animatingMarkerIcon = value;
      });
    }
  }

  void getRideLiveLocationUpdate() {
    LatLng oldPos = LatLng(0, 0);

    rideStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      currentPosition = position;
      myposition = position;

      LatLng mPosition = LatLng(position.latitude, position.longitude);

      var rot = MapKitAssistant.getMarkerRotation(oldPos.latitude,
          oldPos.longitude, myposition.latitude, myposition.longitude);

      Marker animatingMarker = Marker(
        markerId: MarkerId("animating"),
        position: mPosition,
        icon: animatingMarkerIcon,
        rotation: rot,
        infoWindow: InfoWindow(title: "Current Location"),
      );

      setState(() {
        CameraPosition cameraPosition = new CameraPosition(target: mPosition,zoom: 20);

        newRideGoogleMapController
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

        markersSet
            .removeWhere((marker) => marker.markerId.value == "animating");
        markersSet.add(animatingMarker);
      });
      oldPos = mPosition;
      updateRideDetails();

      String rideRequestId = widget.rideDetails.ride_request_id;
      Map locMap = {
        "latitude": currentPosition.latitude.toString(),
        "longitude": currentPosition.longitude.toString()
      };
      newRequestsRef.child(rideRequestId).child("driver_location").set(locMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    createIconMarker();

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(bottom: mapPaddingFrombottom),
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: NewRideScreen._kGooglePlex,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              // zoomControlsEnabled: true,
              compassEnabled: true,
              markers: markersSet,
              circles: circleSet,
              polylines: polylineSet,
              onMapCreated: (GoogleMapController controller) async {
                _controllerGoogleMap.complete(controller);
                newRideGoogleMapController = controller;
                setState(() {
                  mapPaddingFrombottom = 270.0;
                });

                var currentLatLng =
                    LatLng(currentPosition.latitude, currentPosition.longitude);
                var pickUpLatLng = widget.rideDetails.pickup;

                await getPlaceDirection(currentLatLng, pickUpLatLng);

                getRideLiveLocationUpdate();
              },
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 16.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7))
                    ]),
                height: 270.0,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    children: [
                      Text(
                        "${durationRide}min",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: "segoebold",
                            color: textcolor),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.rideDetails.rider_name,
                            style: TextStyle(
                                fontFamily: "Brand-Bold", fontSize: 24.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(Icons.phone_android),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 26.0,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "images/pickicon.png",
                            height: 16.0,
                            width: 16.0,
                          ),
                          SizedBox(
                            width: 18.0,
                          ),
                          Expanded(
                              child: Container(
                            child: Text(
                              widget.rideDetails.pickup_address,
                              style: TextStyle(fontSize: 18.0),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "images/desticon.png",
                            height: 16.0,
                            width: 16.0,
                          ),
                          SizedBox(
                            width: 18.0,
                          ),
                          Expanded(
                              child: Container(
                            child: Text(
                              widget.rideDetails.dropoff_address,
                              style: TextStyle(fontSize: 18.0),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 26.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: btnColor,
                          ),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(18.0),
                          //     side: BorderSide(color: Colors.green)),
                          onPressed: () async {
                            if (status == "accepted") {
                              status = "arrived";
                              String rideRequestId =
                                  widget.rideDetails.ride_request_id;
                              newRequestsRef
                                  .child(rideRequestId)
                                  .child("status")
                                  .set(status);
                              setState(() {
                                btnTitle = "Start Trip";
                                btnColor = green;
                              });

                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) =>
                                      ProgressDialog(
                                        message: "Please wait...",
                                      ));
                              await getPlaceDirection(widget.rideDetails.pickup,
                                  widget.rideDetails.dropoff);
                              Navigator.pop(context);
                            } else if (status == "arrived") {
                              status = "onride";
                              String rideRequestId =
                                  widget.rideDetails.ride_request_id;
                              newRequestsRef
                                  .child(rideRequestId)
                                  .child("status")
                                  .set(status);
                              setState(() {
                                btnTitle = "End Trip";
                                btnColor = red;
                              });
                              initTimer();
                            } else if (status == "onride") {
                              endTheTrip();
                            }
                          },

                          // child: Text(
                          //   "Accept".toUpperCase(),
                          //   style: TextStyle(fontSize: 14.0),
                          // ),
                          child: Padding(
                            padding: EdgeInsets.all(17.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(btnTitle,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "segoebold",
                                        color: textcolor)),
                                Icon(
                                  Icons.directions_bike,
                                  color: Colors.white,
                                  size: 26.0,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
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

  Future<void> getPlaceDirection(
      LatLng pickUppoints, LatLng dropOffpoints) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              message: "please wait...",
            ));

    print('initial point is $dropOffpoints');
    var details = await AssistantMethods.obtainPlaceDirectionDetails(
        pickUppoints, dropOffpoints);

    Navigator.pop(context);
    print("++_+_+_+_+_+_+_+_+_+_+_+_++");
    print(details.points);
    PolylinePoints polylinePoints = PolylinePoints();
    // List<PointLatLng> decodePolyLinesResult =
    //     polylinePoints.decodePolyline(details.points[0].toString());
    print(polylinePoints);
    polylineCorOrdinates.clear();
    if (details.points.isNotEmpty) {
      details.points.forEach((dynamic pointss) {
        polylineCorOrdinates.add(LatLng(pointss[1], pointss[0]));
      });
    }
    polylineSet.clear();
    setState(() {
      Polyline polyline = Polyline(
          color: Colors.orange,
          polylineId: PolylineId("PolylineID"),
          jointType: JointType.round,
          points: polylineCorOrdinates,
          consumeTapEvents: true,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true);
      polylineSet.add(polyline);
    });

    LatLngBounds latLagBounds;

    if (pickUppoints.latitude > dropOffpoints.latitude &&
        pickUppoints.longitude > dropOffpoints.longitude) {
      latLagBounds =
          LatLngBounds(southwest: dropOffpoints, northeast: pickUppoints);
    } else if (pickUppoints.longitude > dropOffpoints.longitude) {
      latLagBounds = LatLngBounds(
          southwest: LatLng(pickUppoints.latitude, dropOffpoints.longitude),
          northeast: LatLng(dropOffpoints.latitude, pickUppoints.longitude));
    } else if (pickUppoints.latitude > dropOffpoints.latitude) {
      latLagBounds = LatLngBounds(
          southwest: LatLng(dropOffpoints.latitude, pickUppoints.longitude),
          northeast: LatLng(pickUppoints.latitude, pickUppoints.longitude));
    } else {
      latLagBounds =
          LatLngBounds(southwest: pickUppoints, northeast: dropOffpoints);
    }
    newRideGoogleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLagBounds, 70));

    Marker pickUpLocMarker = Marker(
      icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(0.2, 0.2)), "images/marker1.png"),
      position: pickUppoints,
      markerId: MarkerId("PickUpId"),
    );
    Marker dropOffLocMarker = Marker(
      icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(0.2, 0.2)), "images/marker1.png"),
      position: dropOffpoints,
      markerId: MarkerId("DropOffId"),
    );

    setState(() {
      markersSet.add(pickUpLocMarker);
      markersSet.add(dropOffLocMarker);
    });
    Circle pikupLocCircle = Circle(
      fillColor: Colors.orange,
      center: pickUppoints,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.orangeAccent,
      circleId: CircleId("PickUpId"),
    );
    Circle dropOffLocCircle = Circle(
      fillColor: Colors.red,
      center: dropOffpoints,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.red,
      circleId: CircleId("DropOffId"),
    );
    setState(() {
      circleSet.add(pikupLocCircle);
      circleSet.add(dropOffLocCircle);
    });
  }

  void acceptRideRequest() {
    String rideRequestId = widget.rideDetails.ride_request_id;
    newRequestsRef.child(rideRequestId).child("status").set("accepted");
    newRequestsRef
        .child(rideRequestId)
        .child("driver_name")
        .set(driversInformations.name);
    newRequestsRef
        .child(rideRequestId)
        .child("driver_phone")
        .set(driversInformations.phone);
    newRequestsRef
        .child(rideRequestId)
        .child("driver_id")
        .set(driversInformations.id);
    newRequestsRef.child(rideRequestId).child("car_details").set(
        '${driversInformations.car_color} - ${driversInformations.car_model}');

    Map locMap = {
      "latitude": currentPosition.latitude.toString(),
      "longitude": currentPosition.longitude.toString()
    };
    newRequestsRef.child(rideRequestId).child("driver_location").set(locMap);

    driverRef
        .child(currentfirebaseUser.uid)
        .child("history")
        .child(rideRequestId)
        .set(true);
  }

  void updateRideDetails() async {
    if (isRequestingDirection == false) {
      isRequestingDirection = true;
      if (myposition == null) {
        return;
      }
      var posLatLng = LatLng(myposition.latitude, myposition.longitude);
      LatLng destinationLatLng;

      if (status == "accepted") {
        destinationLatLng = widget.rideDetails.pickup;
      } else {
        destinationLatLng = widget.rideDetails.dropoff;
      }
      var directionDetails = await AssistantMethods.obtainPlaceDirectionDetails(
          posLatLng, destinationLatLng);
      if (directionDetails != null) {
        setState(() {
          durationRide =
              (directionDetails.distanceValue / 60).toStringAsFixed(1);
        });
      }
      isRequestingDirection = false;
    }
  }

  void initTimer() {
    const interval = Duration(seconds: 1);
    timer = Timer.periodic(interval, (timer) {
      durationCounter = durationCounter + 1;
    });
  }

  endTheTrip() async {
    timer.cancel();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ProgressDialog(
        message: "Please wait...",
      ),
    );
    var currentLatLng = LatLng(myposition.latitude, myposition.longitude);

    var directionalDetails = await AssistantMethods.obtainPlaceDirectionDetails(
        widget.rideDetails.pickup, currentLatLng);
    Navigator.pop(context);

    int fareAmount = AssistantMethods.calculateFares(directionalDetails);
    String rideRequestId = widget.rideDetails.ride_request_id;
    newRequestsRef
        .child(rideRequestId)
        .child("fares")
        .set(fareAmount.toString());
    newRequestsRef.child(rideRequestId).child("status").set("ended");
    rideStreamSubscription.cancel();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CollectFareDialog(
        paymentMethod: widget.rideDetails.payment_method,
        fareAmount: fareAmount,
      ),
    );
    saveEarnings(fareAmount);
  }

  void saveEarnings(int fareAmount) {
    driverRef
        .child(currentfirebaseUser.uid)
        .child("earnings")
        .once()
        .then((DataSnapshot dataSnapShot) {
      if (dataSnapShot.value != null) {
        double oldEarnings = double.parse(dataSnapShot.value.toString());
        double totalEarnings = fareAmount + oldEarnings;

        driverRef
            .child(currentfirebaseUser.uid)
            .child("earnings")
            .set(totalEarnings.toStringAsFixed(2));
      } else {
        double totalEarnings = fareAmount.toDouble();
        driverRef
            .child(currentfirebaseUser.uid)
            .child("earnings")
            .set(totalEarnings.toStringAsFixed(2));
      }
    });
  }
}
