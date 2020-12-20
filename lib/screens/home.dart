import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leta_sasa/utils/app_colors.dart';
import 'package:leta_sasa/widgets/home_card.dart';
import 'package:leta_sasa/widgets/custom_drawer.dart';

class MyHomePage extends StatelessWidget {
  final UserCredential user;

  const MyHomePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBarColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.appBar2Color,
        title: Text(
          'LETASASa',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeCard(icon: FontAwesomeIcons.cocktail, text: 'Drinks',value:'Drinks' ,),
            HomeCard(icon: FontAwesomeIcons.leaf, text: 'Miraa',value:'Miraa' ,),
            HomeCard(icon: FontAwesomeIcons.shoppingBag, text: 'Food & Grocery',value:'Food & Grocery'),
          ],
        ),
      ),
    );
  }
}
