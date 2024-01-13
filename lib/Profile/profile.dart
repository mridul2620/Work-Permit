import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_permit/Profile/edit_profile.dart';
import 'package:work_permit/login/login.dart';
// import 'package:work_permit/roles.dart';

import '../globalvarialbles.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String profilePicture = '';
  String name = '';
  String email = '';
  String address = '';
  String occupation = "";
  String number = '';

  @override
  void initState() {
    super.initState();
    // Load user data from SharedPreferences
    loadUserData();
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to the login page (replace with your login page route)
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const UserLogin(), // Replace with your login page
      ),
    );
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      profilePicture = prefs.getString('profilePicture') ?? '';
      name = prefs.getString('name') ?? '';
      email = prefs.getString('email') ?? '';
      address = prefs.getString('address') ?? '';
      occupation = prefs.getString('occupation') ?? '';
      number = prefs.getString('mobile') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage: profilePicture.isNotEmpty
                          ? FileImage(File(profilePicture))
                          : null,
                      child: profilePicture.isEmpty
                          ? Icon(
                              Icons.camera_alt,
                              size: 40.0,
                            )
                          : null,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Card(
                child: ListTile(
                  title: Text('Name'),
                  subtitle: Text(name),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Email'),
                  subtitle: Text(email),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Number'),
                  subtitle: Text(number),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Ocuupation'),
                  subtitle: Text(occupation),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Address'),
                  subtitle: Text(address),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 37,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: maincolor),
                    onPressed: () {
                      _logout();
                      // Go back to the previous screen
                    },
                    child: const Text("Logout")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
