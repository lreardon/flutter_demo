import 'package:json_annotation/json_annotation.dart';
import 'location_fact.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'endpoint.dart';
part 'location.g.dart';

@JsonSerializable()
class Location {
  // The 'final' keyword makes the member immutable.
  final int id;
  final String name;
  final String url;
  final String user_itinerary_summary;
  final String tour_package_name;
  final List<LocationFact> facts;
  // Constructor syntax. Curley braces can be wrapped around arguments to make them optional.
  // The required keyword can be used to make them erquired named arguments.
  // If you want them to be truly optional, you need to make them nullable, by appending their datatype with '?'
  Location(
      {required this.id,
      required this.name,
      required this.url,
      required this.user_itinerary_summary,
      required this.tour_package_name,
      this.facts = const []});

  Location.blank()
      : id = 0,
        name = '',
        url = '',
        user_itinerary_summary = '',
        tour_package_name = '',
        facts = [];

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  static Future<List<Location>> fetchAll() async {
    var uri = Endpoint.uri('/locations');

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw (response.body);
    }

    List<Location> list = [];

    for (var jsonItem in json.decode(response.body)) {
      print(jsonItem);
      list.add(Location.fromJson(jsonItem));
    }

    return list;
  }

  static Future<Location> fetchById(int id) async {
    var uri = Endpoint.uri('/locations/$id');

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw (response.body);
    }

    final Map<String, dynamic> itemMap = json.decode(response.body);

    return Location.fromJson(itemMap);
  }
}
