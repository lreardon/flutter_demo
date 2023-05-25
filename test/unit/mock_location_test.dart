// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_demo/mocks/mock_location.dart';
// import 'package:flutter_demo/models/location.dart';

// void main() {
//   test('fetchAny', () {
//     final mockLocation = MockLocation.fetchAny();
//     expect(mockLocation, isNotNull);
//     expect(mockLocation.name, isNotEmpty);
//     expect(mockLocation.url, isNotEmpty);
//     expect(mockLocation.facts, isList);
//   });

//   test('fetchAll', () {
//     final mockLocations = MockLocation.fetchAll();
//     expect(mockLocations, isList);
//     expect(mockLocations.length, greaterThan(0));
//     expect(
//         mockLocations.first,
//         isA<Location>()
//             .having((location) => location.name, 'name', isA<String>())
//             .having((location) => location.url, 'url', isA<String>())
//             .having((location) => location.facts, 'facts', isList));
//   });
// }
