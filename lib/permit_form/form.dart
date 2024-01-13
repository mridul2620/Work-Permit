// ignore_for_file: unused_field
import 'dart:io';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_permit/globalvarialbles.dart';
import 'package:work_permit/permit_form/form_provider.dart';
import '../fonts/fonts.dart';
import '../home/homepage.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class FormPage extends StatefulWidget {
  final String permitType;
  final int permitId;
  const FormPage({Key? key, required this.permitType, required this.permitId})
      : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState(permitId: permitId);
}

class _FormPageState extends State<FormPage> with TickerProviderStateMixin {
  final int permitId;
  _FormPageState({required this.permitId});
  List<AnimationController>? controllers;
  List<Animation<Offset>>? offsetAnimations;
  LiquidController liquidController = LiquidController();
  bool isSecondPage = false;
  bool animationsStarted = false;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    final formProvider = Provider.of<FormStateProvider>(context, listen: false);
    await formProvider.getCurrentDateTime();
    await formProvider.getCurrentLocation();
    await formProvider.loadUserData();
    await formProvider.fetchQues(permitId);
    final questions = formProvider.questionList;
    //print(questions.length);

    controllers = List.generate(
      questions.length,
      (index) => AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      ),
    );

    offsetAnimations = List.generate(
      questions.length,
      (index) => Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(
        CurvedAnimation(
          parent: controllers![index],
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  void startAnimation() {
    final formProvider = Provider.of<FormStateProvider>(context);
    final questions = formProvider.questionList;

    for (int i = 0; i < questions.length; i++) {
      Future.delayed(Duration(milliseconds: i * 300), () {
        controllers![i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in controllers!) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormStateProvider>(context);
    File? _selfieImage = formProvider.selfieImage;
    File? _certificate = formProvider.certificate;
    String name = formProvider.name;
    bool isLoading = formProvider.isLoading;
    String email = formProvider.email;
    String number = formProvider.number;
    bool _dataLoad = formProvider.dataLoad;
    TextEditingController _title = formProvider.title;
    TextEditingController _desc = formProvider.desc;
    bool selfie = formProvider.selfie;
    bool exp = formProvider.experience;
    final validTitle = _title.text.isNotEmpty;
    final validDesc = _desc.text.isNotEmpty;
    final validloc = formProvider.locationController.text.isNotEmpty;
    final validstartDate = formProvider.startDateController.text.isNotEmpty;
    final validendDate = formProvider.endDateController.text.isNotEmpty;
    final questions = formProvider.questionList;
    List<Map<String, dynamic>> answersList = [];
    if (isSecondPage && !animationsStarted) {
      startAnimation();
      animationsStarted = true;
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.permitType + " Form",
            style: GoogleFonts.secularOne(
                textStyle: normalstyle, fontSize: 15, color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              formProvider.resetValues();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: maincolor,
                  valueColor: AlwaysStoppedAnimation(
                      Color.fromARGB(255, 220, 216, 216)),
                  strokeWidth: 5,
                ),
              )
            : LiquidSwipe(
                enableLoop: true,
                fullTransitionValue: 600,
                onPageChangeCallback: (page) {
                  setState(() {
                    isSecondPage = page == 1; // Check if it's the second page
                    if (!isSecondPage) {
                      // When returning to the first page, reset animations
                      animationsStarted = false;
                    }
                  });
                },
                slideIconWidget: Container(
                  width: 25,
                  height: 75,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/swipe_icon.png"),
                          fit: BoxFit.fill)),
                ),
                waveType: WaveType.liquidReveal,
                positionSlideIcon: 0.5,
                pages: [
                  Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.fast),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Permit Holder Name",
                                style: GoogleFonts.secularOne(
                                    textStyle: normalstyle,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  enabled: false,
                                  initialValue: name,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, textStyle: normalstyle),
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: maincolor, width: 4.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 184, 184, 184),
                                            width: 2.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                      labelStyle: GoogleFonts.secularOne(
                                          textStyle: normalstyle, fontSize: 15),
                                      //labelText: "Name",
                                      // prefixIcon:
                                      //     const Icon(CupertinoIcons.person_alt),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Permit Type",
                                style: GoogleFonts.secularOne(
                                    textStyle: normalstyle,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  enabled: false,
                                  initialValue: widget.permitType,
                                  style: GoogleFonts.secularOne(
                                      fontSize: 15, textStyle: normalstyle),
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: maincolor, width: 4.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 184, 184, 184),
                                            width: 2.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                      labelStyle: GoogleFonts.poppins(
                                          textStyle: normalstyle, fontSize: 15),
                                      //labelText: "Permit Type",
                                      // prefixIcon:
                                      //     const Icon(CupertinoIcons.doc_fill),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Email",
                                style: GoogleFonts.secularOne(
                                    textStyle: normalstyle,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  enabled: false,
                                  initialValue: email,
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: maincolor, width: 1.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 184, 184, 184),
                                            width: 1.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                      labelStyle: GoogleFonts.secularOne(
                                          textStyle: normalstyle, fontSize: 15),
                                      //labelText: "Email",
                                      // prefixIcon:
                                      //     Icon(CupertinoIcons.mail_solid),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Phone Number",
                                style: GoogleFonts.secularOne(
                                    textStyle: normalstyle,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  enabled: false,
                                  initialValue: number,
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: maincolor, width: 1.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 184, 184, 184),
                                            width: 1.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                      // labelStyle: GoogleFonts.secularOne(
                                      //     textStyle: normalstyle, fontSize: 15),
                                      // labelText: "Phone Number",
                                      // prefixIcon:
                                      //     Icon(CupertinoIcons.phone_fill),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Contractor Name",
                                style: GoogleFonts.secularOne(
                                    textStyle: normalstyle,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: formProvider.contractorName,
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: maincolor, width: 1.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 184, 184, 184),
                                            width: 1.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                      // labelStyle: GoogleFonts.secularOne(
                                      //     textStyle: normalstyle, fontSize: 15),
                                      // labelText: "Title",
                                      // prefixIcon: Icon(CupertinoIcons.pin_fill),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Location of Work",
                                style: GoogleFonts.secularOne(
                                    textStyle: normalstyle,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: formProvider.locationController,
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: maincolor, width: 1.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 184, 184, 184),
                                            width: 1.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                      // labelStyle: GoogleFonts.secularOne(
                                      //     textStyle: normalstyle, fontSize: 15),
                                      // labelText: "Description",
                                      // prefixIcon: Icon(
                                      //     CupertinoIcons.bubble_right_fill),

                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                  expands: true,
                                  maxLines: null,
                                  minLines: null,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Project Name",
                                style: GoogleFonts.secularOne(
                                    textStyle: normalstyle,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: _title,
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: maincolor, width: 1.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 184, 184, 184),
                                            width: 1.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                      // labelStyle: GoogleFonts.secularOne(
                                      //     textStyle: normalstyle, fontSize: 15),
                                      // labelText: "Title",
                                      // prefixIcon: Icon(CupertinoIcons.pin_fill),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Work Description",
                                style: GoogleFonts.secularOne(
                                    textStyle: normalstyle,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: _desc,
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: maincolor, width: 1.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 184, 184, 184),
                                            width: 1.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                      // labelStyle: GoogleFonts.secularOne(
                                      //     textStyle: normalstyle, fontSize: 15),
                                      // labelText: "Description",
                                      // prefixIcon: Icon(
                                      //     CupertinoIcons.bubble_right_fill),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                  expands: true,
                                  maxLines: null,
                                  minLines: null,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Number of workers engaged",
                                style: GoogleFonts.secularOne(
                                    textStyle: normalstyle,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: formProvider.workersController,
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: maincolor, width: 1.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 184, 184, 184),
                                            width: 1.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                      // labelStyle: GoogleFonts.secularOne(
                                      //     textStyle: normalstyle, fontSize: 15),
                                      // labelText: "Title",
                                      // prefixIcon: Icon(CupertinoIcons.pin_fill),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Permit Valid From: Date & Time",
                                style: GoogleFonts.secularOne(
                                    textStyle: normalstyle,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: formProvider.startDateController,
                                  onTap: () =>
                                      formProvider.selectStartDate(context),
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: maincolor, width: 1.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 184, 184, 184),
                                            width: 1.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Permit Valid Till: Date & Time",
                                style: GoogleFonts.secularOne(
                                    textStyle: normalstyle,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: formProvider.endDateController,
                                  onTap: () =>
                                      formProvider.selectEndDate(context),
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: maincolor, width: 1.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 184, 184, 184),
                                            width: 1.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                ),
                              ),
                              Text(
                                " (Maximum validity of permit is 12hrs. And only one extension is permitted after 12hrs)",
                                style: GoogleFonts.poppins(
                                    textStyle: softnormal,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // SizedBox(
                              //   width: 500,
                              //   child: Card(
                              //     elevation: 2,
                              //     shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(4)),
                              //     clipBehavior: Clip.antiAliasWithSaveLayer,
                              //     child: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         Container(
                              //           padding: const EdgeInsets.all(15),
                              //           child: Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //             children: [
                              //               Text(
                              //                 "Date/Time:",
                              //                 style: GoogleFonts.secularOne(
                              //                     textStyle: normalstyle,
                              //                     fontSize: 13,
                              //                     color: Colors.black),
                              //               ),
                              //               Text(
                              //                 _dateTime,
                              //                 style: GoogleFonts.poppins(
                              //                     //textStyle: softnormal,
                              //                     fontWeight: FontWeight.w400,
                              //                     fontSize: 13,
                              //                     color: Colors.black),
                              //               ),
                              //               const SizedBox(height: 5),
                              //               Text(
                              //                 "Location:",
                              //                 style: GoogleFonts.secularOne(
                              //                     textStyle: normalstyle,
                              //                     fontSize: 13,
                              //                     color: Colors.black),
                              //               ),
                              //               Text(
                              //                 location,
                              //                 style: GoogleFonts.poppins(
                              //                     //textStyle: softnormal,
                              //                     fontWeight: FontWeight.w400,
                              //                     fontSize: 13,
                              //                     color: Colors.black),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              Text(
                                "Add your selfie(s)*",
                                style: GoogleFonts.secularOne(
                                    textStyle: softnormal,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Provider.of<FormStateProvider>(context,
                                              listen: false)
                                          .openCamera();
                                    },
                                    child: Container(
                                        width: 130,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 233, 233, 233),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(color: maincolor),
                                        ),
                                        child: _selfieImage != null
                                            ? Image.file(
                                                _selfieImage,
                                                fit: BoxFit.cover,
                                              )
                                            : const Icon(
                                                Icons.camera_alt,
                                                size: 30,
                                                fill: 1,
                                              )),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Provider.of<FormStateProvider>(context,
                                              listen: false)
                                          .getCertificate();
                                    },
                                    child: Container(
                                        width: 130,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 233, 233, 233),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(color: maincolor),
                                        ),
                                        child: _certificate != null
                                            ? Image.file(
                                                _certificate,
                                                fit: BoxFit.cover,
                                              )
                                            : const Icon(
                                                Icons.camera_alt,
                                                size: 30,
                                                fill: 1,
                                              )),
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     Provider.of<FormStateProvider>(context,
                                  //             listen: false)
                                  //         .image3();
                                  //   },
                                  //   child: Container(
                                  //       width: 80,
                                  //       height: 80,
                                  //       decoration: BoxDecoration(
                                  //         color: Color.fromARGB(
                                  //             255, 233, 233, 233),
                                  //         borderRadius:
                                  //             BorderRadius.circular(8),
                                  //         border: Border.all(color: maincolor),
                                  //       ),
                                  //       child: thirdImage != null
                                  //           ? Image.file(
                                  //               thirdImage,
                                  //               fit: BoxFit.cover,
                                  //             )
                                  //           : const Icon(
                                  //               Icons.camera_alt,
                                  //               size: 30,
                                  //               fill: 1,
                                  //             )),
                                  // ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     Provider.of<FormStateProvider>(context,
                                  //             listen: false)
                                  //         .image4();
                                  //   },
                                  //   child: Container(
                                  //       width: 80,
                                  //       height: 80,
                                  //       decoration: BoxDecoration(
                                  //         color: Color.fromARGB(
                                  //             255, 233, 233, 233),
                                  //         borderRadius:
                                  //             BorderRadius.circular(8),
                                  //         border: Border.all(color: maincolor),
                                  //       ),
                                  //       child: fourthImage != null
                                  //           ? Image.file(
                                  //               fourthImage,
                                  //               fit: BoxFit.cover,
                                  //             )
                                  //           : const Icon(
                                  //               Icons.camera_alt,
                                  //               size: 30,
                                  //               fill: 1,
                                  //             )),
                                  // ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(Icons.arrow_back_ios_new,
                                            size: 20),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          "Swipe to Continue",
                                          style: GoogleFonts.secularOne(
                                              fontSize: 13,
                                              textStyle: normalstyle),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  questions.isNotEmpty
                      ? Container(
                          color: Color.fromARGB(255, 231, 229, 241),
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: questions.length,
                                  itemBuilder: (context, index) {
                                    return AnimatedBuilder(
                                      animation: controllers![index],
                                      builder: (context, child) {
                                        return SlideTransition(
                                          position: offsetAnimations![index],
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color.fromARGB(
                                                            15, 193, 55, 195),
                                                        Color.fromARGB(
                                                            255, 166, 248, 254),
                                                      ],
                                                    )),
                                                child: Column(
                                                  children: [
                                                    IntrinsicHeight(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 4),
                                                              child: Text(
                                                                "Q" +
                                                                    (index + 1)
                                                                        .toString() +
                                                                    ". " +
                                                                    questions[
                                                                            index]
                                                                        .quesName,
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        13),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              ),
                                                            ),
                                                          ),
                                                          VerticalDivider(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    231,
                                                                    229,
                                                                    241),
                                                            thickness: 2,
                                                            width:
                                                                10, // Increased width
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    height: 30,
                                                                    child:
                                                                        Radio(
                                                                      activeColor:
                                                                          maincolor,
                                                                      value:
                                                                          true,
                                                                      groupValue:
                                                                          questions[index]
                                                                              .answer,
                                                                      onChanged:
                                                                          (value) {
                                                                        formProvider.updateAnswer(
                                                                            index,
                                                                            value);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            8),
                                                                    child: Text(
                                                                      "Yes",
                                                                      style: GoogleFonts.poppins(
                                                                          textStyle:
                                                                              normalstyle,
                                                                          fontSize:
                                                                              13),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    height: 30,
                                                                    child:
                                                                        Radio(
                                                                      activeColor:
                                                                          maincolor,
                                                                      value:
                                                                          false,
                                                                      groupValue:
                                                                          questions[index]
                                                                              .answer,
                                                                      onChanged:
                                                                          (value) {
                                                                        formProvider.updateAnswer(
                                                                            index,
                                                                            value);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            8),
                                                                    child: Text(
                                                                      "No",
                                                                      style: GoogleFonts.poppins(
                                                                          textStyle:
                                                                              normalstyle,
                                                                          fontSize:
                                                                              13),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(
                                                      color: Color.fromARGB(
                                                          255, 231, 229, 241),
                                                      thickness: 2,
                                                      height: 0,
                                                      // Increased width
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 4.0,
                                                          vertical: 6),
                                                      child: SizedBox(
                                                        height: 35,
                                                        child: TextFormField(
                                                          controller: formProvider
                                                                  .remarksControllers![
                                                              index],
                                                          decoration:
                                                              InputDecoration(
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color:
                                                                            maincolor,
                                                                        width:
                                                                            1.0),
                                                                  ),
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .black,
                                                                        width:
                                                                            1.0),
                                                                  ),
                                                                  contentPadding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          8),
                                                                  labelText:
                                                                      "Remarks if any",
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4))),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                //   ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    "Mention any additional controls needed and implemented:",
                                    style: GoogleFonts.secularOne(
                                        textStyle: normalstyle,
                                        fontSize: 13,
                                        color: Colors.black),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: SizedBox(
                                    height: 70,
                                    child: TextFormField(
                                      controller: formProvider
                                          .additionalDetailsController,
                                      decoration: InputDecoration(
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: maincolor, width: 1.0),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 184, 184, 184),
                                                width: 1.0),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 8),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4))),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_selfieImage == null ||
                                        _certificate == null ||
                                        formProvider
                                            .startDateController.text.isEmpty ||
                                        formProvider
                                            .endDateController.text.isEmpty ||
                                        _desc.text.isEmpty ||
                                        formProvider
                                            .locationController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: maincolor,
                                          duration: const Duration(seconds: 4),
                                          showCloseIcon: true,
                                          closeIconColor: Colors.white,
                                          dismissDirection:
                                              DismissDirection.vertical,
                                          content: Text(
                                            'Please add project name, decription, location of work, permit from and till date, and both the images.',
                                            style: GoogleFonts.josefinSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                        ),
                                      );
                                    } else {
                                      for (int i = 0;
                                          i <= questions.length;
                                          i++) {
                                        int questionId;
                                        bool answer;
                                        String remark;
                                        Map<String, dynamic> answerMap = {};

                                        if (i == questions.length) {
                                          answerMap = {
                                            'question_id': 0,
                                            'answer': 'N/A',
                                            'remark': formProvider
                                                .additionalDetailsController
                                                .text,
                                          };
                                        } else {
                                          questionId = questions[i].quesId;
                                          answer = questions[i].answer!;
                                          remark = formProvider
                                              .remarksControllers![i].text;
                                          answerMap = {
                                            'question_id': questionId,
                                            'answer': answer ? 'Yes' : 'No',
                                            'remark': remark,
                                          };
                                        }
                                        answersList.add(answerMap);
                                      }

                                      Provider.of<FormStateProvider>(context,
                                              listen: false)
                                          .sendFormData(
                                              widget.permitId.toString(),
                                              context,
                                              answersList,
                                              formProvider
                                                  .additionalDetailsController
                                                  .text);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Container(
                                        height: 45,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: selfie ||
                                                    exp &&
                                                    validTitle &&
                                                    validendDate &&
                                                    validstartDate &&
                                                    validDesc &&
                                                    validloc
                                                ? maincolor
                                                : Color.fromARGB(
                                                    255, 212, 211, 211),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: _dataLoad
                                            ? const Center(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4),
                                                  child:
                                                      CircularProgressIndicator(
                                                    backgroundColor:
                                                        Colors.white,
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            Color.fromARGB(255,
                                                                220, 216, 216)),
                                                  ),
                                                ),
                                              )
                                            : Center(
                                                child: Text(
                                                  "Submit",
                                                  style: GoogleFonts.secularOne(
                                                      textStyle: normalstyle,
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                // ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Color.fromARGB(255, 231, 229, 241),
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: maincolor,
                              valueColor: AlwaysStoppedAnimation(
                                  Color.fromARGB(255, 220, 216, 216)),
                              strokeWidth: 5,
                            ),
                          ),
                        )
                ],
              ));
  }
}
