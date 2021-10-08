import 'package:firebase_database/firebase_database.dart';

class Users {
  String id;
  String name;
  String email;
  String phone;
 
  Users({this.id, this.email, this.name, this.phone});
  Users.fromSnapshot(DataSnapshot dataSnapshot) {
    id = dataSnapshot.key;
    email = dataSnapshot.value["email"];
    name = dataSnapshot.value["name"];
    phone = dataSnapshot.value["phone"];
 
  }
}
