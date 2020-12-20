import 'package:leta_sasa/models/location.dart';

class Geometry {
  final Location location;

  Geometry({this.location});

  Geometry.fromJson(Map<String, dynamic> data)
      : location = Location.fromJson(data['location']);
}
