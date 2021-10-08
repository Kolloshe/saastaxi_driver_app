import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DirectionDetails {
  int distanceValue;
 dynamic time;
  //String distanceText;
  String timeText;
   List<dynamic> points;
  DirectionDetails(
      {this.distanceValue,
      this.time,
     // this.distanceText,
      this.timeText,
      this.points});
}
