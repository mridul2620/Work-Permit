// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'form_provider.dart';

// class QuestionnairePage extends StatefulWidget {
//   @override
//   State<QuestionnairePage> createState() => _QuestionnairePageState();
// }

// class _QuestionnairePageState extends State<QuestionnairePage>
//     with TickerProviderStateMixin {
//   late List<AnimationController> _controllers;
//   late List<Animation<Offset>> _offsetAnimations;

//   @override
//   void initState() {
//     super.initState();
//     final formProvider = Provider.of<FormStateProvider>(context, listen: false);
//     final questions = formProvider.questions;

//     _controllers = List.generate(
//       questions.length,
//       (index) => AnimationController(
//         duration: const Duration(seconds: 1),
//         vsync: this,
//       ),
//     );

//     _offsetAnimations = List.generate(
//       questions.length,
//       // (index) => Tween<Offset>
//         begin: Offset(-1, 0),
//         end: Offset(0, 0),
//       ).animate(
//         CurvedAnimation(
//           parent: _controllers[index],
//           curve: Curves.easeInOut,
//         ),
//       ),
//     );

//     // Start the animations with a delay
//     for (int i = 0; i < questions.length; i++) {
//       Future.delayed(Duration(milliseconds: i * 500), () {
//         _controllers[i].forward();
//       });
//     }
//   }

//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final formProvider = Provider.of<FormStateProvider>(context);
//     final questions = formProvider.questions;

//     return ListView.builder(
//       itemCount: questions.length,
//       itemBuilder: (context, index) {
//         return AnimatedBuilder(
//           animation: _controllers[index],
//           builder: (context, child) {
//             return SlideTransition(
//               position: _offsetAnimations[index],
//               child: Card(
//                 margin: EdgeInsets.all(16),
//                 elevation: 4,
//                 child: Column(
//                   children: [
//                     ListTile(
//                       title: Text(questions[index].text),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Radio(
//                           value: true,
//                           groupValue: questions[index].answer,
//                           onChanged: (value) {
//                             formProvider.updateAnswer(index, value);
//                           },
//                         ),
//                         Text("Yes"),
//                         Radio(
//                           value: false,
//                           groupValue: questions[index].answer,
//                           onChanged: (value) {
//                             formProvider.updateAnswer(index, value);
//                           },
//                         ),
//                         Text("No"),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
