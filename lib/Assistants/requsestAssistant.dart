import 'dart:convert';

import 'package:http/http.dart' as http;

class RequstAssistant {
  static Future<dynamic> getRequest(String url) async {
    http.Response response = await http.get(Uri.parse(url));

    print(response.statusCode);
    try {
      if (response.statusCode == 200) {
        var jasondata = response.body;
        var decodeData = jsonDecode(jasondata.toString());
        return decodeData;
      } else {
        return "failed";
      }
    } catch (exp) {
      return "failed";
    }
  }
}
