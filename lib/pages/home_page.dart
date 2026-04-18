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
  DateTime? clockTime;

  void startClock() {
    //prevents creating a new timer if a timer already exist else skip this method.
    if (timer != null) return;

    /*timer increase the duration of clockTime by 1 second then converts value to AM/PM and passed to display variabl
     every refresh of the page/state */
    //1.the value of clockTime will overrite to dateTime
    //2.the latest value of dateTime will overrite the value of displayTime
    //3.displayTime appears in the UI while dateTime is for conversion
    //4.this algorithm is just to prevent the display of Raw Data in the UI before converts to AM/PM Format
    clockTime = DateTime.parse(data['dateTime']);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        clockTime = clockTime!.add(Duration(seconds: 1));
        data['dateTime'] = DateFormat.jm().format(clockTime!);
        data['displayTime'] = data['dateTime'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //if the data is not empty show the Data else fetch a new data from the LoadingPage
    if (data.isEmpty) {
      data = ModalRoute.of(context)!.settings.arguments as Map;
    } else {
      data = data;
    }

    //find a way to move this to init state
    startClock();

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(style: TextStyle(fontSize: 20), '${data['dayOfWeek']}'),
                Text(style: TextStyle(fontSize: 80), '${data['displayTime']}'),
                Text(style: TextStyle(fontSize: 15), '${data['timezone']}'),

                Container(
                  padding: const EdgeInsets.all(20),
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/changelocation');
                    },
                    child: const Text('Change Timezone'),
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
