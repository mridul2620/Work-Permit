import 'package:flutter/material.dart';
import 'package:work_permit/Tips/images.dart';
import 'package:work_permit/Tips/video_test.dart';
//import 'package:work_permit/Tips/video_test.dart';
//import 'package:work_permit/Tips/videos.dart';
import 'package:work_permit/globalvarialbles.dart';

class Tips extends StatefulWidget {
  const Tips({super.key});

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: TabBar(
              dividerColor: maincolor,
              labelColor: maincolor,
              indicatorColor: maincolor,
              indicatorWeight: 2,
              tabs: [
                Tab(
                  //icon: Icon(Icons.today),
                  text: "Videos",
                ),
                Tab(
                  //icon: Icon(Icons.model_training_outlined),
                  text: "Images",
                )
              ]),
          body: TabBarView(
            children: [VideosTest(), Images()],
          )),
    );
  }
}
