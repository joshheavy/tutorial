import 'package:flutter/material.dart';
import 'package:leta_sasa/utils/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leta_sasa/services/auth_service.dart';
import 'package:leta_sasa/helpers/screen_navigation.dart';
import 'package:leta_sasa/screens/Authentication/authentication.dart';
import 'package:leta_sasa/screens/shop_screen.dart';


class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        width: 230,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  AppColors.appBarColor,
                  AppColors.textColor,
                ]),
              ),
              child: CircleAvatar(
                radius: 30,
              ),
            ),
            BuildListTile(
              icon: Icons.storefront,
              title: 'Add your shop',
              onTap: () {
                ChangeScreen(context, AddShopScreen());
              },
            ),
            BuildListTile(
              icon: Icons.add_location,
              title: 'Your location',
              onTap: () {},
            ),
            BuildListTile(
              icon: Icons.account_circle,
              title: 'Account',
              onTap: () {},
            ),
            BuildListTile(
              icon: FontAwesomeIcons.shoppingBag,
              title: 'Orders',
              onTap: () {},
            ),
            SizedBox(
              height: 600,
            ),
            BuildListTile(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () async {
                await AuthService().signOut().then(
                    (value) => ChangeScreen(context, AuthenticationScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}

class BuildListTile extends StatelessWidget {
  BuildListTile({Key key, this.icon, this.title, this.onTap}) : super(key: key);

  IconData icon;
  String title;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      onTap: onTap,
    );
  }
}
