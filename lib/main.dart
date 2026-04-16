import 'package:flutter/material.dart';
import 'package:time_viewer/pages/home_page.dart';
import 'package:time_viewer/pages/loading_page.dart';
import 'package:time_viewer/pages/change_location_Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Viewer App',
      initialRoute: '/loading',
      routes: {
        '/home': (contex) => HomePage(),
        '/loading': (contex) => LoadingPage(),
        '/changelocation': (context) => ChangeLocationPage(),
      },
    );
  }
}
