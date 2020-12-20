import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CustomMap extends StatelessWidget {
  final Position position;
  final name;

  const CustomMap({Key key, this.position, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    return Scaffold(
      body:(currentPosition != null) ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height/1.5,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(position.latitude,position.longitude,),
                zoom: 12.0,
              ),
              markers: {
                Marker(
                  infoWindow: InfoWindow(
                    title: name,
                  ),
                  markerId: MarkerId("marker"),
                  position: LatLng(position.latitude,position.longitude,),
                )
              },
              zoomGesturesEnabled: true,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 100,
            width: MediaQuery.of(context).size.width/2,
            color: Colors.blue
          )
        ],
      ) : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
