import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:leta_sasa/helpers/screen_navigation.dart';
import 'package:leta_sasa/screens/mapping.dart';
import 'package:leta_sasa/utils/app_colors.dart';
import 'package:flutter_rating/flutter_rating.dart';

class DetailCard extends StatelessWidget {
  final String title;
  final Position position;
  final String distance;
  // final String ratings;
  const DetailCard({
    Key key,
    @required this.title,
    @required this.distance, this.position,
    // @required this.ratings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ChangeScreen(context, CustomMap(name: title,position: position,));
      },
      child: Container(
        height: 200,
        margin: EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(20.0)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                distance,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Ratings()
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Ratings extends StatefulWidget {
  
  @override
  _RatingsState createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  double rating = 4.0;
  int starCount = 5;
  @override
  Widget build(BuildContext context) {
    return StarRating(
      size: 20.0,
      rating: rating,
      color: Colors.amber,
      borderColor: Colors.grey,
      starCount: starCount,
      onRatingChanged: (rating) {
        setState(() {
          this.rating = rating;
        });
      },
    );
  }
}
