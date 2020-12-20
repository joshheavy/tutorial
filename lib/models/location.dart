class Location {
  final double lat;
  final double lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> data)
      : lat = data['lat'],
        lng = data['lng'];
}
