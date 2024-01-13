import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_permit/fonts/fonts.dart';
import 'globalvarialbles.dart';
import 'login/login.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,

                      // color: const Color.fromARGB(255, 186, 20, 8),
                      child: Card(
                        elevation: 4,
                        color: const Color.fromARGB(255, 186, 20, 8),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/cancel.png"),
                                          fit: BoxFit.fill)),
                                ),
                                Text(
                                  "Your trial peried has been expired. Please contact to admin",
                                  style: GoogleFonts.secularOne(
                                      textStyle: normalstyle,
                                      fontSize: 13,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 37,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: maincolor,
                    ),
                    child: Center(
                      child: GestureDetector(
                          onTap: () {
                            _logout();
                          },
                          child: Text(
                            "Logout",
                            style: GoogleFonts.secularOne(
                                textStyle: normalstyle,
                                fontSize: 13,
                                color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
          //    Container(
          //     alignment: Alignment.center,
          //     child: Column(
          //       children: [
          //         Container(
          //           height: 150,
          //           width: 150,
          //           decoration: BoxDecoration(
          //               image: DecorationImage(
          //                   image: AssetImage("assets/images/appbar.png"),
          //                   fit: BoxFit.fill)),
          //         ),
          //         const SizedBox(
          //           height: 10,
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 16),
          //           child: Text(
          //               "Your trial peried has been expired. Please contact to admin"),
          //         ),
          //         const SizedBox(
          //           height: 10,
          //         ),
          //         Container(
          //           height: 37,
          //           width: MediaQuery.of(context).size.width,
          //           child: ElevatedButton(
          //               style: ElevatedButton.styleFrom(backgroundColor: maincolor),
          //               onPressed: () {
          //                 _logout();
          //                 // Go back to the previous screen
          //               },
          //               child: const Text("Logout")),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ));
  }
}
