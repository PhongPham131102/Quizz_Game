// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:init_firebase/objects/Profile.dart';

// class AlReady extends StatefulWidget {
//   AlReady(
//       {super.key,
//       required this.roomid,
//       required this.user1,
//       required this.user2,
//       required this.index});
//   String roomid;
//   String user1;
//   String user2;
//   int index;
//   @override
//   State<AlReady> createState() => _AlReadyState();
// }

// class _AlReadyState extends State<AlReady> {
//   final users = FirebaseFirestore.instance.collection('users').doc().get();

//   @override
//   Widget build(BuildContext context) {
//     double _height = MediaQuery.of(context).size.height;
//     double _width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       resizeToAvoidBottomInset:
//           false, //khi bàn phím xuất hiện sẽ không làm vỡ layout của giao diện
//       body: Container(
//         width: _width,
//         height: _height,
//         padding: EdgeInsets.only(bottom: 30),
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('img/background2.png'), fit: BoxFit.fill),
//         ),
//         child: FutureBuilder<DocumentSnapshot>(
//           future: FirebaseFirestore.instance
//               .collection('profiles')
//               .doc(this.widget.user1)
//               .get(),
//           builder:
//               (BuildContext context, AsyncSnapshot<DocumentSnapshot> user1) {
//             if (user1.connectionState == ConnectionState.done) {
//               Map<String, dynamic> dataus1 =
//                   user1.data!.data() as Map<String, dynamic>;
//               return FutureBuilder<DocumentSnapshot>(
//                   future: FirebaseFirestore.instance
//                       .collection('profiles')
//                       .doc(this.widget.user2)
//                       .get(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<DocumentSnapshot> user2) {
//                     if (user2.connectionState == ConnectionState.done) {
//                       Map<String, dynamic> dataus2 =
//                           user2.data!.data() as Map<String, dynamic>;
//                       final us1;
//                       final us2;
//                       if (this.widget.index == 1) {
//                         us1 = dataus1;
//                         us2 = dataus2;
//                       } else {
//                         us2 = dataus1;
//                         us1 = dataus2;
//                       }
//                       return ReadyTime(
//                           roomid: this.widget.roomid,
//                           user1: us1,
//                           user2: us2,
//                           index: this.widget.index);
//                     }
//                     return Container();
//                   });
//             }

//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }

// class ReadyTime extends StatefulWidget {
//   ReadyTime(
//       {super.key,
//       required this.roomid,
//       required this.user1,
//       required this.user2,
//       required this.index});
//   String roomid;
//   final user1;
//   final user2;
//   int index;
//   @override
//   State<ReadyTime> createState() => _ReadyTimeState();
// }

