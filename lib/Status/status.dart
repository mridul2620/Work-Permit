import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:work_permit/Status/approved.dart';
// import 'package:work_permit/Status/declined.dart';
// import 'package:work_permit/Status/pending.dart';
import 'package:work_permit/Status/permit_status.dart';
import 'package:work_permit/Status/status_provider.dart';
import 'package:work_permit/fonts/fonts.dart';
import '../../globalvarialbles.dart';
import '../../home/cardlist.dart';
//import 'permit_model.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  void initState() {
    super.initState();
    Provider.of<StatusProvider>(context, listen: false).fetchData();
  }

  void filterStatus(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);
    final status = statusProvider.status;
    return Scaffold(
      backgroundColor: bodyColor,
      body: statusProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: maincolor,
                valueColor:
                    AlwaysStoppedAnimation(Color.fromARGB(255, 220, 216, 216)),
                strokeWidth: 4,
              ), // Display circular progress indicator while loading
            )
          : Column(
              children: [
                Stack(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: CarouselSlider(
                        items: imageList
                            .map(
                              (item) => Image.asset(
                                item['image_path'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            )
                            .toList(),
                        carouselController: statusProvider.carouselController,
                        options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          aspectRatio: 2,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              statusProvider.currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => statusProvider.carouselController
                                .animateToPage(entry.key),
                            child: Container(
                              width: statusProvider.currentIndex == entry.key
                                  ? 17
                                  : 7,
                              height: 7.0,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 3.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: statusProvider.currentIndex == entry.key
                                    ? maincolor
                                    : Colors.white,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: filterOptions.map((filter) {
                      final isActive = filter == selectedFilter;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0), // Add spacing
                        child: GestureDetector(
                          onTap: () {
                            filterStatus(filter);
                          },
                          child: Container(
                            width: 90,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isActive ? maincolor : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                filter,
                                style: GoogleFonts.secularOne(
                                  color: isActive ? Colors.white : Colors.black,
                                  textStyle: normalstyle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: (selectedFilter == 'All' ||
                          status.any((item) =>
                              item.status == selectedFilter.toLowerCase()))
                      ? ListView.builder(
                          itemCount: status.length,
                          itemBuilder: (context, index) {
                            final permitStatus = status[index];
                            if (selectedFilter == 'All' ||
                                permitStatus.status ==
                                    selectedFilter.toLowerCase()) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PermitStatus(
                                        id: permitStatus.id,
                                      ),
                                    ),
                                  );
                                },
                                child: CardList(
                                  title: permitStatus.title,
                                  image: permitStatus.selfieImage,
                                  subtitle: permitStatus.status,
                                ),
                              );
                            }
                            return SizedBox
                                .shrink(); // Hide the card for other filters
                          },
                        )
                      : Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.warning_rounded, size: 26, color: Color.fromARGB(255, 206, 35, 23),),
                              const SizedBox(width: 5,),
                              Text("Nothing here yet",
                                  style: GoogleFonts.secularOne(
                                      textStyle: normalstyle, fontSize: 18, color: Color.fromARGB(255, 206, 35, 23),)),
                            ],
                          ),
                        ),
                )
              ],
            ),
    );
  }
}
