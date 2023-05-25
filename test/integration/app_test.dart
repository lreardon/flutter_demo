// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:network_image_mock/network_image_mock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_demo/models/location.dart';
import 'package:flutter_demo/app.dart';

void main() {
  testWidgets('App startup', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(App());

      final mockLocation = await Location.fetchById(0);

      expect(find.text(mockLocation.name), findsWidgets);
      expect(find.text('${mockLocation.name}-not-present'), findsNothing);
    });
  });
}
