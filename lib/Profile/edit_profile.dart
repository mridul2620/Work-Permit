import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fonts/fonts.dart';
import '../globalvarialbles.dart';
import '../home/homepage.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String profilePicture = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    occupationController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('name') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      occupationController.text = prefs.getString('occupation') ?? '';
      phoneNumberController.text = prefs.getString('phoneNumber') ?? '';
      addressController.text = prefs.getString('address') ?? '';
      profilePicture = prefs.getString('profilePicture') ?? '';
    });
  }

  Future<void> saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', "Demo");
    prefs.setString('email', "Demo@gmail.com");
    prefs.setString('occupation', "Demo");
    prefs.setString('phoneNumber',"Demo");
    prefs.setString('address', "Demo");
    prefs.setString('profilePicture', profilePicture);
  }

  Future<void> _pickImage(ImageSource source) async {
    final _picker = ImagePicker();
    final image = await _picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        profilePicture = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/appbar.png',
          width: 161,
          height: 51,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                              tileColor: Color.fromARGB(255, 249, 248, 248),
                              onTap: () {
                                _pickImage(ImageSource.camera);
                              },
                              title: Text("Camera"),
                            ),
                            ListTile(
                              tileColor: Color.fromARGB(255, 249, 248, 248),
                              onTap: () {
                                _pickImage(ImageSource.gallery);
                              },
                              title: Text("Gallery"),
                            ),
                          ],
                        );
                      });
                },
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: profilePicture.isNotEmpty
                      ? FileImage(File(profilePicture))
                      : null,
                  child: profilePicture.isEmpty
                      ? const Icon(
                          Icons.camera_alt,
                          size: 40.0,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                //controller: nameController,
                initialValue: "Demo",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null; // Return null for no validation errors
                },
                decoration: InputDecoration(
                    labelText: "Name",
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor, width: 4.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184),
                          width: 2.0),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    labelStyle: GoogleFonts.secularOne(
                        textStyle: normalstyle, fontSize: 15),
                    prefixIcon: const Icon(CupertinoIcons.person_alt),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: "Demo@gmail.com",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null; // Return null for no validation errors
                },
                //controller: emailController,
                decoration: InputDecoration(
                    labelText: "Email",
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor, width: 4.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184),
                          width: 2.0),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    labelStyle: GoogleFonts.secularOne(
                        textStyle: normalstyle, fontSize: 15),
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: "Demo",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your occupation';
                  }
                  return null; // Return null for no validation errors
                },
                //controller: occupationController,
                decoration: InputDecoration(
                    labelText: "Occupation",
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor, width: 4.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184),
                          width: 2.0),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    labelStyle: GoogleFonts.secularOne(
                        textStyle: normalstyle, fontSize: 15),
                    prefixIcon: const Icon(CupertinoIcons.bag_fill),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: "Demo",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your number';
                  }
                  return null; // Return null for no validation errors
                },
                //controller: phoneNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Phone Number",
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor, width: 4.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184),
                          width: 2.0),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    labelStyle: GoogleFonts.secularOne(
                        textStyle: normalstyle, fontSize: 15),
                    prefixIcon: const Icon(CupertinoIcons.phone_fill),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: "Demo",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null; // Return null for no validation errors
                },
                //controller: addressController,
                decoration: InputDecoration(
                    labelText: "City",
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor, width: 4.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184),
                          width: 2.0),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    labelStyle: GoogleFonts.secularOne(
                        textStyle: normalstyle, fontSize: 15),
                    prefixIcon: const Icon(CupertinoIcons.home),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 37,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: maincolor),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        saveUserData();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HomePage())); // Go back to the previous screen
                      }
                    },
                    child: const Text("Save")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
