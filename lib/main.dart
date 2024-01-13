import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:work_permit/Profile/profile_provider.dart';
import 'package:work_permit/Status/status_provider.dart';
import 'package:work_permit/permit_form/form_provider.dart';
import 'package:work_permit/signup/signup_provider.dart';
import 'package:work_permit/splash.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FormStateProvider>(
          create: (_) => FormStateProvider(),
        ),
        ChangeNotifierProvider<StatusProvider>(create: (_) => StatusProvider()),
        ChangeNotifierProvider<SignUpProvider>(create: (_) => SignUpProvider()),
        ChangeNotifierProvider<DemoProfileProvider>(create: (_) => DemoProfileProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
