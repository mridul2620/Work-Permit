import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';
import 'package:work_permit/globalvarialbles.dart';

class Contact extends StatelessWidget {
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
      ),
      backgroundColor: bodyColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0), 
        child: ContactUs(
          textColor: Colors.teal,
          companyColor: Colors.white,
          cardColor: Colors.white,
          taglineColor: Colors.white,
          logo: AssetImage('assets/images/safety_logo.jpg'),
          email: 'rohitsharma@safetycircleindia.com',
          companyName: 'Safety Circle',
          //phoneNumberText: '9793711706',
          phoneNumber: '+918708671727', 
          dividerThickness: 2,
          website: 'https://safetycircleindia.com/',
          //tagLine: 'Developers',
        ),
      ),
    );
  }
}
