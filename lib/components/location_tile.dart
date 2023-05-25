import 'package:flutter/material.dart';
import '../models/location.dart';
import '../styles.dart';

class LocationTile extends StatelessWidget {
  final Location location;
  final bool darkTheme;

  LocationTile({required this.location, this.darkTheme = false});

  @override
  Widget build(BuildContext context) {
    final title = this.location.name.toUpperCase();
    final subTitle = this.location.user_itinerary_summary.toUpperCase();
    final location = this.location.tour_package_name.toUpperCase();

    return Container(
        height: Styles.LocationTileHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: this.darkTheme
                  ? Styles.locationTileTitleDark
                  : Styles.locationTileTitleLight,
            ),
            Text(
              subTitle,
              style: Styles.locationTileSubtitle,
            ),
            Text(
              location,
              style: Styles.locationTileLocation,
            )
          ],
        ));
  }
}
