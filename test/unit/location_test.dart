import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_demo/models/location.dart';

void main() {
  test('location serialization', () async {
    final locations = await Location.fetchAll();

    for (var location in locations) {
      expect(location, isA<Location>());
      expect(location.name,
          isA<String>().having((l) => l.length, 'length', greaterThan(0)));
      expect(location.url,
          isA<String>().having((l) => l.length, 'length', greaterThan(0)));
    }
  });
}
