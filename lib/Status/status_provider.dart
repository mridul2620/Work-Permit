import 'dart:convert';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_permit/Status/extension_model.dart';
import 'package:work_permit/Status/permit_model.dart';
import 'package:work_permit/Status/status_model.dart';
import 'package:work_permit/globalvarialbles.dart';
import 'package:work_permit/home/homepage.dart';

class StatusProvider extends ChangeNotifier {
  List<StatusModel> status = [];
  late SharedPreferences _prefs;
  bool isLoading = true;
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  Future<void> fetchData() async {
    _prefs = await SharedPreferences.getInstance();
    String? accessToken = _prefs.getString('access_token');
    const apiUrl = baseAPI + sendPermit;

    try {
      final response = await http.get(Uri.parse(apiUrl),
          headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['data'];

        // Create a list of CategoryItem objects from the API data
        final statusList = List<StatusModel>.from(data.map((item) {
          return StatusModel(
            id: item['id'] ?? "",
            title: item['title'] ?? "",
            status: item['status'] ?? "",
            selfieImage: item['selfie_image'] ?? "",
          );
        }));
        status = statusList;
        isLoading = false;
        notifyListeners();
      } else {
        // Handle errors if the API request fails
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

    Future<ExtensionModel> fetchExtensionStatus(int id) async {
    _prefs = await SharedPreferences.getInstance();
    String? accessToken = _prefs.getString('access_token');
    final apiUrl = baseAPI + sendPermit + "-details/" + id.toString();
    try {
      final response = await http.get(Uri.parse(apiUrl),
          headers: {'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200) {
        return ExtensionModel.fromJson(jsonDecode(response.body)['extension']);
      } else {
        print("Failed");
        throw Exception('Failed to load incident');
      }
    } catch (e) {
      throw Exception('Error Occured here');
    }
  }

  Future<PermitModel> fetchStatus(int id) async {
    _prefs = await SharedPreferences.getInstance();
    String? accessToken = _prefs.getString('access_token');
    final apiUrl = baseAPI + sendPermit + "-details/" + id.toString();
    try {
      final response = await http.get(Uri.parse(apiUrl),
          headers: {'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200) {
        return PermitModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        print("Failed");
        throw Exception('Failed to load incident');
      }
    } catch (e) {
      throw Exception('Error Occured here');
    }
  }

  Color statusColor(String status) {
    if (status == 'approved') {
      return const Color.fromARGB(255, 110, 170, 113);
    } else if (status == 'pending'|| status=='extension') {
      return yellowColor;
    } else if (status == "declined") {
      return const Color.fromARGB(255, 181, 61, 59);
    } else {
      return maincolor;
    }
  }

  Future<void> updateStatus(
      String newStatus, int id, BuildContext context) async {
    _prefs = await SharedPreferences.getInstance();
    String? accessToken = _prefs.getString('access_token');
    final apiUrl = baseAPI + statusUpdateAPI;
    print(apiUrl);
    print(id);
    print(newStatus);

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Authorization': 'Bearer $accessToken'},
      body: {"status": newStatus, "permit_id": id.toString()},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: maincolor,
        content: Text(
          'Status Updated Successfully',
          style: GoogleFonts.secularOne(fontSize: 13),
        ),
        duration: const Duration(seconds: 3),
      ));
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: maincolor,
        content: Text(
          'Failed to update the status',
          style: GoogleFonts.secularOne(fontSize: 13),
        ),
        duration: const Duration(seconds: 3),
      ));
      throw Exception('Failed to load incident');
    }
  }
}
