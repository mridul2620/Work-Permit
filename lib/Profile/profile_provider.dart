import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_permit/globalvarialbles.dart';
import 'package:http/http.dart' as http;
import '../fonts/fonts.dart';
import '../home/homepage.dart';

class DemoProfileProvider extends ChangeNotifier {
  TextEditingController alternateMobController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  bool loader = false;

  Future<void> sendQuery(BuildContext context, String name, String mobile,
      String email, String address) async {
    loader = true;
    notifyListeners();
    String api = baseAPI + sendQueryAPI;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "mobile": mobile,
      "address": address,
      "alternate_mobile": alternateMobController.text,
      "comment": commentController.text,
    };
    try {
      final response = await http.post(
        Uri.parse(api),
        headers: headers,
        body: data,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        loader = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: maincolor,
          showCloseIcon: true,
          closeIconColor: Colors.white,
          content: Text(
            'Your query has been sent successfully. Our sales tean will connect with you shortly.',
            style: GoogleFonts.secularOne(textStyle: normalstyle, fontSize: 13),
          ),
          duration: const Duration(seconds: 5),
        ));
        await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        notifyListeners();
      } else {
        final responseData = json.decode(response.body);
        loader = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 145, 10, 0),
          showCloseIcon: true,
          closeIconColor: Colors.white,
          content: Text(
            responseData['message'],
            style: GoogleFonts.secularOne(textStyle: normalstyle, fontSize: 13),
          ),
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      loader = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 145, 10, 0),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        content: Text(
          "Data not sent. Try again please.",
          style: GoogleFonts.secularOne(textStyle: normalstyle, fontSize: 13),
        ),
        duration: const Duration(seconds: 3),
      ));
      notifyListeners();
      print(e);
    }
  }
}
