import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  //For constructor
  String location;
  String flag;
  String timezone;

  //Value Generated when the fetchData() is invoked after creating a data through constructor
  String? dateTime;
  String? dayOfWeek;
  int? utcOffsetSeconds;
  String? displayTime; //AM PM Converted

  //constructor
  WorldTime(this.location, this.flag, this.timezone);

  /*  Sample Json data from the API
    {date_time: 2026-04-15T15:46:47.984510+08:00,
     date: 2026-04-15, time: 15:46:47.984510,
     day_of_week: Wednesday,
     dst_active: false,
     timezone: Asia/Manila,
     utc_offset_seconds: 28800} */
  Future<void> fetchData() async {
    //fetchData() invokes by LoadingPage
    try {
      //sample URL: https://timeapi.io/api/v1/time/current/zone?timezone=Asia%2FManila
      //Check JSON from the URI , timezone is a String data from the constructor
      var url = Uri.https('timeapi.io', '/api/v1/time/current/zone', {
        'timezone': timezone,
      });

      //Get the JSON from the URI
      var response = await http.get(
        url,
        headers: {
          //default headers to make the JSON display on the console
          'User-Agent': 'Android/iOS Platform',
          'Accept': 'application/JSON',
        },
      );

      debugPrint('Response time: ${response.statusCode}');
      //converts the JSON to a Map then extract and set the respective value to dateTime , dayOfWeek , utcOffSeconds.
      Map<String, dynamic> dataMap = jsonDecode(response.body);
      dateTime = dataMap['date_time'];
      dayOfWeek = dataMap['day_of_week'];
      utcOffsetSeconds = dataMap['utc_offset_seconds'];

      //dateTime(String) converts to clockTime(DateTime)
      //clockTime calibrates using the utcOffsetSeconds for dateTime and clockTime
      //clockTime is converted to AM/PM Format then passed the value to String displayTime for UI Display
      DateTime clockTime = DateTime.parse(dateTime!);
      clockTime = clockTime.add(Duration(seconds: utcOffsetSeconds!));
      dateTime = clockTime.toString();
      displayTime = DateFormat.jm().format(clockTime);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);

      debugPrint('Error: $e');
      debugPrint('Failed to fetch JSON , please check the URL');
    }
  }
}
