import 'package:flutter/material.dart';

import '../globalvarialbles.dart';

class Images extends StatefulWidget {
  const Images({super.key});

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  bool isImageSelected = false;
  String selectedImage = '';
  final List<String> imageList = [
    'assets/images/tips/img_1.png',
    'assets/images/tips/img_2.png',
    'assets/images/tips/img_3.png',
    'assets/images/tips/img_4.png',
    'assets/images/tips/img_1.png',
    'assets/images/tips/img_2.png',
    'assets/images/tips/img_3.png',
    'assets/images/tips/img_5.png',
    'assets/images/tips/img_1.png',
    'assets/images/tips/img_2.png',
    'assets/images/tips/img_3.png',
    'assets/images/tips/img_4.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          isImageSelected
              ? Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 260,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(selectedImage),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                )
              : Container(
                decoration:BoxDecoration(
                gradient: LinearGradient(colors: [
                  maincolor.withOpacity(0.8),
                  Colors.black.withOpacity(0.9),
                ], begin: Alignment.topCenter, end: Alignment.center),
              ),
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
                  child:const  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start Learning",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                       SizedBox(
                          height: 5,
                        ),
                       Text(
                          "Let's get started",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "with some Tips",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Tap on the images to view",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ]),
                ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      isImageSelected = true;
                      selectedImage = imageList[index];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imageList[index]),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
