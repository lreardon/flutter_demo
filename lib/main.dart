// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'screens/location_list_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LocationListScreen());
  }
}
