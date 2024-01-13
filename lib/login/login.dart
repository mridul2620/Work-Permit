import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_permit/fonts/fonts.dart';
import 'package:work_permit/globalvarialbles.dart';
import 'package:work_permit/signup/signup.dart';

import 'auth.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/role.png"),
                        fit: BoxFit.fill)),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 45,
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: maincolor, width: 1.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 184, 184, 184),
                                width: 1.0),
                          ),
                          label: Text(
                            "Enter your email",
                            style: GoogleFonts.secularOne(
                                color: maincolor, textStyle: normalstyle),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email cannot be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 45,
                      child: TextFormField(
                        controller: passController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: maincolor, width: 1.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 184, 184, 184),
                                  width: 1.0),
                            ),
                            label: Text(
                              "Enter your password",
                              style: GoogleFonts.secularOne(
                                  color: maincolor, textStyle: normalstyle),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText =
                                      !_obscureText; // Toggle the visibility of the password
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: maincolor,
                              ),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 37,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: maincolor),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _authService.login(
                            emailController.text.toString(),
                            passController.text.toString(),
                            context);
                      }
                    },
                    child: Text("Login",
                        style: GoogleFonts.secularOne(
                            textStyle: normalstyle,
                            fontSize: 18,
                            color: Colors.white))),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  child: Row(
                    children: [
                      Text("New User?",
                          style: GoogleFonts.poppins(
                              textStyle: normalstyle,
                              fontSize: 13,
                              color: Colors.black)),
                      const SizedBox(
                        width: 2,
                      ),
                      Container(
                        width: 100,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                          },
                          child: Text("Register now.",
                              style: GoogleFonts.secularOne(
                                  textStyle: normalstyle,
                                  decoration: TextDecoration.underline,
                                  fontSize: 13,
                                  color: Colors.black)),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
