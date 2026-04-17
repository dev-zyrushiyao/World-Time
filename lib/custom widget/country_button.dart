import 'package:flutter/material.dart';

class CountryButton extends StatelessWidget {
  const CountryButton({
    super.key,
    required this.flag,
    required this.location,
    required this.timezone,
  });

  // Variables must be final in a StatelessWidget
  final String location;
  final String flag;
  final String timezone;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () {
        Navigator.popAndPushNamed(
          (context),
          '/loading',
          arguments: {'location': location, 'flag': flag, 'timezone': timezone},
        );
        debugPrint('Pressed from Location Page Button');
      },
      icon: const Icon(Icons.access_time_filled_outlined),
      label: Text(location),
    );
  }
}
