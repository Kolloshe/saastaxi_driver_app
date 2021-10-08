import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {



  static const String img_key = 'Image_key';
  static Future<bool> saveImageTOPreferences(String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
  
    return preferences.setString(img_key, value);
  }

  static Future<String> getImageFromPrefernces() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(img_key);
  }

  static String base64String(Uint8List date) {
    return base64Encode(date);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }
  
}
