import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:work_permit/globalvarialbles.dart';

class Videos extends StatefulWidget {
  const Videos({super.key});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  
  Duration? _duration;
  Duration? _position;
  bool play = false;
  bool _isplaying = false;
  int _isplayingIndex = -1;
  bool _disposed = false;
  List info = [];
  VideoPlayerController? _controller;
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/videos.json")
        .then((value) {
      setState(() {
        info = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: play == false
            ? BoxDecoration(
                gradient: LinearGradient(colors: [
                  maincolor.withOpacity(0.8),
                  Colors.black.withOpacity(0.9),
                ], begin: Alignment.topCenter, end: Alignment.center),
              )
            : BoxDecoration(
                gradient: LinearGradient(colors: [
                  gradientColor1.withOpacity(0.8),
                  gradientColor2.withOpacity(0.9),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
        //margin: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            play == false
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    padding:
                        const EdgeInsets.only(left: 20, top: 25, right: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Start Learning",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Let's get started with",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "some Tips and Tricks",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
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
                                        color: Colors.white, fontSize: 12),
                                  )
                                ],
                              ),
                              Expanded(child: Container()),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
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
                  )
                : Container(
                    child: Column(
                    children: [
                      _playView(context),
                      _controlView(context),
                    ],
                  )),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                  color: bodyColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                  )),
              child: Column(
                children: [Expanded(child: _listView())],
              ),
            ))
          ],
        ),
      ), 
    );
  }

  _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return const AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
              child: Text(
            "Prepairing...",
            style: TextStyle(fontSize: 16, color: Colors.white),
          )));
    }
  }

  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  _controlView(BuildContext context) {
    final noMute = (_controller?.value.volume ?? 0) > 0;
    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = convertTwo(remained ~/ 60.0);
    final secs = convertTwo((remained % 60.0).round());
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.red[700],
              inactiveTrackColor: Colors.red[100],
              trackShape: const RoundedRectSliderTrackShape(),
              trackHeight: 2.0,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
              thumbColor: Colors.redAccent,
              overlayColor: Colors.red.withAlpha(32),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 2),
              tickMarkShape: const RoundSliderTickMarkShape(),
              activeTickMarkColor: Colors.red[700],
              inactiveTickMarkColor: Colors.red[100],
              valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Colors.redAccent,
              valueIndicatorTextStyle: const TextStyle(color: Colors.white)),
          child: Slider(
            value: max(0, min(_progress * 100, 100)),
            min: 0,
            max: 10,
            divisions: 100,
            label: _position?.toString().split(".")[0],
            onChanged: (value) {
              setState(() {
                _progress = value * 0.01;
              });
            },
            onChangeStart: (value) {
              _controller?.pause();
            },
            onChangeEnd: (value) {
              final duration = _controller?.value.duration;
              if (duration != null) {
                var newValue = max(0, min(value, 99)) * 0.01;
                var millis = (duration.inMicroseconds * newValue);
                _controller?.seekTo(Duration(milliseconds: millis.round()));
                _controller?.play();
              }
            },
          ),
        ),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 5),
          color: gradientColor2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (noMute) {
                    _controller?.setVolume(0);
                  } else {
                    _controller?.setVolume(1.0);
                  }
                  setState(() {});
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Container(
                    decoration:
                        const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 4,
                          color: Color.fromARGB(50, 0, 0, 0))
                    ]),
                    child: Icon(
                      noMute ? Icons.volume_up : Icons.volume_off,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    final index = _isplayingIndex - 1;
                    if (index >= 0 && info.length >= 0) {
                      _initailizeVideo(index);
                    } else {
                      Get.snackbar("Video", "",
                          snackPosition: SnackPosition.BOTTOM,
                          icon: const Icon(
                            Icons.face_6_sharp,
                            size: 20,
                            color: Colors.white,
                          ),
                          backgroundColor: gradientColor2,
                          colorText: Colors.white,
                          messageText: const Text(
                            "No videos ahead !",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ));
                    }
                  },
                  child: const Icon(
                    Icons.fast_rewind,
                    size: 36,
                    color: Colors.white,
                  )),
              ElevatedButton(
                  onPressed: () async {
                    if (_isplaying) {
                      setState(() {
                        _isplaying = false;
                      });
                      _controller?.pause();
                    } else {
                      setState(() {
                        _isplaying = true;
                      });
                      _controller?.play();
                    }
                  },
                  child: Icon(
                    _isplaying ? Icons.pause : Icons.play_arrow,
                    size: 36,
                    color: Colors.white,
                  )),
              ElevatedButton(
                  onPressed: () {
                    final index = _isplayingIndex + 1;
                    if (index <= info.length - 1) {
                      _initailizeVideo(index);
                    } else {
                      Get.snackbar("Video", "",
                          snackPosition: SnackPosition.BOTTOM,
                          icon: const Icon(
                            Icons.face_6_sharp,
                            size: 20,
                            color: Colors.white,
                          ),
                          backgroundColor: gradientColor2,
                          colorText: Colors.white,
                          messageText: const Text(
                            "You finished watching all the videos",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ));
                    }
                  },
                  child: const Icon(
                    Icons.fast_forward,
                    size: 36,
                    color: Colors.white,
                  )),
              Text(
                "$mins:$secs",
                style: const TextStyle(color: Colors.white, shadows: [
                  Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 4,
                      color: Color.fromARGB(150, 0, 0, 0))
                ]),
              )
            ],
          ),
        ),
      ],
    );
  }

  // ignore: prefer_typing_uninitialized_variables
  var _onupdateControllerTime;
  var _progress = 0.0;
  void _onControllerUpdate() async {
    if (_disposed) {
      return;
    }
    _onupdateControllerTime = 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_onupdateControllerTime > now) {
      return;
    }
    _onupdateControllerTime = now + 500;
    final controller = _controller;
    if (controller == null) {
      debugPrint("controller is null");
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint("controller cannot be initialized");
      return;
    }
    if (_duration == null) {
      _duration = _controller?.value.duration;
    }
    var duration = _duration;
    if (duration == null) return;
    var position = await controller.position;
    _position = position;
    final playing = controller.value.isPlaying;
    if (playing) {
      if (_disposed) return;
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble() /
            duration.inMicroseconds.ceilToDouble();
      });
    }
    _isplaying = playing;
  }

  _initailizeVideo(int index) async {
    final controller =
        VideoPlayerController.networkUrl(Uri.parse(info[index]["url"]));
    print(controller);
    _controller = controller;
    final oldController = _controller;
    if (oldController != null) {
      oldController.removeListener(_onControllerUpdate);
      oldController.pause();
    }
    setState(() {
      controller..initialize().then((_) {
        oldController?.dispose();
        _isplayingIndex = index;
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
    });
  }

  _onTapVideo(int index) async {
    _initailizeVideo(index);
  }

  _listView() {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        itemCount: info.length,
        itemBuilder: (_, int index) {
          return GestureDetector(
              onTap: () {
                _onTapVideo(index);
                debugPrint(index.toString());
                setState(() {
                  if (play == false) {
                    play = true;
                  }
                });
              },
              child: _buildCard(index));
        });
  }

  _buildCard(int index) {
    return Container(
      height: 115,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(info[index]["thumbnail"]),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(info[index]["title"]),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      info[index]["time"],
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
