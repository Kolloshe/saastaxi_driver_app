import 'package:firebase_database/firebase_database.dart';

class Drivers {
  int balc;
  String name;
  String phone;
  String email;
  String id;
  String car_color;
  String car_model;
  String car_number;
  String image;

  Drivers(
      {this.name,
      this.phone,
      this.email,
      this.id,
      this.car_color,
      this.car_model,
      this.car_number,
      this.balc,
      this.image});
  Drivers.fromSnapshot(DataSnapshot dataSnapshot) {
    id = dataSnapshot.key;
    phone = dataSnapshot.value["phone"];
    email = dataSnapshot.value["email"];
    name = dataSnapshot.value["name"];
    car_color = dataSnapshot.value["car_details"]["car_color"];
    car_model = dataSnapshot.value["car_details"]["car_model"];
    car_number = dataSnapshot.value["car_details"]["car_number"];
    balc = dataSnapshot.value["balc"];
    image = dataSnapshot.value["photo"];
  }
}
