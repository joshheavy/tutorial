import 'package:leta_sasa/models/places.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

enum Places { drinks, miraa, food }

class PlacesService {
  final key = 'AIzaSyCZ6DuY-9_eCJ9HxPSS9W7lFUgaMpbnbhs';

  // Future getPlaces(double lat, double lng) {
  //   var response = http.get(
  //       'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=drinks&rankby=distance&key=$key');
  //   var json = convert.jsonDecode(response.body);
  // }
}
