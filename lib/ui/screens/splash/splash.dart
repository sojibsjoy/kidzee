import 'package:dogventurehq/states/data/prefs.dart';
import 'package:dogventurehq/ui/screens/home/home.dart';
import 'package:dogventurehq/ui/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigating();
  }

  void navigating() async {
    // remove this ! sign to make it normal
    if (!Preference.getLoggedInFlag()) {
      Future.delayed(
        const Duration(seconds: 2),
        () => Get.toNamed(HomeScreen.routeName),
      );
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () => Get.toNamed(LoginScreen.routeName),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
