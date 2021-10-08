
import 'package:flutter/material.dart';
import 'package:saasdriver/AllScreen/registrationScreen.dart';

import '../configMap.dart';
import '../main.dart';
import 'mainscreen.dart';

class CarInfoScreen extends StatefulWidget {
  static const String idScreen = "carinfo";

  @override
  _CarInfoScreenState createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController carModelTextEditingController = TextEditingController();

  TextEditingController carNumberTextEditingController =
      TextEditingController();

  TextEditingController carColorTextEditingController = TextEditingController();

  String selectedCarType;

  List<String> carTypesList = ["bike","tuktuk"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/mainblurred.jpg"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Image.asset(
                  "images/logo.png",
                  width: 100.0,
                  height: 100.0,
                ),

                      SizedBox(
                  height: 15.0,
                ),
                  Text(
                  "Bike Details",
                  style: TextStyle(
                      fontFamily: "segoebold", fontSize: 28, color: primary),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 32.0),
                  child: Column(
                    children: [
                   
                      SizedBox(
                        height: 26.0,
                      ),
                     
                          TextFormField(
                          controller:   carModelTextEditingController,
                          cursorColor: primary,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    color: primary, style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: primary)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: primary)),
                            labelStyle:
                                TextStyle(fontSize: 14.0, color: backgroundcolor),
                            labelText: "Bick Model",
                            hintStyle: TextStyle(
                                color: backgroundcolor,
                                fontSize: 18.0,
                                fontFamily: "segoe"),
                          ),
                          style: TextStyle(fontSize: 14.0, fontFamily: "segoe",color: backgroundcolor),
                        ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          controller:  carNumberTextEditingController,
                          cursorColor: primary,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    color: primary, style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: primary)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: primary)),
                            labelStyle:
                                TextStyle(fontSize: 14.0, color: backgroundcolor),
                            labelText: "Bick Number",
                            hintStyle: TextStyle(
                                color: backgroundcolor,
                                fontSize: 18.0,
                                fontFamily: "segoe"),
                          ),
                          style: TextStyle(fontSize: 14.0, fontFamily: "segoe",color: backgroundcolor),
                        ),
                 
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          controller:  carColorTextEditingController,
                          cursorColor: primary,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    color: primary, style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: primary)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: primary)),
                            labelStyle:
                                TextStyle(fontSize: 14.0, color: backgroundcolor),
                            labelText: "Bick Color",
                            hintStyle: TextStyle(
                                color: backgroundcolor,
                                fontSize: 18.0,
                                fontFamily: "segoe"),
                          ),
                          style: TextStyle(fontSize: 14.0, fontFamily: "segoe",color: backgroundcolor),
                        ),
                       
                     
                      SizedBox(
                        height: 26.0,
                      ),
                      DropdownButton(
                       dropdownColor: textcolor,
                        style: TextStyle(color: bordercolor,fontFamily: "segoe"),
                        iconSize: 40,
                        hint: Text("Please Choose Bick Type",style: TextStyle(color: bordercolor),),
                        value: selectedCarType,
                        onChanged: (newValue) {
                          selectedCarType = newValue;
                          setState(() {
                            
                                                    });
                          displaytostMessage(selectedCarType, context);
                        },
                        items: carTypesList.map((car) {
                          return DropdownMenuItem(
                            child: new Text(car),
                            
                            value: car,
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 42.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (carModelTextEditingController.text.isEmpty) {
                              displaytostMessage(
                                  "please write Bick Model", context);
                            } else if (carNumberTextEditingController
                                .text.isEmpty) {
                              displaytostMessage(
                                  "please write Bick Number", context);
                            } else if (carColorTextEditingController
                                .text.isEmpty) {
                              displaytostMessage(
                                  "please write Bick Color", context);
                            } else if (selectedCarType == null) {
                              displaytostMessage(
                                  "please Select Bick Type", context);
                            } else {
                              saveDriverCarInfo(context);
                            }
                          },
                         style: ElevatedButton.styleFrom(
                            primary: primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0))),
                          child: Padding(
                            padding: EdgeInsets.all(17.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "NEXT",
                                   style: TextStyle(
                                  fontFamily: "segoebold",
                                  fontSize: 18.0,
                                  color: textcolor),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: textcolor,
                                  size: 26.0,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveDriverCarInfo(context) {
    String userId = currentfirebaseUser.uid;
    Map carInfoMap = {
      "car_color": carColorTextEditingController.text,
      "car_number": carNumberTextEditingController.text,
      "car_model": carModelTextEditingController.text,
      "type": selectedCarType,
    };
    driverRef.child(userId).child("car_details").set(carInfoMap);

    Navigator.pushNamedAndRemoveUntil(
        context, MainScreen.idScreen, (route) => false);
  }
}
