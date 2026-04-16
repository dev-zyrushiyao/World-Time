import 'package:flutter/material.dart';
import 'package:time_viewer/services/world_time.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  String time = 'Loading';

  void getTime() async {
    //default value to be transfered to homepage
    WorldTime instance = WorldTime('Manila', 'ph-flag.jpg', 'Asia/Manila');
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
    Navigator.pushReplacementNamed(
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
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Text('Loading....')));
  }
}
