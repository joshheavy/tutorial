import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:leta_sasa/helpers/screen_navigation.dart';
import 'package:leta_sasa/screens/Authentication/register.dart';
import 'package:leta_sasa/screens/shop_screen.dart';
import 'package:leta_sasa/utils/app_colors.dart';
import 'package:splashscreen/splashscreen.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 14,
      navigateAfterSeconds: RegisterPage(),
      title: Text(
        'LETASASa',
        style: TextStyle(
          fontWeight: FontWeight.bold, 
          color: AppColors.textColor,
          fontSize: 30,
        ),
      ),
      backgroundColor: AppColors.appBar2Color,
      loaderColor: Colors.blue,
    );
  }
}
// class IntroScreen extends StatelessWidget {
//   IntroScreen({Key key}) : super(key: key);
//   final pages = [
//     PageViewModel(
//         // pageColor: const Color(0xFF03A9F4),
//         pageColor: AppColors.scaffoldColor,
//         // iconImageAssetPath: 'assets/air-hostess.png',
//         bubble: Image.asset('assets/images/location.png'),
//         body: Text(
//           'Browse the menu and order directly from the application',
//         ),
//         title: Text(
//           'Tracking Realtime',
//         ),
//         titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
//         bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
//         mainImage: Image.asset(
//           'assets/images/location.png',
//           height: 285.0,
//           width: 285.0,
//           alignment: Alignment.center,
//         )),
//     PageViewModel(
//       pageColor: const Color(0xFF8BC34A),
//       iconImageAssetPath: 'assets/images/online-shopping.png',
//       body: Text(
//         'Your order will be immediately collected and delivered',
//       ),
//       title: Text('Order'),
//       mainImage: Image.asset(
//         'assets/images/online-shopping.png',
//         height: 285.0,
//         width: 285.0,
//         alignment: Alignment.center,
//       ),
//       titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
//       bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
//     ),
//     PageViewModel(
//       // pageColor: const Color(0xFF607D8B),
//       pageColor: AppColors.appBar2Color,
//       iconImageAssetPath: 'assets/images/order-food.png',
//       body: Text(
//         'Pick up delivery at your door and enjoy groceries',
//       ),
//       title: Text('Shopping Request'),
//       mainImage: Image.asset(
//         'assets/images/order-food.png',
//         height: 285.0,
//         width: 285.0,
//         alignment: Alignment.center,
//       ),
//       titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
//       bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
//     ),
//     PageViewModel(
//       pageColor: const Color(0xFF607D8B),
//       iconImageAssetPath: 'assets/images/place.png',
//       body: Text(
//         'Choose your location to start find the request around you',
//       ),
//       title: Text('Enable your Location'),
//       mainImage: Image.asset(
//         'assets/images/place.png',
//         height: 285.0,
//         width: 285.0,
//         alignment: Alignment.center,
//       ),
//       titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
//       bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (context) => IntroViewsFlutter(
//         pages,
//         showBackButton: true,
//         showNextButton: true,
//         onTapDoneButton: () {
//           showCupertinoDialog(
//               context: context,
//               builder: (context) => CupertinoActionSheet(
//                     actions: [
//                       CupertinoActionSheetAction(
//                           onPressed: () {
//                             ChangeScreen(context, AuthenticationScreen());
//                           },
//                           child: Text("Login")),
//                       CupertinoActionSheetAction(
//                           onPressed: () {
//                             ChangeScreen(context, AddShopScreen());
//                           },
//                           child: Text("Add shop")),
//                     ],
//                   ));
//         },
//       ),
//     );
//   }
// }
