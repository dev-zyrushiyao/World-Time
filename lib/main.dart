import 'package:flutter/material.dart';
import 'package:time_viewer/pages/home_page.dart';
import 'package:time_viewer/pages/loading_page.dart';
import 'package:time_viewer/pages/loading_page_default.dart';
import 'package:time_viewer/pages/location_page.dart';

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
      initialRoute: '/defaultloading',
      routes: {
        '/defaultloading': (context) => LoadingPageDefault(),
        '/home': (contex) => HomePage(),
        '/loading': (contex) => LoadingPage(),
        '/changelocation': (context) => LocationPage(),
      },
    );
  }
}
