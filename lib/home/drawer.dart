import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_permit/home/homepage.dart';
import 'package:work_permit/login/login.dart';
import '../contact_us.dart';
import '../fonts/fonts.dart';
import '../globalvarialbles.dart';
import '../privacy_policy.dart';

class AppDrawer extends StatefulWidget {
  final String name;
  final String pic;
  const AppDrawer({required this.name, required this.pic});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String profilePicture = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      profilePicture = prefs.getString('profilePicture') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        Container(
            child: SizedBox(
          height: 180,
          child: DrawerHeader(
              decoration: BoxDecoration(
                color: maincolor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text('Welcome',
                              style: GoogleFonts.secularOne(
                                  textStyle: normalstyle,
                                  color: Colors.white,
                                  fontSize: 13)),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Container(
                          child: Text(widget.name,
                              style: GoogleFonts.secularOne(
                                  textStyle: normalstyle,
                                  color: Colors.white,
                                  fontSize: 13)),
                        )
                      ]),
                  const SizedBox(
                    height: 4,
                  ),
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: profilePicture.isNotEmpty
                        ? FileImage(File(profilePicture))
                        : null,
                    child: profilePicture.isEmpty
                        ? Icon(
                            Icons.person,
                            size: 40.0,
                          )
                        : null,
                  ),
                ],
              )),
        )),
        ListTile(
          leading: Icon(
            Icons.home,
          ),
          title:
              Text('Home', style: GoogleFonts.josefinSans(textStyle: softbold)),
          onTap: () {
            setState(() {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            });
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.policy_rounded,
          ),
          title: Text('Privacy Policy',
              style: GoogleFonts.josefinSans(textStyle: softbold)),
          onTap: () {
            setState(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicy()));
            });
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.add_call,
          ),
          title: Text('Contact Us',
              style: GoogleFonts.josefinSans(textStyle: softbold)),
          onTap: () {
            setState(() {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Contact()));
            });
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.logout_rounded,
          ),
          title: Text('Logout',
              style: GoogleFonts.josefinSans(textStyle: softbold)),
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            setState(() {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => UserLogin()));
            });
          },
        ),
      ]),
    );
  }
}
