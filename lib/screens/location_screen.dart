// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import '../models/location.dart';
import '../models/location_fact.dart';
import 'location_visit_screen.dart';
import '../styles.dart';

class LocationScreen extends StatefulWidget {
  final int _locationId;
  const LocationScreen(this._locationId);

  @override
  State<StatefulWidget> createState() => _LocationScreenState(_locationId);
}

class _LocationScreenState extends State<LocationScreen> {
  final int _locationId;
  bool loading = false;
  Location location = Location.blank();

  _LocationScreenState(this._locationId);

  @override
  // initState() is invoked when the widget is mounted.
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _progressBar(context),
                  _bannerImage(location.url, 170.0),
                  _factsList(context, location),
                  _formButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadData() async {
    // The build method requires context, which requires that our widget has been mounted into the widget tree.
    // Calling setState() will trigger a build() of the widget.
    // Hence we guardrail the setState() method to ensure that the widget has already been mounted.
    if (mounted) {
      setState(() => this.loading = true);
      final location = await Location.fetchById(this._locationId);
      setState(() {
        this.location = location;
        this.loading = false;
      });
    }
  }

  Widget _progressBar(BuildContext context) {
    return this.loading
        ? LinearProgressIndicator(
            value: null,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade800))
        : Container();
  }

  // Priavte methods are prepended with an underscore '_'
  Widget _fact(String title, String text) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: Styles.headerLarge,
        ),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        child: Text(text, textAlign: TextAlign.left, style: Styles.textDefault),
      )
    ]);
  }

  Widget _factsList(BuildContext context, Location location) {
    List<Widget> renderedFacts = [];

    for (int i = 0; i < location.facts.length; i++) {
      LocationFact fact = location.facts[i];
      renderedFacts.add(_fact(fact.title, fact.text));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: renderedFacts,
    );
  }

  Widget _bannerImage(String url, double height) {
    Image? image;
    try {
      if (url.isNotEmpty) {
        image = Image.network(url, fit: BoxFit.fitWidth);
      }
    } catch (e) {
      print("Could not load image url $url");
    }
    return Container(
      // Constraints can be used to enforce container sizing, though we don't this constraint for this image.
      // constraints: BoxConstraints.tightFor(height: height),
      child: image,
    );
  }

  Widget _formButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.red.shade800,
                      Colors.red.shade600,
                      Colors.red.shade400,
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () =>
                  _navigateTLocationVisitScreen(context, location.id),
              child: const Text('Visit'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTLocationVisitScreen(BuildContext context, int locationId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationVisitScreen(locationId)),
    );
  }
}
