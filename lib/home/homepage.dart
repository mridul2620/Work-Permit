import 'package:flutter/material.dart';
import 'package:work_permit/Profile/demoProfile.dart';
import 'package:work_permit/Profile/profile.dart';
import 'package:work_permit/Status/status.dart';
import 'package:work_permit/Tips/tips.dart';
import 'package:work_permit/globalvarialbles.dart';
import 'package:work_permit/home/landingpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  SharedPreferences? prefs;
  bool isScreenPopulated = false;
  List screen = [
    const LandingPage(),
    const Status(),
    const Tips(),
    ProfilePage()
  ];

  int currpage = 0;
  String number = "";
  String profilePicture = '';
  String name = '';
  int? parentId=0;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      profilePicture = prefs.getString('profilePicture') ?? '';
      name = prefs.getString('name') ?? '';
      parentId = prefs.getInt('parent_id');
      print(parentId);
      print(name);
      _updateScreenList();
    });
  }

  void _updateScreenList() {
    switch (parentId) {
      case -1:
        screen = [
          const LandingPage(),
          const Status(),
          const Tips(),
          DemoProfile()
        ];
        break;
      default:
        screen = [
          const LandingPage(),
          const Status(),
          const Tips(),
          ProfilePage()
        ];
        break;
    }
    setState(() {
      isScreenPopulated = true; // Mark that the screen list is now populated
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: maincolor),
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/appbar.png',
          width: 161,
          height: 51,
        ),
        centerTitle: true,
      ),
      drawer: AppDrawer(name: name, pic: profilePicture),
      body: isScreenPopulated
          ? screen[_index]
          : const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor:
                    AlwaysStoppedAnimation(Color.fromARGB(255, 220, 216, 216)),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          selectedFontSize: 12,
          selectedIconTheme: const IconThemeData(color: maincolor),
          selectedItemColor: maincolor,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          backgroundColor: Colors.transparent,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.computer_outlined,
              ),
              label: 'Status',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.checklist_rtl_rounded,
              ),
              label: 'Tips',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_3_sharp,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _index,
          onTap: (value) {
            setState(() {
              _index = value;
            });
          }),
    );
  }
}
