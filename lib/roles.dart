// import 'package:flutter/material.dart';
// import 'package:work_permit/globalvarialbles.dart';
// import 'package:work_permit/login/admin_login.dart';
// import 'package:work_permit/login/login.dart';

// class Roles extends StatefulWidget {
//   const Roles({super.key});

//   @override
//   State<Roles> createState() => _RolesState();
// }

// class _RolesState extends State<Roles> {
//   bool _isAnimated = false;

//   @override
//   void initState() {
//     super.initState();
//     // Trigger the animation after a short delay
//     Future.delayed(Duration(milliseconds: 300), () {
//       setState(() {
//         _isAnimated = true;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: bodyColor,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Spacer(
//                 flex: 1,
//               ),
//               AnimatedOpacity(
//                 opacity: _isAnimated ? 1.0 : 0.0,
//                 duration: Duration(milliseconds: 500),
//                 curve: Curves.easeIn,
//                 child: Image.asset(
//                   'assets/images/role.png',
//                   height: 200,
//                 ),
//               ),
//               const SizedBox(
//                 height: 100,
//               ),
//               AnimatedOpacity(
//                 opacity: _isAnimated ? 1.0 : 0.0,
//                 duration: Duration(milliseconds: 800),
//                 curve: Curves.easeIn,
//                 child: SizedBox(
//                   width: 300,
//                   height: 37,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: maincolor),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const AdminLogin()));
//                     },
//                     child: const Text('Admin'),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               AnimatedOpacity(
//                 opacity: _isAnimated ? 1.0 : 0.0,
//                 duration: Duration(milliseconds: 1100),
//                 curve: Curves.easeIn,
//                 child: SizedBox(
//                   width: 300,
//                   height: 37,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: maincolor),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const UserLogin()));
//                     },
//                     child: const Text('User'),
//                   ),
//                 ),
//               ),
//               Spacer(
//                 flex: 1,
//               )
//             ],
//           ),
//         ));
//   }
// }
