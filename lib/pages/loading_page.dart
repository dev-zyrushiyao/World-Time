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

    //value of WorldTime passed to HomePage Route.
    Navigator.pushReplacementNamed(
      (context),
      '/home',
      arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'timezone': instance.timezone,
        'time': instance.time,
        'day': instance.dayOfWeek,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    debugPrint('Printing from initState');
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Text('Loading....')));
  }
}
