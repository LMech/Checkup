// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ChatBox extends StatelessWidget {
//   final String? message;
//   final bool? type;
//   final BuildContext? context;
//   const ChatBox({this.message, this.type, this.context})

//   static DateTime now = DateTime.now();
//   static String time = DateFormat('H:mm').format(now);

//   @override
//   Widget build(BuildContext context) {
//     return type ? sendBox(message) : receiveBox(message);
//   }

//   Widget sendBox(String message) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: <Widget>[
//         Container(
//           padding: const EdgeInsets.all(8),
//           margin: const EdgeInsets.all(5),
//           alignment: Alignment.centerRight,
//           decoration: BoxDecoration(
//             color: const Color(0xff2980b9),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: <Widget>[
//               Text(
//                 message,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 17,
//                 ),
//               ),
//               Text(
//                 time,
//                 style: const TextStyle(color: Colors.white38, fontSize: 13),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget receiveBox(String message) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[
//         Container(
//           padding: const EdgeInsets.all(8),
//           margin: const EdgeInsets.all(5),
//           alignment: Alignment.centerRight,
//           decoration: BoxDecoration(
//             color: const Color(0xff34495e),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 message,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 17,
//                 ),
//               ),
//               Text(
//                 time,
//                 style: const TextStyle(color: Colors.white38, fontSize: 13),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
