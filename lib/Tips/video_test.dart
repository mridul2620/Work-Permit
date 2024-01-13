import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:work_permit/globalvarialbles.dart';
import '../fonts/fonts.dart';
import 'video_model.dart';

class VideosTest extends StatefulWidget {
  const VideosTest({super.key});

  @override
  State<VideosTest> createState() => _VideosTestState();
}

class _VideosTestState extends State<VideosTest> {
  late VideoPlayerController _controller;
  int _currentIndex = 1;
  List<Video> _videosTest = [];
  bool _isLoading = true;
  bool _showButtons = true;
  late Timer _timer;

  void _playVideo({int index = 0, bool init = false}) {
    if (index < 0 || index >= _videosTest.length) return;
    if (!init) {
      _controller.play();
    }
    setState(() {
      _currentIndex = index;
    });
    _controller =
        // ignore: deprecated_member_use
        VideoPlayerController.network(_videosTest[_currentIndex].url)
          ..addListener(() => setState(() {}))
          ..setLooping(true)
          ..initialize().then((value) => _controller.play());
    if (_timer.isActive) {
      _timer.cancel();
    }
    _timer = Timer(Duration(seconds: 2), () {
      setState(() {
        _showButtons = false;
      });
    });
  }

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inMinutes.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  Future<void> _fetchVideosTest() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      final videosTest = await fetchVideos(token!);
      setState(() {
        _videosTest = videosTest;
        _isLoading = false;
      });
      _playVideo(init: true);
    } catch (error) {
      print('Error fetching videosTest: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _playVideo(init: true);
    _fetchVideosTest();
    _showButtons = true;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: maincolor,
                valueColor:
                    AlwaysStoppedAnimation(Color.fromARGB(255, 220, 216, 216)),
                strokeWidth: 4,
              ),
            )
          : Column(
              children: [
                Container(
                    decoration: _controller.value.isInitialized
                        ? BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  maincolor.withOpacity(0.8),
                                  Colors.black.withOpacity(0.9),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.center),
                          )
                        : BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  gradientColor1.withOpacity(0.8),
                                  gradientColor2.withOpacity(0.9),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                    //height: 220,
                    child: Column(
                      children: [
                        _controller.value.isInitialized
                            ? Stack(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 190,
                                        child: VideoPlayer(_controller),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ValueListenableBuilder(
                                              valueListenable: _controller,
                                              builder: (context,
                                                  VideoPlayerValue value,
                                                  child) {
                                                return Text(
                                                  _videoDuration(
                                                      value.position),
                                                  style: GoogleFonts.secularOne(
                                                      textStyle: normalstyle,
                                                      color: Colors.white,
                                                      fontSize: 13),
                                                );
                                              }),
                                          Expanded(
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                height: 5,
                                                child: VideoProgressIndicator(
                                                    _controller,
                                                    allowScrubbing: true,
                                                    colors: VideoProgressColors(
                                                        playedColor: maincolor,
                                                        bufferedColor:
                                                            Colors.white60),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8))),
                                          ),
                                          Text(
                                            _videoDuration(
                                                _controller.value.duration),
                                            style: GoogleFonts.secularOne(
                                                textStyle: normalstyle,
                                                color: Colors.white,
                                                fontSize: 13),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 75,
                                    left: MediaQuery.of(context).size.width /
                                        2.25,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _showButtons = !_showButtons;
                                        });
                                        if (_controller.value.isPlaying) {
                                          _controller.pause();
                                        } else {
                                          _controller.play();
                                        }
                                      },
                                      child: Visibility(
                                        visible: _showButtons,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.transparent
                                                  .withOpacity(0.6)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2,
                                                right: 6,
                                                top: 1,
                                                bottom: 5),
                                            child: IconButton(
                                                onPressed: () =>
                                                    _controller.value.isPlaying
                                                        ? _controller.pause()
                                                        : _controller.play(),
                                                icon: Icon(
                                                  _controller.value.isPlaying
                                                      ? Icons.pause
                                                      : Icons.play_arrow,
                                                  color: Colors.white,
                                                  size: 40,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                height: 220,
                                padding: const EdgeInsets.only(
                                    left: 20, top: 25, right: 20),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Start Learning",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        "Let's get started with",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        "some Tips and Safety Videos",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 45,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.timer_outlined,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "60 mins",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                          Expanded(child: Container()),
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        color: Colors.black,
                                                        blurRadius: 10,
                                                        offset: Offset(4, 8))
                                                  ]),
                                              child: const Icon(
                                                Icons.play_circle_fill,
                                                size: 60,
                                                color: Colors.white,
                                              ))
                                        ],
                                      ),
                                    ]),
                              ),
                      ],
                    )),
                Expanded(
                    child: Container(
                  decoration: const BoxDecoration(
                    color: bodyColor,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: _videosTest.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () {
                                    _playVideo(index: index);
                                  },
                                  child: Card(
                                    color: const Color(0xFFF4F4F4),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Stack(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10)),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      _videosTest[index]
                                                          .thumbnail,
                                                    ),
                                                    fit: BoxFit.fill,
                                                  )),
                                              height: 60,
                                              width: 75,
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _videosTest[index].title,
                                                    style:
                                                        GoogleFonts.secularOne(
                                                            textStyle:
                                                                normalstyle),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    _videosTest[index].subtitle,
                                                    style:
                                                        GoogleFonts.secularOne(
                                                      textStyle: softnormal,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                            left: 26,
                                            top: 20,
                                            child: Icon(
                                              Icons.play_arrow,
                                              size: 30,
                                              color: Colors.white,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ))
              ],
            ),
    );
  }
}
