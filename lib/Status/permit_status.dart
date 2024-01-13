import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:work_permit/Status/extension.dart';
import 'package:work_permit/Status/permit_model.dart';
import 'package:work_permit/fonts/fonts.dart';
import 'package:accordion/accordion.dart';
import '../globalvarialbles.dart';
import 'status_provider.dart';
import 'package:timelines/timelines.dart';

class PermitStatus extends StatefulWidget {
  final int id;
  const PermitStatus({required this.id});

  @override
  State<PermitStatus> createState() => _PermitStatusState();
}

class _PermitStatusState extends State<PermitStatus> {
  Future<PermitModel>? permitModel;

  @override
  void initState() {
    super.initState();
    permitModel = Provider.of<StatusProvider>(context, listen: false)
        .fetchStatus(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);
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
      body: FutureBuilder<PermitModel>(
        future: permitModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}\nStatus Code:'),
            );
          } else {
            final permit = snapshot.data!;
            return Container(
              color: statusProvider.statusColor(permit.status),
              child: Stack(
                children: [
                  LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      decoration: BoxDecoration(
                          color: statusProvider.statusColor(permit.status)),
                      height: constraints.maxHeight / 11,
                      child: Center(
                        child: Text(
                          permit.status.toUpperCase(),
                          style: GoogleFonts.zillaSlab(
                              fontWeight: FontWeight.bold,
                              textStyle: normalstyle,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                      ),
                    );
                  }),
                  DraggableScrollableSheet(
                    initialChildSize: 0.92,
                    minChildSize: 0.92,
                    builder: (BuildContext context,
                        ScrollController scrollcontroller) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0, bottom: 8),
                          child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 120,
                                          child: Text(
                                            "Permit Number ",
                                            style: GoogleFonts.secularOne(
                                                textStyle: normalstyle,
                                                color: Colors.black,
                                                fontSize: 13),
                                          ),
                                        ),
                                        Text(
                                          ":",
                                          style: GoogleFonts.secularOne(
                                              textStyle: normalstyle,
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          permit.permitNo,
                                          style: GoogleFonts.poppins(
                                            textStyle: normalstyle,
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 120,
                                          child: Text(
                                            "Name ",
                                            style: GoogleFonts.secularOne(
                                                textStyle: normalstyle,
                                                color: Colors.black,
                                                fontSize: 13),
                                          ),
                                        ),
                                        Text(
                                          ":",
                                          style: GoogleFonts.secularOne(
                                              textStyle: normalstyle,
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          permit.name,
                                          style: GoogleFonts.poppins(
                                              textStyle: normalstyle,
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 120,
                                          child: Text(
                                            "Permit Type ",
                                            style: GoogleFonts.secularOne(
                                                textStyle: normalstyle,
                                                color: Colors.black,
                                                fontSize: 13),
                                          ),
                                        ),
                                        Text(
                                          ":",
                                          style: GoogleFonts.secularOne(
                                              textStyle: normalstyle,
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            permit.category,
                                            style: GoogleFonts.poppins(
                                                textStyle: normalstyle,
                                                color: Colors.black,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 120,
                                          child: Text(
                                            "Project Name ",
                                            style: GoogleFonts.secularOne(
                                                textStyle: normalstyle,
                                                color: Colors.black,
                                                fontSize: 13),
                                          ),
                                        ),
                                        Text(
                                          ":",
                                          style: GoogleFonts.secularOne(
                                              textStyle: normalstyle,
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          permit.title,
                                          style: GoogleFonts.poppins(
                                              textStyle: normalstyle,
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 120,
                                          child: Text(
                                            "Job Description ",
                                            style: GoogleFonts.secularOne(
                                                textStyle: normalstyle,
                                                color: Colors.black,
                                                fontSize: 13),
                                          ),
                                        ),
                                        Text(
                                          ":",
                                          style: GoogleFonts.secularOne(
                                              textStyle: normalstyle,
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            permit.description,
                                            style: GoogleFonts.poppins(
                                                textStyle: normalstyle,
                                                color: Colors.black,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 120,
                                          child: Text(
                                            "Location of work ",
                                            style: GoogleFonts.secularOne(
                                                textStyle: normalstyle,
                                                color: Colors.black,
                                                fontSize: 13),
                                          ),
                                        ),
                                        Text(
                                          ":",
                                          style: GoogleFonts.secularOne(
                                              textStyle: normalstyle,
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            permit.address,
                                            style: GoogleFonts.poppins(
                                              textStyle: normalstyle,
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 120,
                                          child: Text(
                                            "Contractor Name ",
                                            style: GoogleFonts.secularOne(
                                                textStyle: normalstyle,
                                                color: Colors.black,
                                                fontSize: 13),
                                          ),
                                        ),
                                        Text(
                                          ":",
                                          style: GoogleFonts.secularOne(
                                              textStyle: normalstyle,
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          permit.contractorName,
                                          style: GoogleFonts.poppins(
                                            textStyle: normalstyle,
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 120,
                                          child: Text(
                                            "Applied Date ",
                                            style: GoogleFonts.secularOne(
                                                textStyle: normalstyle,
                                                color: Colors.black,
                                                fontSize: 13),
                                          ),
                                        ),
                                        Text(
                                          ":",
                                          style: GoogleFonts.secularOne(
                                              textStyle: normalstyle,
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          permit.date,
                                          style: GoogleFonts.poppins(
                                            textStyle: normalstyle,
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    permit.status == 'approved' ||
                                            permit.status == "extension" ||
                                            permit.status == "in-progress"
                                        ? Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 120,
                                                    child: Text(
                                                      "Valid From ",
                                                      style: GoogleFonts
                                                          .secularOne(
                                                              textStyle:
                                                                  normalstyle,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13),
                                                    ),
                                                  ),
                                                  Text(
                                                    ":",
                                                    style:
                                                        GoogleFonts.secularOne(
                                                            textStyle:
                                                                normalstyle,
                                                            color: Colors.black,
                                                            fontSize: 13),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    permit.validFrom,
                                                    style: GoogleFonts.poppins(
                                                        textStyle: normalstyle,
                                                        color: Colors.black,
                                                        fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 120,
                                                    child: Text(
                                                      "Valid Till ",
                                                      style: GoogleFonts
                                                          .secularOne(
                                                              textStyle:
                                                                  normalstyle,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13),
                                                    ),
                                                  ),
                                                  Text(
                                                    ":",
                                                    style:
                                                        GoogleFonts.secularOne(
                                                            textStyle:
                                                                normalstyle,
                                                            color: Colors.black,
                                                            fontSize: 13),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    permit.validTill,
                                                    style: GoogleFonts.poppins(
                                                        textStyle: normalstyle,
                                                        color: Colors.black,
                                                        fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    permit.status == 'declined'
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 120,
                                                child: Text(
                                                  "Reason :",
                                                  style: GoogleFonts.secularOne(
                                                      textStyle: normalstyle,
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  permit.reason,
                                                  style: GoogleFonts.poppins(
                                                    textStyle: normalstyle,
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: 130,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(baseUrl +
                                                      permit.selfieImage),
                                                  fit: BoxFit.fill)),
                                        ),
                                        Container(
                                          width: 130,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(baseUrl +
                                                      permit.workImage),
                                                  fit: BoxFit.fill)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    permit.status == 'extension'
                                        ? Card(
                                            elevation: 1,
                                            color: yellowColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal:6, vertical: 4),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "Extension Details",
                                                      style: GoogleFonts
                                                          .secularOne(
                                                        textStyle: normalstyle,
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        child: Text(
                                                          "Extension status :",
                                                          style: GoogleFonts
                                                              .secularOne(
                                                            textStyle:
                                                                normalstyle,
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          permit
                                                              .extension.status,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                normalstyle,
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        child: Text(
                                                          "Extension Valid From :",
                                                          style: GoogleFonts
                                                              .secularOne(
                                                            textStyle:
                                                                normalstyle,
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          permit.extension
                                                              .extensionFrom,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                normalstyle,
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        child: Text(
                                                          "Extension Valid Till :",
                                                          style: GoogleFonts
                                                              .secularOne(
                                                            textStyle:
                                                                normalstyle,
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          permit.extension
                                                              .extensionTill,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                normalstyle,
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        child: Text(
                                                          "Extension Reason :",
                                                          style: GoogleFonts
                                                              .secularOne(
                                                            textStyle:
                                                                normalstyle,
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          permit.extension
                                                              .extensionReason,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                normalstyle,
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  permit.extension
                                                              .otherReason ==
                                                          ""
                                                      ? Container()
                                                      : Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              width: 120,
                                                              child: Text(
                                                                "Rejection reason :",
                                                                style: GoogleFonts
                                                                    .secularOne(
                                                                  textStyle:
                                                                      normalstyle,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 13,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                permit.extension
                                                                    .otherReason,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      normalstyle,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 13,
                                                                ),
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
                                          )
                                        : Container(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Accordion(
                                      disableScrolling: true,
                                      headerBackgroundColor: Colors.white,
                                      headerBorderColor: maincolor,
                                      headerBorderWidth: 1,
                                      contentBackgroundColor: Colors.white,
                                      contentBorderColor: maincolor,
                                      contentBorderWidth: 1,
                                      contentHorizontalPadding: 4,
                                      scaleWhenAnimating: true,
                                      rightIcon: Icon(
                                        Icons.arrow_drop_down,
                                        color: maincolor,
                                      ),
                                      openAndCloseAnimation: true,
                                      headerPadding: const EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 15),
                                      children: [
                                        AccordionSection(
                                          isOpen: false,
                                          header: Text(
                                            "Questionnaire",
                                            style: GoogleFonts.secularOne(
                                              textStyle: normalstyle,
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                          content: Column(
                                            children: permit.answers
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              final index = entry.key;
                                              final answer = entry.value;
                                              return Column(
                                                children: [
                                                  ListTile(
                                                      title: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Q${index + 1}. ",
                                                              style: GoogleFonts
                                                                  .secularOne(
                                                                textStyle:
                                                                    normalstyle,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                answer
                                                                    .questionName,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      normalstyle,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 13,
                                                                ),
                                                              ),
                                                            ),
                                                          ]),
                                                      subtitle: Column(
                                                        children: [
                                                          Row(children: [
                                                            Text(
                                                              "Answer: ",
                                                              style: GoogleFonts
                                                                  .secularOne(
                                                                textStyle:
                                                                    normalstyle,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                            Text(
                                                              answer.answer,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                textStyle:
                                                                    normalstyle,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ]),
                                                          answer.remarks != ""
                                                              ? Row(children: [
                                                                  Text(
                                                                    "Remarks: ",
                                                                    style: GoogleFonts
                                                                        .secularOne(
                                                                      textStyle:
                                                                          normalstyle,
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    answer
                                                                        .remarks,
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      textStyle:
                                                                          normalstyle,
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                  ),
                                                                ])
                                                              : Container()
                                                        ],
                                                      )),
                                                  index ==
                                                          permit.answers
                                                                  .length -
                                                              1
                                                      ? SizedBox()
                                                      : Divider(
                                                          height: 4,
                                                          color: maincolor,
                                                        )
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Accordion(
                                        disableScrolling: true,
                                        headerBackgroundColor: Colors.white,
                                        headerBorderColor: maincolor,
                                        headerBorderWidth: 1,
                                        contentBackgroundColor: Colors.white,
                                        contentBorderColor: maincolor,
                                        contentBorderWidth: 1,
                                        contentHorizontalPadding: 4,
                                        scaleWhenAnimating: true,
                                        rightIcon: Icon(
                                          Icons.arrow_drop_down,
                                          color: maincolor,
                                        ),
                                        headerPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 15),
                                        children: [
                                          AccordionSection(
                                              header: Text(
                                                "Timeline",
                                                style: GoogleFonts.secularOne(
                                                  textStyle: normalstyle,
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              content: Timeline.tileBuilder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  reverse: false,
                                                  builder: TimelineTileBuilder
                                                      .fromStyle(
                                                          itemCount: permit
                                                              .timelineData
                                                              .length,
                                                          contentsAlign:
                                                              ContentsAlign
                                                                  .alternating,
                                                          contentsBuilder:
                                                              (context, index) {
                                                            final timelineList =
                                                                permit.timelineData[
                                                                    index];
                                                            return Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      1),
                                                              child: Card(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12)),
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8),
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          yellowColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12)),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          timelineList
                                                                              .date,
                                                                          style: GoogleFonts.secularOne(
                                                                              fontSize: 10,
                                                                              color: Colors.black)),
                                                                      const Divider(
                                                                          thickness:
                                                                              1,
                                                                          color:
                                                                              Colors.white
                                                                          //  Color.fromARGB(
                                                                          //     255,
                                                                          //     230,
                                                                          //     227,
                                                                          //     227),
                                                                          ),
                                                                      Text(
                                                                          timelineList
                                                                              .status
                                                                              .toUpperCase(),
                                                                          style: GoogleFonts.secularOne(
                                                                              fontSize: 13,
                                                                              color: Colors.black)),
                                                                      const SizedBox(
                                                                        height:
                                                                            4,
                                                                      ),
                                                                      Text(
                                                                          "By: ",
                                                                          style: GoogleFonts.secularOne(
                                                                              fontSize: 13,
                                                                              color: Colors.black)),
                                                                      Expanded(
                                                                        child: Text(
                                                                            timelineList
                                                                                .updatedBy,
                                                                            style: GoogleFonts.poppins(
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: Colors.black)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          })))
                                        ]),
                                    permit.status == "extension"
                                        ? Center(
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              height: 37,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          elevation: 10,
                                                          shadowColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  207,
                                                                  207,
                                                                  207),
                                                          backgroundColor:
                                                              maincolor),
                                                  onPressed: () async {
                                                    await statusProvider
                                                        .updateStatus(completed,
                                                            permit.id, context);
                                                  },
                                                  child: Text(
                                                      "Work Completed",
                                                      style: GoogleFonts
                                                          .secularOne(
                                                              textStyle:
                                                                  normalstyle,
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .white))),
                                            ),
                                          )
                                        : Container(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    permit.status == "approved" ||
                                            permit.status == "in-progress"
                                        ? SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 37,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: maincolor),
                                                onPressed: () async {
                                                  Navigator.push(
                                                      context,
                                                      new MaterialPageRoute(
                                                          builder: (context) =>
                                                              ExtensionFormPage(
                                                                categoryId: permit
                                                                    .categoryId,
                                                                permitNo: permit
                                                                    .permitNo,
                                                                permitId:
                                                                    permit.id,
                                                              )));
                                                },
                                                child: Text(
                                                    "Request for Extension",
                                                    style:
                                                        GoogleFonts.secularOne(
                                                            textStyle:
                                                                normalstyle,
                                                            fontSize: 13,
                                                            color:
                                                                Colors.white))),
                                          )
                                        : Container(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    permit.status == "approved" ||
                                            permit.status == "in-progress"
                                        ? Card(
                                            color: Color.fromARGB(
                                                255, 251, 251, 251),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                      child: Text(
                                                    "Update Status",
                                                    style:
                                                        GoogleFonts.secularOne(
                                                            color: Colors.black,
                                                            textStyle:
                                                                normalstyle,
                                                            fontSize: 15),
                                                  )),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      DropdownButton(
                                                        underline: Container(
                                                          color: Color.fromARGB(
                                                              255,
                                                              249,
                                                              244,
                                                              244),
                                                        ),
                                                        dropdownColor:
                                                            Color.fromARGB(255,
                                                                251, 251, 251),

                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 2),
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black),
                                                        //elevation: 4,
                                                        // Initial Value
                                                        hint: Text("Select"),
                                                        value: dropdownvalue,
                                                        // Down Arrow Icon
                                                        icon: const Icon(Icons
                                                            .keyboard_arrow_down),
                                                        // Array list of items
                                                        items: items.map(
                                                            (String items) {
                                                          return DropdownMenuItem(
                                                            value: items,
                                                            child: Text(items),
                                                          );
                                                        }).toList(),
                                                        // After selecting the desired option,it will
                                                        // change button value to selected value
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            dropdownvalue =
                                                                newValue!;
                                                          });
                                                        },
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3,
                                                        height: 37,
                                                        child: ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        maincolor),
                                                            onPressed:
                                                                () async {
                                                              await statusProvider
                                                                  .updateStatus(
                                                                      dropdownvalue,
                                                                      permit.id,
                                                                      context);
                                                            },
                                                            child: Text(
                                                                "Update",
                                                                style: GoogleFonts.secularOne(
                                                                    textStyle:
                                                                        normalstyle,
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .white))),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
