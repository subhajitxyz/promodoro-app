// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// class BreakPage extends StatefulWidget {
//   final int breakTimeArg;
//
//   const BreakPage({super.key, required this.breakTimeArg});
//
//   @override
//   State<BreakPage> createState() => _BreakPageState();
// }
//
// class _BreakPageState extends State<BreakPage> {
//   int breakTime = 5;
//   bool isRunning = true;
//   Duration remainingTime = const Duration(minutes: 5);
//   Timer? timer;
//
//   @override
//   void initState() {
//     super.initState();
//     breakTime = widget.breakTimeArg;
//     remainingTime = Duration(minutes: breakTime);
//     timer = Timer.periodic(
//       const Duration(seconds: 1),
//       (timer) {
//         if (remainingTime.inSeconds == 0) {
//           timer.cancel();
//           isRunning = false;
//           Navigator.of(context).pop();
//         } else {
//           remainingTime -= const Duration(seconds: 1);
//         }
//         setState(() {});
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.red,
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 50,
//               ),
//
//               const Icon(Icons.coffee_outlined, size: 100, color: Colors.white),
//
//               // timer
//               Text(
//                 durationToTimeString(remainingTime),
//                 style: const TextStyle(
//                   fontSize: 100,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontFamily: 'Digital',
//                 ),
//               ),
//               // const SizedBox(height: 5),
//               Card(
//                 elevation: 10,
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   child: LinearProgressIndicator(
//                     value: remainingTime.inSeconds / (breakTime * 60),
//                     color: Colors.white,
//                     backgroundColor: Colors.grey.shade500,
//                     minHeight: 10,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 70),
//
//               // cancel button
//               GestureDetector(
//                 onTap: () {
//                   timer?.cancel();
//                   Navigator.of(context).pop();
//                 },
//                 child: Card(
//                   elevation: 20,
//                   child: Container(
//                     width: 200,
//                     height: 100,
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       border: Border.all(
//                         color: Colors.white,
//                         width: 2,
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Text(
//                       "CANCEL",
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// String durationToTimeString(Duration currentTime) {
//   String seconds =
//       currentTime.inSeconds.remainder(60).toString().padLeft(2, '0');
//   String minutes =
//       currentTime.inMinutes.remainder(60).toString().padLeft(2, '0');
//   return '$minutes:$seconds';
// }
