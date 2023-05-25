import 'dart:async';
import 'package:flutter/material.dart';
import '../components/location_tile.dart';
import '../location_detail.dart';
import '../styles.dart';
import 'location.dart';

class LocationList extends StatefulWidget {
  @override
  createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  List<Location> locations = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Locations', style: Styles.navBarStyle),
          backgroundColor: Colors.red,
        ),
        body: RefreshIndicator(
          onRefresh: loadData,
          color: Colors.red.shade300,
          child: Column(children: [
            _progressBar(context),
            Expanded(child: _listView(context))
          ]),
        ));
  }

  Future<void> loadData() async {
    if (mounted) {
      setState(() => this.loading = true);
      // Simulating a slow connection to show the progress bar
      Timer(Duration(seconds: 1), () async {
        final locations = await Location.fetchAll();
        setState(() {
          this.locations = locations;
          this.loading = false;
        });
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

  Widget _listView(context) {
    return ListView.builder(
        itemCount: locations.length, itemBuilder: _locationListItemBuilder);
  }

  Widget _itemTitle(BuildContext context, Location location) {
    return Text('${location.name}', style: Styles.textDefault);
  }

  void _navigateToLocationDetail(BuildContext context, int locationId) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationDetail(locationId),
        ));
  }

  Widget _locationListItemBuilder(BuildContext context, int index) {
    final location = this.locations[index];
    return GestureDetector(
        onTap: () => _navigateToLocationDetail(context, location.id),
        child: Container(
            height: Styles.ListItemHeight,
            child: Stack(children: [
              _tileImage(location.url, MediaQuery.of(context).size.width,
                  Styles.ListItemHeight),
              _tileFooter(location)
            ])));
  }

  Widget _tileImage(String url, double width, double height) {
    Image? image;
    try {
      image = Image.network(url, fit: BoxFit.cover);
    } catch (e) {
      print("Could not load image from url $url");
    }
    return Container(constraints: const BoxConstraints.expand(), child: image);
  }

  Widget _tileFooter(Location location) {
    final info = LocationTile(location: location, darkTheme: true);
    final overlay = Container(
        height: Styles.LocationTileHeight,
        padding: EdgeInsets.symmetric(
            vertical: 5.0, horizontal: Styles.HorizontalPaddingDefault),
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.50)),
        child: info);
    return Column(
        mainAxisAlignment: MainAxisAlignment.end, children: [overlay]);
  }
}
