import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_permit/fonts/fonts.dart';
import 'package:work_permit/globalvarialbles.dart';

class Certificate extends StatelessWidget {
  const Certificate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bodyColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/images/appbar.png',
            width: 161,
            height: 51,
          ),
          centerTitle: true,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/certificate.png"),
                        fit: BoxFit.fill)),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              width: 200,
              height: 37,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: maincolor),
                  onPressed: () {
                    //_saveImage(); // Call the save function when the button is pressed
                  },
                  child: Text(
                    "Download PDF",
                    style: GoogleFonts.secularOne(
                        textStyle: normalstyle,
                        fontSize: 14,
                        color: Colors.white),
                  )),
            )
          ],
        ));
  }
}
