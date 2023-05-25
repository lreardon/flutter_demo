import 'package:flutter/material.dart';
import 'models/location_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LocationList());
  }
}
