// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../models/location.dart';
import '../styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class LocationVisitScreen extends StatefulWidget {
  final int _locationId;
  const LocationVisitScreen(this._locationId);

  @override
  State<StatefulWidget> createState() => _LocationVisitScreen(_locationId);
}

class _LocationVisitScreen extends State<LocationVisitScreen> {
  final int _locationId;
  bool loading = false;
  DateTime _selectedDay = DateTime.now();
  Location location = Location.blank();

  _LocationVisitScreen(this._locationId);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.name, style: Styles.navBarStyle),
        backgroundColor: Colors.red,
      ),
      body: RefreshIndicator(
        onRefresh: loadData,
        color: Colors.red.shade300,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'A date picker is a fun form input, a relatively complicated data type, and also a good way to demonstrate state management.',
                    textAlign: TextAlign.center,
                    style: Styles.headerLarge,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 100,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: this._selectedDay,
                      onDateTimeChanged: (DateTime newDateTime) {
                        setState(() {
                          this._selectedDay = newDateTime;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    DateFormat.yMMMMEEEEd().format(this._selectedDay),
                    style: Styles.headerLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadData() async {
    if (mounted) {
      setState(() => this.loading = true);
      final location = await Location.fetchById(this._locationId);
      setState(() {
        this.location = location;
        this.loading = false;
      });
    }
  }
}
