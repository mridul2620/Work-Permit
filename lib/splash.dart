import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_permit/home/homepage.dart';
import 'package:work_permit/login/login.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkTokenAndNavigate();
  }

  late SharedPreferences prefs;
Future<void> checkTokenAndNavigate() async {
    prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

    Future.delayed(const Duration(seconds: 2), () {
      if (accessToken != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UserLogin(),
          ),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage("assets/images/splash.png"), fit: BoxFit.fill)),
      ),
    );
  }
}
