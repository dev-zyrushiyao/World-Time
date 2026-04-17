import 'package:flutter/material.dart';
import 'package:time_viewer/custom widget/country_button.dart';
import 'package:time_viewer/services/world_time.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final List countries = [
    WorldTime('Philippines', 'Manila.png', 'Asia/Manila'),
    WorldTime('Korea', 'korea.png', 'Asia/Seoul'),
    WorldTime('Japan', 'Japan.png', 'Asia/Tokyo'),
    WorldTime('Thailand', 'Thai.png', 'Asia/Bangkok'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Timezone'),
        centerTitle: true,
        backgroundColor: Colors.blue[300],
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Column(
          children: [
            for (var items in countries)
              CountryButton(
                flag: items.location,
                location: items.location,
                timezone: items.timezone,
              ),
          ],
        ),
      ),
    );
  }
}
