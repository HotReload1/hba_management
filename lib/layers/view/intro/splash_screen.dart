import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hba_management/core/configuration/assets.dart';
import 'package:hba_management/layers/view/auth/login_screen.dart';
import 'package:hba_management/layers/view/home_page.dart';

import '../../../core/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  getData() {
    Future.delayed(Duration(seconds: 3), () {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => MyHomePage()),
            (route) => false); //home page
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => LoginScreen()),
            (route) => false); //login
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation = ColorTween(begin: Colors.blue.shade400, end: Colors.white)
        .animate(_animationController);
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: _animation.value,
        body: Center(
          child: Image.asset(AssetsLink.appLogo),
        ));
  }
}
