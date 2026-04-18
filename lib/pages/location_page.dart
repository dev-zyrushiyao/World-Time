import 'package:flutter/material.dart';
import 'package:time_viewer/services/world_time.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  //list of widget that contains WorldTime object
  List locationList = [];

  void addCountry() {
    final List countries = [
      WorldTime('Philippines', 'Manila.png', 'Asia/Manila'),
      WorldTime('Korea', 'korea.png', 'Asia/Seoul'),
      WorldTime('Japan', 'Japan.png', 'Asia/Tokyo'),
      WorldTime('Thailand', 'Thai.png', 'Asia/Bangkok'),
    ];

    /* loopling the list of countries then puts that object of contry as a widget into a new list 
    that will be displayed in UI */
    for (var item in countries) {
      locationList.add(listButton(item));
    }
  }

  Widget listButton(WorldTime item) {
    return ListTile(
      title: Text(item.location),
      subtitle: Text(item.timezone),
      leading: Image.asset(
        'assets/${item.flag}',
        errorBuilder: (context, error, stackTrace) =>
            Image.asset('assets/default.jpg'),
      ),
      onTap: () {
        Navigator.pushReplacementNamed(
          (context),
          '/loading',
          arguments: {
            'location': item.location,
            'flag': item.flag,
            'timezone': item.timezone,
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    addCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Timezone'),
        centerTitle: true,
        backgroundColor: Colors.blue[300],
      ),
      body: Column(
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: locationList.length,
                itemBuilder: (context, index) => locationList[index],
              ),
            ),
          ),
          Text('Hey'),
          // FilledButton(onPressed: () {}, child: Text('Button')),
        ],
      ),
    );
  }
}
