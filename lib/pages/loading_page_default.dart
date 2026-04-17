import 'package:flutter/material.dart';
import 'package:time_viewer/services/world_time.dart';

class LoadingPageDefault extends StatefulWidget {
  const LoadingPageDefault({super.key});

  @override
  State<LoadingPageDefault> createState() => _LoadingPageDefaultState();
}

class _LoadingPageDefaultState extends State<LoadingPageDefault> {
  final String time = 'Loading';

  Map data = {};

  void getTime() async {
    //returning a default value; this page loads once.
    WorldTime instance = WorldTime(
      data['location'] = 'Philippines',
      data['flag'] = 'flagph',
      data['timezone'] = 'Asia/Manila',
    );

    await instance.fetchData();

    //Prevent the Async Gap - GUARD: Checks if the user is still on this screen
    if (!mounted) return;

    // value of WorldTime passed to HomePage Route
    // The Sample value of the instance:
    // date time: 2026-04-15T22:11:59.124805+08:00
    // day of week: Wednesday
    // timezone: Asia/Manila
    // offset: 28800
    // displayTime: 8:00PM
    Navigator.popAndPushNamed(
      (context),
      '/home',
      arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'timezone': instance.timezone,
        'dateTime': instance
            .dateTime, // Raw Data to convert -> to later passed to displayTime when it updates every second
        'dayOfWeek': instance.dayOfWeek,
        'utcOffsetSeconds': instance.utcOffsetSeconds,
        'displayTime': instance.displayTime, // initial data for display
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getTime();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Text('Loading....')));
  }
}
