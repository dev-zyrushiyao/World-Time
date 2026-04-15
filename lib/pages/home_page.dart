import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Where the LoadingPage - Navigator.pushReplacementNamed arguments will be stored
  Map data = {};

  //timer to refresh time
  Timer? timer;

  void startClock() {
    /* Using the value of data['time] from LoadingPage then add the data['offset'] time to calibrate the time 
    (Sample value: {date time: 2026-04-15T22:11:59.124805+08:00}) + 28800 in utc_seconds*/
    DateTime convertedTime = DateTime.parse(data['time']);
    convertedTime = convertedTime.add(Duration(seconds: data['offset']));

    //Periodic timer trigger the setState to refresh the page every second
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        convertedTime = convertedTime.add(Duration(seconds: 1));

        //convert the time to AM/PM Formatt (converted using DartFormat from Intl.dart dependency)
        String formattedTime = DateFormat.jm().format(convertedTime);
        data['time'] = formattedTime;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    //if the data is not empty show the Data else fetch a new data from the LoadingPage
    if (data.isEmpty) {
      data = ModalRoute.of(context)!.settings.arguments as Map;
      startClock();
    }

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(style: TextStyle(fontSize: 20), '${data['day']}'),
                Text(style: TextStyle(fontSize: 80), '${data['time']}'),
                Text(style: TextStyle(fontSize: 15), '${data['timezone']}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
