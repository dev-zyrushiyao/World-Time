import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldTime {
  String? dateTime;
  String? dayOfWeek;
  String? timezone;
  int? utcOffsetSeconds;

  WorldTime(this.timezone);

  void fetchData() async {
    //sample URL: https://timeapi.io/api/v1/time/current/zone?timezone=Asia%2FManila
    var url = Uri.https('timeapi.io', '/api/v1/time/current/zone', {
      'timezone': timezone,
    });
    var response = await http.get(
      url,
      headers: {
        //default headers to make the JSON display on the console
        'User-Agent': 'Android/iOS Platform',
        'Accept': 'application/JSON',
      },
    );
    Map<String, dynamic> dataMap = jsonDecode(response.body);

    debugPrint('$dataMap');
    // {date_time: 2026-04-15T15:46:47.984510+08:00, date: 2026-04-15, time: 15:46:47.984510, day_of_week: Wednesday, dst_active: false, timezone: Asia/Manila, utc_offset_seconds: 28800}
  }
}
