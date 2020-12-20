import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:leta_sasa/services/geolocator_service.dart';
import 'package:leta_sasa/utils/app_colors.dart';
import 'package:leta_sasa/widgets/detail_card.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DetailsPage extends StatelessWidget {
  final value;
  final Position position;
  const DetailsPage({Key key, this.value, this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.anotherColor,
        appBar: AppBar(
          backgroundColor: AppColors.anotherColor,
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...'
              ),
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('shops')
          .where('service_type', isEqualTo: value)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CupertinoActivityIndicator(),
            );
          default:
            return ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
              return DetailCard(
                position: position,
                  title: document['shop_name'],
                  distance: Geolocator.distanceBetween(
                          position.latitude,
                          position.longitude,
                          document['latitude'],
                          document['longitude'])
                      .roundToDouble().toString());
            }).toList());
        }
      },
    ));
  }
}
