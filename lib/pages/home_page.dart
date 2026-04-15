import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;

    debugPrint('$data');

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
