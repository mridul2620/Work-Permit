import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_permit/globalvarialbles.dart';
import 'package:work_permit/home/user_card.dart';
import '../permit_form/form.dart';
import '../trial_end.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<CategoryItem> categories = [];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  List<bool> categorySubmittedStatus = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the widget is initialized
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    const apiUrl = baseAPI + category_list;

    try {
      final response = await http.get(Uri.parse(apiUrl),
          headers: {'Authorization': 'Bearer $accessToken'});
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['data'];

        // Create a list of CategoryItem objects from the API data
        final categoryList = List<CategoryItem>.from(data.map((item) {
          return CategoryItem(
            id: item['id'],
            categoryName: item['category_name'],
            categoryImage: item['category_image'],
          );
        }));

        setState(() {
          categories = categoryList;
          isLoading = false;
        });
      } else if (response.statusCode == 423) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ErrorPage()));
      } else {
        // Handle errors if the API request fails
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      body: isLoading
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
                Stack(children: [
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
                      carouselController: carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 2,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
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
                          onTap: () =>
                              carouselController.animateToPage(entry.key),
                          child: Container(
                            width: currentIndex == entry.key ? 17 : 7,
                            height: 7.0,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 3.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == entry.key
                                  ? maincolor
                                  : Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ]),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        categories.length, // Use the length of the fetched data
                    itemBuilder: (context, index) {
                      final category = categories[index];

                      return GestureDetector(
                        onTap: () async {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormPage(
                                  permitType: category.categoryName,
                                  permitId: category.id),
                            ),
                          );
                        },
                        child: UserCardList(
                          title: category.categoryName,
                          image: category.categoryImage,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}

class CategoryItem {
  final int id;
  final String categoryName;
  final String categoryImage;

  CategoryItem({
    required this.id,
    required this.categoryName,
    required this.categoryImage,
  });
}
