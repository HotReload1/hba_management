import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hba_management/core/app/state/app_state.dart';
import 'package:hba_management/core/configuration/styles.dart';
import 'package:hba_management/core/routing/route_path.dart';
import 'package:hba_management/layers/data/model/user_model.dart';
import 'package:hba_management/layers/view/hotel/hotels.dart';
import 'package:provider/provider.dart';

import '../../../injection_container.dart';

class CustomDrawer extends StatefulWidget {
  static int selectedTab = 0;
  static int previousTab = 0;
  CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  showAlertDialog(Function function) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "YES",
        style: TextStyle(color: Colors.green),
      ),
      onPressed: () {
        function();
      },
    );

    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        CustomDrawer.selectedTab = CustomDrawer.previousTab;
        setState(() {});
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      content: const Text("Are you sure that you want to logout ?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _buildDrawerOption(Icon icon, String title, VoidCallback onTap, int index) {
    return Container(
      color: CustomDrawer.selectedTab == index
          ? Styles.colorPrimary.withOpacity(0.2)
          : Colors.transparent,
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
        onTap: () {
          print(index);
          if (index == 2) {
            onTap();
          } else if (CustomDrawer.selectedTab == index) {
            Navigator.of(context).pop();
          } else {
            CustomDrawer.previousTab = CustomDrawer.selectedTab;
            CustomDrawer.selectedTab = index;
            onTap();
            setState(() {});
          }
        },
      ),
    );
  }

  signOut(BuildContext context) async {
    await Future.wait(
        [FirebaseAuth.instance.signOut(), sl.reset(dispose: false)]);
    initInjection();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(RoutePaths.LogIn, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    UserModel currentUser =
        Provider.of<AppState>(context, listen: false).userModel!;
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Styles.colorPrimary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${currentUser.userName}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    currentUser.email!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    currentUser.phoneNumber!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildDrawerOption(
                          const Icon(Icons.home),
                          'Hotels',
                          () => Navigator.of(context)
                              .pushReplacementNamed(RoutePaths.HotelsScreen),
                          0),
                      _buildDrawerOption(
                          const Icon(Icons.person),
                          'Hotel Managers',
                          () => Navigator.of(context).pushReplacementNamed(
                              RoutePaths.HotelManagersScreen),
                          1),
                    ],
                  ),
                ),
                _buildDrawerOption(const Icon(Icons.logout), 'Logout', () {
                  setState(() {
                    showAlertDialog(() => signOut(context));
                  });
                }, 2),
              ],
            ),
          )
        ],
      ),
    );
  }
}
