import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:leta_sasa/models/place.dart';

class PlaceService {
  final key = 'AIzaSyCZ6DuY-9_eCJ9HxPSS9W7lFUgaMpbnbhs';

  Future getPlace(String name) async {
    var response = await http.get(
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$name&inputtype=textquery&fields=photos,formatted_address,name,rating,opening_hours,geometry&key=$key');
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['candidates'];
    var place = Place.fromJson(jsonResults);
    return place;
  }
}
