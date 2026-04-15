import 'package:flutter/material.dart';
import 'package:time_viewer/services/world_time.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    debugPrint('Printing from initState');
    WorldTime('Asia/Manila').fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(child: Center(child: Text('This is homePage'))),
      ),
    );
  }
}
