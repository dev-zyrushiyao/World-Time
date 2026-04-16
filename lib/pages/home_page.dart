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

  void startClock(Map<dynamic, dynamic> data) {
    //Duplicate the value of raw date-time from API as DateTime Type then add 1 second duration for every refresh of page
    //Periodic timer triggers the setState to refresh the page every second
    //Original value of data['time'] is replaced with the duplicate time that updates 1 second every refresh.
    DateTime convertedTime = DateTime.parse(data['dateTime']);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        convertedTime = convertedTime.add(Duration(seconds: 1));
        data['dateTime'] = convertedTime.toString();
      });
    });
  }

  void convertTime(Map<dynamic, dynamic> data) {
    //convert the time to AM/PM Formatt (converted using DartFormat from Intl.dart dependency)
    DateTime convertedTime = DateTime.parse(data['dateTime']);
    convertedTime = convertedTime.add(
      Duration(seconds: data['utcOffsetSeconds']),
    );
    String formattedTime = DateFormat.jm().format(convertedTime);
    data['dateTime'] = formattedTime;
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
    } else {
      data = data;

      debugPrint('Data is not empty');
    }

    //set dynamic timer
    startClock(data);
    //convert the dynamic timer to AM/PM format to present in the UI.
    convertTime(data);

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(style: TextStyle(fontSize: 20), '${data['dayOfWeek']}'),
                Text(style: TextStyle(fontSize: 80), '${data['dateTime']}'),
                Text(style: TextStyle(fontSize: 15), '${data['timezone']}'),

                Container(
                  padding: EdgeInsets.all(20),
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/changelocation');
                    },
                    child: Text('Change Timezone'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
