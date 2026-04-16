import 'package:flutter/material.dart';

class ChangeLocationPage extends StatelessWidget {
  const ChangeLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Timezone'),
        centerTitle: true,
        backgroundColor: Colors.blue[300],
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Text('Change Location Page'),
      ),
    );
  }
}
