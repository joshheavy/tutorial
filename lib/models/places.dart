import 'package:leta_sasa/models/geometry.dart';
import 'package:leta_sasa/models/openhours.dart';

class Places {
  final Geometry geometry;
  final String name;
  final String vicinity;
  final Open isOpen;

  Places({this.geometry, this.name, this.vicinity, this.isOpen});

  Places.fromJson(Map<String, dynamic> data)
      : geometry = data['geometry'],
        name = data['name'],
        vicinity = data['vicinity'],
        isOpen = data['isOpen'];
}
