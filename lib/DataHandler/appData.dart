import 'package:flutter/material.dart';
import 'package:saasdriver/Models/address.dart';
import 'package:saasdriver/Models/allUsers.dart';
import 'package:saasdriver/Models/drivers.dart';
import 'package:saasdriver/Models/history.dart';

class AppData extends ChangeNotifier {
  Address pickUpLocation, dropOffLocation;
  void updatePickUpLocationAddress(Address pickUpAddress) {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Address dropOffAddress) {
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }

  String earnings = "0";

  void updateEarnings(String updatedEarnings) {
    earnings = updatedEarnings;
    notifyListeners();
  }

  int balc;
  void getbalc(int saascoint) {
    balc = saascoint;
    notifyListeners();
  }

  int counttrips = 0;

  void updateTripsCounter(int tripCounter) {
    counttrips = tripCounter;
    notifyListeners();
  }

  List<String> tripHistorykeys = [];
  void updateTripkeys(List<String> newKeys) {
    tripHistorykeys = newKeys;
    notifyListeners();
  }

  List<History> tripHistoryDataList = [];
  void updateTripHistoryData(History eachHistory) {
    if (eachHistory.fares != null) {
      tripHistoryDataList.add(eachHistory);
    }

    notifyListeners();
  }

  Drivers user;
  void updateProfile(Drivers users) {
    user = users;
    notifyListeners();
  }

  String img;
  void getimg(String imj) {
    img = imj;
    notifyListeners();
  }

  int randomNumber;
  void getRandomNumber(int ran) {
    randomNumber = ran;
    notifyListeners();
  }

  int phone;
  void getphone(int phones) {
    phone = phones;
  }

  Locale _locale;
  Locale get locale => _locale ?? Locale('en');
  void changeLocale(Locale newLocale) {
    if (newLocale == Locale('ar')) {
      _locale = Locale('ar');
    } else {
      _locale = Locale('en');
    }
    notifyListeners();
  }

  double commission, killometer;
  void get_config(double commissions, double killometers) {
    commission = commissions;
    killometer = killometers;
    notifyListeners();
  }
}
