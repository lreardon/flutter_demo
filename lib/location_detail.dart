// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'models/location.dart';
import 'models/location_fact.dart';
import 'styles.dart';

class LocationDetail extends StatefulWidget {
  final int _locationId;
  LocationDetail(this._locationId);

  @override
  State<StatefulWidget> createState() => _LocationDetailState(_locationId);
}

class _LocationDetailState extends State<LocationDetail> {
  final int _locationId;
  bool loading = false;

  Location location = Location.blank();

  _LocationDetailState(this._locationId);

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
            child: CustomScrollView(slivers: [
              SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _renderBody(context, location)))
            ])));
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

  List<Widget> _renderBody(BuildContext context, Location location) {
    List<Widget> result = [];

    result.add(_progressBar(context));
    result.add(_bannerImage(location.url, 170.0));
    result.addAll(_factsList(context, location));
    return result;
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
          )),
      Container(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child:
              Text(text, textAlign: TextAlign.left, style: Styles.textDefault))
    ]);
  }

  List<Widget> _factsList(BuildContext context, Location location) {
    List<Widget> renderedFacts = [];

    for (int i = 0; i < location.facts.length; i++) {
      LocationFact fact = location.facts[i];
      renderedFacts.add(_fact(fact.title, fact.text));
    }
    return renderedFacts;
  }

  Widget _bannerImage(String url, double height) {
    Image? image;
    try {
      if (url.isNotEmpty) {
        image = Image.network(url, fit: BoxFit.fitWidth);
      }
    } catch (e) {
      print("Could not load image url ${url}");
    }
    return Container(
        // Constraints can be used to enforce container sizing, though we don't this constraint for this image.
        // constraints: BoxConstraints.tightFor(height: height),
        child: image);
  }
}
