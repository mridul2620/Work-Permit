// import 'dart:convert';
// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:work_permit/Status/certificate.dart';
// import '../../globalvarialbles.dart';
// import '../../home/cardlist.dart';
// import '../../home/category_model.dart';

// class UserStatus extends StatefulWidget {
//   @override
//   State<UserStatus> createState() => _UserStatusState();
// }

// class _UserStatusState extends State<UserStatus> {
//   late SharedPreferences _prefs;
//   List<String> _savedFormKeys = [];
//   final List<ListItem> items = [];

//   @override
//   void initState() {
//     super.initState();
//     _initSharedPreferences();
//     _initializeItemsList();
//   }

//   void _getSubtitle(String permitType) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String status = prefs.getString(permitType) ?? 'Pending';

//     // Find the card item with the matching permitType and update its status
//     for (var item in items) {
//       if (item.title == permitType) {
//         setState(() {
//           item.subtitle = status;
//         });
//         break; // Stop searching once the item is found
//       }
//     }
//   }

//   void _initSharedPreferences() async {
//     _prefs = await SharedPreferences.getInstance();
//     _getSavedFormKeys();
//     //getStatusSubtitle(permitType);
//   }

//   void _getSavedFormKeys() {
//     final keys = _prefs.getKeys();
//     setState(() {
//       _savedFormKeys = keys.where((key) => key.startsWith('form_')).toList();
//     });
//   }

//   void _showFormDetails(String formKey, String permitType) async {
//     final formDataJson = _prefs.getString(formKey);
//     final formData = json.decode(formDataJson ?? '{}');
//     final status = await getStatusSubtitle(permitType);
//     if (status == 'Approved') {
//       Navigator.of(context).push(
//         MaterialPageRoute(builder: (context) => Certificate()),
//       );
//     }
//   }

//   Future<String> getStatusSubtitle(String permitType) async {
//     // Retrieve the status from SharedPreferences for the given permitType
//     _prefs = await SharedPreferences.getInstance();
//     String status = _prefs.getString(permitType) ?? 'Pending';
//     for (var item in items) {
//       if (item.title == permitType) {
//         setState(() {
//           item.subtitle = status;
//         });
//         break;
//       }
//     }
//     return status;
//   }

//   List imageList = [
//     {"id": 1, "image_path": 'assets/images/home.png'},
//     {"id": 2, "image_path": 'assets/images/home.png'},
//     {"id": 3, "image_path": 'assets/images/home.png'}
//   ];
//   void _initializeItemsList() async {
//     items.add(ListItem(
//       title: 'Hot Work Permit',
//       imagePath: 'assets/images/list_icon.png',
//       subtitle: (await getStatusSubtitle('Hot Work Permit')).toString(),
//     ));
//     items.add(ListItem(
//       title: 'Cold Work Permit',
//       imagePath: 'assets/images/list_icon.png',
//       subtitle: (await getStatusSubtitle('Cold Work Permit')).toString(),
//     ));
//     items.add(ListItem(
//       title: 'Electrical Work Permit',
//       imagePath: 'assets/images/list_icon.png',
//       subtitle: (await getStatusSubtitle('Electrical Work Permit')).toString(),
//     ));
//     items.add(ListItem(
//       title: 'Ground Disturbance',
//       imagePath: 'assets/images/list_icon.png',
//       subtitle: (await getStatusSubtitle('Ground Disturbance')).toString(),
//     ));
//     items.add(ListItem(
//       title: 'Confined Space Entry',
//       imagePath: 'assets/images/list_icon.png',
//       subtitle: (await getStatusSubtitle('Confined Space Entry')).toString(),
//     ));
//   }

//   final CarouselController carouselController = CarouselController();
//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bodyColor,
//       body: Column(
//         children: [
//           Stack(
//             children: [
//               InkWell(
//                 onTap: () {},
//                 child: CarouselSlider(
//                   items: imageList
//                       .map(
//                         (item) => Image.asset(
//                           item['image_path'],
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                         ),
//                       )
//                       .toList(),
//                   carouselController: carouselController,
//                   options: CarouselOptions(
//                     scrollPhysics: const BouncingScrollPhysics(),
//                     autoPlay: true,
//                     aspectRatio: 2,
//                     viewportFraction: 1,
//                     onPageChanged: (index, reason) {
//                       setState(() {
//                         currentIndex = index;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 10,
//                 left: 0,
//                 right: 0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: imageList.asMap().entries.map((entry) {
//                     return GestureDetector(
//                       onTap: () => carouselController.animateToPage(entry.key),
//                       child: Container(
//                         width: currentIndex == entry.key ? 17 : 7,
//                         height: 7.0,
//                         margin: const EdgeInsets.symmetric(
//                           horizontal: 3.0,
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: currentIndex == entry.key
//                               ? maincolor
//                               : Colors.white,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: ListView.builder(
//                 itemCount: _savedFormKeys.length,
//                 itemBuilder: (context, index) {
//                   final formKey = _savedFormKeys[index];
//                   final formDataJson = _prefs.getString(formKey);
//                   final formData = json.decode(formDataJson ?? '{}');
//                   final permitType = formData['permitType'] ?? '';
//                   final item = items[index];
//                   return FutureBuilder<String>(
//                     future: getStatusSubtitle(permitType),
//                     builder: (context, snapshot) {
//                       final subtitleText = snapshot.data ?? '';
//                       return GestureDetector(
//                         onTap: () async {
//                           _showFormDetails(formKey, permitType);
//                         },
//                         child: CardList(
//                           title: permitType,
//                           subtitle: subtitleText,
//                           image: item.imagePath,
//                         ),
//                       );
//                     },
//                   );
//                 }),
//           )
//         ],
//       ),
//     );
//   }
// }
