import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:work_permit/fonts/fonts.dart';
import 'package:work_permit/home/homepage.dart';
import 'dart:convert';
import '../globalvarialbles.dart';

class AuthService {
  String api = baseAPI + "login";
  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      Response response = await post(
        Uri.parse(api),
        body: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> output = json.decode(response.body);
        int userId = output['data']['id'] ?? 0;
        int parentId = output['data']['parent_id'];
        String accessToken = output['access_token'] ?? "";
        String firstName = output['data']['name'] ?? "";
        String gender = output['data']['gender'] ?? "";
        String email = output['data']['email'] ?? "";
        String mobile = output['data']['mobile'] ?? '';
        String occupation = output['data']['occupation'] ?? "";
        String address = output['data']['address'] ?? "";
        String profileImage = output['data']['image'] ?? "";
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('id', userId);
        prefs.setString('access_token', accessToken);
        prefs.setInt('parent_id', parentId);
        prefs.setString('name', firstName);
        prefs.setString('gender', gender);
        prefs.setString('email', email);
        prefs.setString('mobile', mobile);
        prefs.setString('occupation', occupation);
        prefs.setString('address', address);
        prefs.setString('image', profileImage);
        // ignore: use_build_context_synchronously
        moveToHome(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: maincolor,
          content: Text(
            'Login failed. Please check your credentials.',
            style: GoogleFonts.secularOne(textStyle: normalstyle, fontSize: 13),
          ),
          duration: const Duration(seconds: 3),
        ));
      }
      // ignore: empty_catches
    } catch (e) {
      print(e);
      print('error');
    }
  }

  moveToHome(BuildContext context) async {
    // ignore: use_build_context_synchronously
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