// class _ReadyTimeState extends State<ReadyTime> {
//   @override
//   Widget build(BuildContext context) {
//     double _height = MediaQuery.of(context).size.height;
//     double _width = MediaQuery.of(context).size.width;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Container(
//           alignment: Alignment.center,
//           width: _width,
//           height: _height - (_height - _height / 3.3),
//           child: const Text(
//             'ĐÃ TÌM THẤY TRẬN...',
//             style: TextStyle(
//                 shadows: [
//                   Shadow(
//                     offset: Offset(5, 3),
//                     blurRadius: 10,
//                     color: Colors.black,
//                   ),
//                 ],
//                 color: Color.fromARGB(255, 255, 255, 255),
//                 fontFamily: 'Mono',
//                 fontSize: 20,
//                 fontWeight: FontWeight.w800),
//           ),
//         ),
//         Stack(
//           children: [
//             Container(
//               width: _width,
//               height: _height - (_height - _height / 1.75),
//             ),
//             Positioned(
//               top: 20,
//               left: 5,
//               child: Stack(
//                 children: [
//                   Container(
//                     height: 120,
//                     width: 280,
//                   ),
//                   Positioned(
//                     top: 10,
//                     child: Container(
//                       width: 280,
//                       height: 110,
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage('img/leftframe.png'),
//                             fit: BoxFit.fill),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 20,
//                     top: 0,
//                     child: CircleAvatar(
//                       backgroundImage:
//                           AssetImage('${this.widget.user1['avatar']}'),
//                       radius: 35,
//                     ),
//                   ),
//                   Positioned(
//                     top: 35,
//                     left: 100,
//                     child: Text(
//                       '${this.widget.user1['character_name']}',
//                       style: TextStyle(
//                           shadows: [
//                             Shadow(
//                               offset: Offset(5, 3),
//                               blurRadius: 10,
//                               color: Colors.black,
//                             ),
//                           ],
//                           color: Color.fromARGB(255, 255, 255, 255),
//                           fontFamily: 'Mono',
//                           fontSize: 17,
//                           fontWeight: FontWeight.w800),
//                     ),
//                   ),
//                   Positioned(
//                     top: 60,
//                     left: 90,
//                     child: Text(
//                       '${this.widget.user1['rank']}',
//                       style: TextStyle(
//                           shadows: [
//                             Shadow(
//                               offset: Offset(5, 3),
//                               blurRadius: 10,
//                               color: Colors.black,
//                             ),
//                           ],
//                           color: Color.fromARGB(255, 241, 244, 54),
//                           fontFamily: 'Mono',
//                           fontSize: 13,
//                           fontWeight: FontWeight.w800),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Positioned(
//               top: (_height - (_height - _height / 1.75)) / 3.2,
//               right: _width / 2.2,
//               child: const Text(
//                 'VS',
//                 style: TextStyle(
//                     shadows: [
//                       Shadow(
//                         offset: Offset(5, 3),
//                         blurRadius: 10,
//                         color: Colors.black,
//                       ),
//                     ],
//                     color: Color.fromARGB(255, 241, 244, 54),
//                     fontFamily: 'Mono',
//                     fontSize: 30,
//                     fontWeight: FontWeight.w800),
//               ),
//             ),
//             Positioned(
//               top: 160,
//               right: 5,
//               child: Stack(
//                 children: [
//                   Container(
//                     height: 120,
//                     width: 280,
//                   ),
//                   Positioned(
//                     top: 10,
//                     child: Container(
//                       width: 280,
//                       height: 110,
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage('img/rightframe.png'),
//                             fit: BoxFit.fill),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     right: 20,
//                     top: 0,
//                     child: CircleAvatar(
//                       backgroundImage:
//                           AssetImage('${this.widget.user2['avatar']}'),
//                       radius: 35,
//                     ),
//                   ),
//                   Positioned(
//                     top: 35,
//                     right: 100,
//                     child: Text(
//                       '${this.widget.user2['character_name']}',
//                       style: TextStyle(
//                           shadows: [
//                             Shadow(
//                               offset: Offset(5, 3),
//                               blurRadius: 10,
//                               color: Colors.black,
//                             ),
//                           ],
//                           color: Color.fromARGB(255, 255, 255, 255),
//                           fontFamily: 'Mono',
//                           fontSize: 17,
//                           fontWeight: FontWeight.w800),
//                     ),
//                   ),
//                   Positioned(
//                     top: 60,
//                     right: 90,
//                     child: Text(
//                       '${this.widget.user2['rank']}',
//                       style: TextStyle(
//                           shadows: [
//                             Shadow(
//                               offset: Offset(5, 3),
//                               blurRadius: 10,
//                               color: Colors.black,
//                             ),
//                           ],
//                           color: Color.fromARGB(255, 241, 244, 54),
//                           fontFamily: 'Mono',
//                           fontSize: 13,
//                           fontWeight: FontWeight.w800),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Positioned(
//               right: _width / 2.5,
//               bottom: 30,
//               child: InkWell(
//                 onTap: () {
//                   // Navigator.push(context,
//                   // MaterialPageRoute(builder: (context) => const PlayPvp()));
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   width: 80,
//                   height: 80,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage('img/tigerload.gif'), fit: BoxFit.fill),
//                   ),
                 
//                 ),
//               ),
//             )
//           ],
//         ),
//         Container(
//           width: 180,
//           height: 60,
//           alignment: Alignment.center,
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage('img/button2.png'), fit: BoxFit.fill)),
//           child: InkWell(
//             child: const Text(
//               'Đã Sẵn Sàng',
//               style: TextStyle(
//                   shadows: [
//                     Shadow(
//                       offset: Offset(5, 3),
//                       blurRadius: 10,
//                       color: Colors.black,
//                     ),
//                   ],
//                   color: Colors.white,
//                   fontFamily: 'Mono',
//                   fontSize: 20,
//                   fontWeight: FontWeight.w800),
//             ),
//             onTap: () {},
//           ),
//         ),
//       ],
//     );
//   }
// }
