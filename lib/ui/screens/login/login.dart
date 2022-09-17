import 'package:dogventurehq/ui/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.toNamed(HomeScreen.routeName),
          child: const Text('Login'),
        ),
      ),
    );
  }
}
