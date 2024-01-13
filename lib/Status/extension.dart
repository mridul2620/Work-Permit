import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";

import "../fonts/fonts.dart";
import "../globalvarialbles.dart";
import "../permit_form/form_provider.dart";

class ExtensionFormPage extends StatefulWidget {
  final int permitId;
  final int categoryId;
  final String permitNo;
  const ExtensionFormPage(
      {required this.categoryId,
      required this.permitNo,
      required this.permitId});

  @override
  State<ExtensionFormPage> createState() => _ExtensionState();
}

class _ExtensionState extends State<ExtensionFormPage> {
  @override
  void initState() {
    super.initState();
    final formProvider = Provider.of<FormStateProvider>(context, listen: false);
    formProvider.fetchQues(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormStateProvider>(context);
    final questions = formProvider.questionList;
    List<Map<String, dynamic>> answersList = [];
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
            formProvider.resetValues();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
      ),
      body: formProvider.isLoading && questions.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: maincolor,
                valueColor:
                    AlwaysStoppedAnimation(Color.fromARGB(255, 220, 216, 216)),
                strokeWidth: 5,
              ),
            )
          : SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Permit Extension Form",
                        style: GoogleFonts.secularOne(
                            textStyle: normalstyle,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Permit Number",
                      style: GoogleFonts.secularOne(
                          textStyle: normalstyle,
                          fontSize: 13,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        enabled: false,
                        initialValue: widget.permitNo,
                        style: GoogleFonts.poppins(
                            fontSize: 13, textStyle: normalstyle),
                        decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: maincolor, width: 4.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 184, 184, 184),
                                  width: 2.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4))),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Permit Valid From: Date & Time",
                      style: GoogleFonts.secularOne(
                          textStyle: normalstyle,
                          fontSize: 13,
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
                        style: GoogleFonts.poppins(
                            fontSize: 13, textStyle: normalstyle),
                        onTap: () => formProvider.selectStartDate(context),
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
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4))),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Permit Valid Till: Date & Time",
                      style: GoogleFonts.secularOne(
                          textStyle: normalstyle,
                          fontSize: 13,
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
                        onTap: () => formProvider.selectEndDate(context),
                        style: GoogleFonts.poppins(
                            fontSize: 13, textStyle: normalstyle),
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
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4))),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Reason for Extension",
                      style: GoogleFonts.secularOne(
                          textStyle: normalstyle,
                          fontSize: 13,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 55,
                      child: TextFormField(
                        controller: formProvider.reasonController,
                        style: GoogleFonts.poppins(
                            fontSize: 13, textStyle: normalstyle),
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
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4))),
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(15, 193, 55, 195),
                                      Color.fromARGB(255, 166, 248, 254),
                                    ],
                                  )),
                              child: Column(
                                children: [
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 4),
                                            child: Text(
                                              "Q" +
                                                  (index + 1).toString() +
                                                  ". " +
                                                  questions[index].quesName,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.white,
                                          thickness: 2,
                                          width: 10, // Increased width
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 30,
                                                  child: Radio(
                                                    activeColor: maincolor,
                                                    value: true,
                                                    groupValue:
                                                        questions[index].answer,
                                                    onChanged: (value) {
                                                      formProvider.updateAnswer(
                                                          index, value);
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Text(
                                                    "Yes",
                                                    style: GoogleFonts.poppins(
                                                        textStyle: normalstyle,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 30,
                                                  child: Radio(
                                                    activeColor: maincolor,
                                                    value: false,
                                                    groupValue:
                                                        questions[index].answer,
                                                    onChanged: (value) {
                                                      formProvider.updateAnswer(
                                                          index, value);
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Text(
                                                    "No",
                                                    style: GoogleFonts.poppins(
                                                        textStyle: normalstyle,
                                                        fontSize: 13),
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
                                    color: Colors.white,
                                    thickness: 2,
                                    height: 0,
                                    // Increased width
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 6),
                                    child: SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        controller: formProvider
                                            .remarksControllers![index],
                                        decoration: InputDecoration(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: maincolor, width: 1.0),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1.0),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 8),
                                            labelText: "Remarks if any",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 70,
                        child: TextFormField(
                          controller: formProvider.additionalDetailsController,
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
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          maxLines: 3,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (formProvider.startDateController.text.isEmpty ||
                            formProvider.endDateController.text.isEmpty ||
                            formProvider.reasonController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: maincolor,
                              duration: const Duration(seconds: 4),
                              showCloseIcon: true,
                              closeIconColor: Colors.white,
                              dismissDirection: DismissDirection.vertical,
                              content: Text(
                                'Please add permit from and till date, and the reason for extension.',
                                style: GoogleFonts.josefinSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),
                          );
                        } else {
                          for (int i = 0; i <= questions.length; i++) {
                            int questionId;
                            bool answer;
                            String remark;
                            Map<String, dynamic> answerMap = {};

                            if (i == questions.length) {
                              answerMap = {
                                'question_id': 0,
                                'answer': 'N/A',
                                'remark': formProvider
                                    .additionalDetailsController.text,
                              };
                            } else {
                              questionId = questions[i].quesId;
                              answer = questions[i].answer!;
                              remark = formProvider.remarksControllers![i].text;
                              answerMap = {
                                'question_id': questionId,
                                'answer': answer ? 'Yes' : 'No',
                                'remark': remark,
                              };
                            }
                            answersList.add(answerMap);
                          }
                          Provider.of<FormStateProvider>(context, listen: false)
                              .sendExtensionFormData(
                                  widget.permitId.toString(),
                                  context,
                                  answersList,
                                  formProvider.reasonController.text,
                                  formProvider
                                      .additionalDetailsController.text);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2),
                        child: Center(
                          child: Container(
                            height: 37,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: formProvider.startDateController.text
                                            .isNotEmpty &&
                                        formProvider.endDateController.text
                                            .isNotEmpty &&
                                        formProvider
                                            .reasonController.text.isNotEmpty
                                    ? maincolor
                                    : Color.fromARGB(255, 212, 211, 211),
                                borderRadius: BorderRadius.circular(12)),
                            child: formProvider.dataLoad
                                ? const Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4),
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                        valueColor: AlwaysStoppedAnimation(
                                            Color.fromARGB(255, 220, 216, 216)),
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
                  ],
                ),
              ),
            ),
    );
  }
}
