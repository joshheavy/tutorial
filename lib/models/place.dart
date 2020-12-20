import 'package:leta_sasa/models/geometry.dart';

class Place {
  final String name;
  final double rating;
  final Geometry geometry;

  Place({this.name, this.rating, this.geometry});

  Place.fromJson(Map<String, dynamic> data)
      : name = data['name'],
        rating = (data['rating'] != null) ? data['rating'].toDouble() : null,
        geometry = data['geometry'];
}
