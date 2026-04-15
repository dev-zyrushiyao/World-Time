import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  //For constructor
  String location;
  String flag;
  String timezone;

  //Value Generated when the fetchData is invoked
  String? time;
  String? dayOfWeek;

  //constructor
  WorldTime(this.location, this.flag, this.timezone);

  Future<void> fetchData() async {
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
      //converts the JSON to a Map
      Map<String, dynamic> dataMap = jsonDecode(response.body);

      //converting dateTime to time: AM/PM
      String dateTime = dataMap['date_time'];
      int utcOffsetSeconds = dataMap['utc_offset_seconds'];
      DateTime convertedTime = DateTime.parse(dateTime);
      convertedTime = convertedTime.add(Duration(seconds: utcOffsetSeconds));

      //Data from Json passed through variable
      time = DateFormat.jm().format(convertedTime);
      dayOfWeek = dataMap['day_of_week'];

      debugPrint(
        'The return value as Map: \n date time: $time \n day of week: $dayOfWeek \n timezone: $timezone',
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);

      debugPrint('Error: $e');
      debugPrint('Failed to fetch JSON , please check the URL');
    }
    //Setting up the URI

    // {date_time: 2026-04-15T15:46:47.984510+08:00, date: 2026-04-15, time: 15:46:47.984510, day_of_week: Wednesday, dst_active: false, timezone: Asia/Manila, utc_offset_seconds: 28800}
  }
}
