import 'dart:async';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:init_firebase/function/rankonline.dart';
import 'package:init_firebase/objects/Profile.dart';
import 'package:init_firebase/result.dart';

import 'objects/Online.dart';

// class ReadyPlayPvP extends StatefulWidget {
//   ReadyPlayPvP(
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
//   State<ReadyPlayPvP> createState() => _ReadyPlayPvPState();
// }

// class _ReadyPlayPvPState extends State<ReadyPlayPvP> {
//   final users = FirebaseFirestore.instance.collection('users').doc().get();
//   @override
//   void initState() {
//     super.initState();
//   }

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
//                       return PlayPvp(
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

class PlayPvp extends StatefulWidget {
  PlayPvp(
      {super.key,
      required this.roomid,
      required this.user1,
      required this.user2,
      required this.index});
  String roomid;
  final user1;
  final user2;
  int index;
  @override
  State<PlayPvp> createState() => _PlayPvpState();
}

class _PlayPvpState extends State<PlayPvp> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('room');
  // List<Room> rooms = [];
  // void retrieveStudentData() {
  //   dbRef.child("room").onValue.listen((data) {
  //         Map<dynamic, dynamic> messages = data.snapshot.value as Map;
  //     messages.forEach((key, value) {
  //       Room rom = Room.fromJson(value);
  //       rooms.add(rom);
  //     });
  //     setState(() {});
  //   });
  // }

  @override
  void initState() {
    coutdown();
    you = this.widget.index;
    notyou = you == 1 ? 2 : 1;
    gold = this.widget.user1['gold'];
    totalgold = this.widget.user1['gold'];
    setState(() {});
    super.initState();
  }

  int scoreyou = 0;
  int scorenotyou = 0;
  bool stop = false;
  int time = 10;
  int totaltime = 50;
  Timer? timer;
  void start() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (totaltime == 0) {
        timer?.cancel();
        if (scoreyou > scorenotyou) {
          List<String> temp = Uprank(
              this.widget.user1['rank'], this.widget.user1['rank_detail']);
          int star = this.widget.user1['star'];
          star++;
          final doc = FirebaseFirestore.instance
              .collection('profiles')
              .doc("${this.widget.user1['id']}");
          doc.update({
            'rank': temp[0],
            "rank_detail": temp[1],
            "gold": gold,
            "star": star
          });
        } else if (scoreyou < scorenotyou) {
          List<String> temp = Downrank(
              this.widget.user1['rank'], this.widget.user1['rank_detail']);
          final doc = FirebaseFirestore.instance
              .collection('profiles')
              .doc("${this.widget.user1['id']}");
          int star = this.widget.user1['star'];
          if (star > 1) {
            star--;
            doc.update({
              'rank': temp[0],
              "rank_detail": temp[1],
              "gold": gold,
              "star": star
            });
          } else {
            doc.update({'rank': temp[0], "rank_detail": temp[1], "gold": gold});
          }
        }
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultMath(
                  roomid: this.widget.roomid,
                  user1: this.widget.user1,
                  user2: this.widget.user2,
                  scoreyou: scoreyou,
                  scorenotyou: scorenotyou)),
        );
      } else if (time == 0) {
        score = 0;
        time = 10;
        ++i;
        if (i == 5) {
          x2score = 2;
        } else {
          x2score = 1;
        }
        pick1 = false;
        pick2 = false;
        pick3 = false;
        pick4 = false;
        fuc1 = true;
        fuc2 = true;
        fuc3 = true;
        fuc4 = true;
        pick = false;

        youranwser = "";
        setState(() {});
      } else {
        totaltime--;
        time--;
        setState(() {});
      }
    });
  }

  Timer? timercoutdown;
  int timecoutdown = 4;
  void coutdown() {
    timercoutdown = Timer.periodic(Duration(seconds: 1), (_) {
      if (timecoutdown == 0) {
        startnow = false;
        start();
        setState(() {});
        timercoutdown?.cancel();
      } else {
        timecoutdown--;
        setState(() {});
      }
    });
  }

  bool startnow = true;
  int? you;
  int? notyou;
  int? gold;
  int? totalgold;
  int i = 1;
  int score = 0;
  bool fuc1 = true;
  bool fuc2 = true;
  bool fuc3 = true;
  bool fuc4 = true;
  bool fuc_5050 = true;
  bool fuc_master = true;
  bool fuc_x2 = true;
  bool fuc_time = true;
  String youranwser = "";
  bool pick = false;
  int x2score = 1;
  bool pick1 = false;
  bool pick2 = false;
  bool pick3 = false;
  bool pick4 = false;
  void updategold() {
    if (gold! < 250) {
      fuc_master = false;
    }
    if (gold! < 200) {
      fuc_x2 = false;
    }
    if (gold! < 100) {
      fuc_5050 = false;
    }
    if (gold! < 50) {
      fuc_time = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset:
            false, //khi bàn phím xuất hiện sẽ không làm vỡ layout của giao diện
        body: Container(
            width: _width,
            height: _height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('img/background2.png'), fit: BoxFit.fill),
            ),
            child: startnow
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        Container(
                            height: MediaQuery.of(context).size.height - 300,
                            child: Center(
                              child: timecoutdown == 0
                                  ? Text(
                                      'Bắt Đầu',
                                      style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              offset: Offset(5, 3),
                                              blurRadius: 10,
                                              color: Colors.black,
                                            ),
                                          ],
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontFamily: 'Mono',
                                          fontSize: 28,
                                          fontWeight: FontWeight.w800),
                                    )
                                  : Text(
                                      '${timecoutdown.toString()}',
                                      style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              offset: Offset(5, 3),
                                              blurRadius: 10,
                                              color: Colors.black,
                                            ),
                                          ],
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontFamily: 'Mono',
                                          fontSize: 28,
                                          fontWeight: FontWeight.w800),
                                    ),
                            )),
                        Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'img/light.png',
                                  height: 50,
                                  width: 50,
                                ),
                                const Text(
                                  'Mẹo Nhỏ Mách Bạn:',
                                  style: TextStyle(
                                      shadows: [
                                        Shadow(
                                          offset: Offset(5, 3),
                                          blurRadius: 10,
                                          color: Colors.black,
                                        ),
                                      ],
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontFamily: 'Mono',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            const Text(
                              'khi bạn gặp khó khăn trong việc tìm đáp  án có thể dùng xu để mua quyền trợ giúp nhé !!!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  shadows: [
                                    Shadow(
                                      offset: Offset(5, 3),
                                      blurRadius: 10,
                                      color: Colors.black,
                                    ),
                                  ],
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: 'Mono',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ])
                : FirebaseAnimatedList(
                    shrinkWrap: true,
                    query: dbRef,
                    itemBuilder: (context, snapshot, animation, nooo) {
                      if (snapshot.child('id').value == this.widget.roomid &&
                          snapshot.child('ready${notyou}').value == true) {
                        if (i == 5 && totaltime == 0) {
                          scoreyou = int.parse(snapshot
                              .child('totalscore${you}')
                              .value
                              .toString());
                          scorenotyou = int.parse(snapshot
                              .child('totalscore${notyou}')
                              .value
                              .toString());
                          print("$scoreyou" + "$scorenotyou");
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                15,
                                        height: 80,
                                      ),
                                      Positioned(
                                        bottom: 7,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              15,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'img/leftframe1.png'),
                                                fit: BoxFit.fill),
                                          ),
                                          child: Text(
                                            '${snapshot.child('totalscore${you}').value}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'UTM',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: 5,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              foregroundColor: Colors.red,
                                              backgroundImage: AssetImage(
                                                  '${this.widget.user1['avatar']}'),
                                              radius: 25,
                                            ),
                                            Text(
                                              '${this.widget.user1['character_name']}',
                                              style: TextStyle(
                                                  color: Colors.yellowAccent,
                                                  fontFamily: 'Mono',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: const Text(
                                      'VS',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'UTM',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                15,
                                        height: 80,
                                      ),
                                      Positioned(
                                        bottom: 7,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              15,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'img/rightframe1.png'),
                                                fit: BoxFit.fill),
                                          ),
                                          child: Text(
                                            '${snapshot.child('totalscore${notyou}').value}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'UTM',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 5,
                                        child: Row(
                                          children: [
                                            Text(
                                              '${this.widget.user2['character_name']}',
                                              style: TextStyle(
                                                  color: Colors.yellowAccent,
                                                  fontFamily: 'Mono',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            CircleAvatar(
                                              foregroundColor: Colors.red,
                                              backgroundImage: AssetImage(
                                                  '${this.widget.user2['avatar']}'),
                                              radius: 25,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('img/round.png'),
                                          fit: BoxFit.fill),
                                    ),
                                    child: Text(
                                      '$time',
                                      style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              offset: Offset(5, 3),
                                              blurRadius: 10,
                                              color: Colors.black,
                                            ),
                                          ],
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontFamily: 'UTM',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width - 20,
                              height: MediaQuery.of(context).size.height / 1.55,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: i == 5
                                        ? MainAxisAlignment.spaceBetween
                                        : MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(bottom: 5),
                                        width: 80,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(53, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          'câu $i/5',
                                          style: TextStyle(
                                            fontFamily: 'UTM',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      i == 5
                                          ? Container(
                                              alignment: Alignment.center,
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              width: 80,
                                              height: 38,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'img/cloud.png'),
                                                    fit: BoxFit.fill),
                                              ),
                                              child: Text(
                                                'câu hỏi đặc biệt',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Mono',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(25),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width -
                                          50,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(44, 254, 254, 254),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        snapshot
                                            .child('title$i')
                                            .value
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Mono',
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      )),
                                  Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        fuc1
                                            ? InkWell(
                                                onTap: () {
                                                  pick1 = true;
                                                  pick = true;
                                                  int newtotal = 0;
                                                  youranwser = "A";
                                                  if (snapshot
                                                              .child(
                                                                  'score${i}1')
                                                              .value ==
                                                          true &&
                                                      youranwser == "A") {
                                                    if (time == 0) {
                                                      score += x2score * 10;
                                                    } else {
                                                      score +=
                                                          x2score * 10 * time;
                                                    }
                                                  }
                                                  newtotal = int.parse(snapshot
                                                          .child(
                                                              'totalscore${you}')
                                                          .value
                                                          .toString()) +
                                                      score;
                                                  final postData = {
                                                    // "id":snapshot.child('id').value,
                                                    "totalscore${you}":
                                                        newtotal,
                                                    "answeruser${you}${i}":
                                                        snapshot
                                                            .child(
                                                                'answerText${i}1')
                                                            .value
                                                            .toString(),
                                                    "scoreqr${you}${i}": score,
                                                  };
                                                  FirebaseDatabase.instance
                                                      .ref(
                                                          'room/${snapshot.child('id').value}')
                                                      .update(postData);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: 50,
                                                      ),
                                                      Positioned(
                                                        left: 25,
                                                        right: 25,
                                                        child: InkWell(
                                                          child: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20),
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  70,
                                                              height: 50,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: pick
                                                                    ? snapshot.child('score${i}1').value ==
                                                                            true
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .red
                                                                    : Colors
                                                                        .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Text(
                                                                'A. ${snapshot.child('answerText${i}1').value}',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Mono",
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              )),
                                                        ),
                                                      ),
                                                      pick1
                                                          ? Positioned(
                                                              top: 5,
                                                              left: 5,
                                                              child:
                                                                  CircleAvatar(
                                                                foregroundColor:
                                                                    Colors.red,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        '${this.widget.user1['avatar']}'),
                                                                radius: 20,
                                                              ),
                                                            )
                                                          : Container(),
                                                      ((snapshot
                                                                      .child(
                                                                          'answeruser${you}${i}')
                                                                      .value
                                                                      .toString() !=
                                                                  "") &&
                                                              (snapshot
                                                                          .child(
                                                                              'answeruser${notyou}${i}')
                                                                          .value
                                                                          .toString() !=
                                                                      "" &&
                                                                  snapshot
                                                                          .child(
                                                                              'answeruser${notyou}${i}')
                                                                          .value
                                                                          .toString() ==
                                                                      snapshot
                                                                          .child(
                                                                              'answerText${i}1')
                                                                          .value
                                                                          .toString()))
                                                          ? Positioned(
                                                              top: 5,
                                                              right: 5,
                                                              child:
                                                                  CircleAvatar(
                                                                foregroundColor:
                                                                    Colors.red,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        '${this.widget.user2['avatar']}'),
                                                                radius: 20,
                                                              ),
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Stack(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 50,
                                                  ),
                                                  Positioned(
                                                    left: 25,
                                                    right: 25,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              70,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        fuc2
                                            ? InkWell(
                                                onTap: () {
                                                  pick = true;
                                                  pick2 = true;
                                                  int newtotal = 0;
                                                  youranwser = "B";
                                                  if (snapshot
                                                              .child(
                                                                  'score${i}2')
                                                              .value ==
                                                          true &&
                                                      youranwser == "B") {
                                                    if (time == 0) {
                                                      score += x2score * 10;
                                                    } else {
                                                      score +=
                                                          x2score * 10 * time;
                                                    }
                                                  }
                                                  newtotal = int.parse(snapshot
                                                          .child(
                                                              'totalscore${you}')
                                                          .value
                                                          .toString()) +
                                                      score;
                                                  final postData = {
                                                    // "id":snapshot.child('id').value,
                                                    "totalscore${you}":
                                                        newtotal,
                                                    "answeruser${you}${i}":
                                                        snapshot
                                                            .child(
                                                                'answerText${i}2')
                                                            .value
                                                            .toString(),
                                                    "scoreqr${you}${i}": score,
                                                  };
                                                  FirebaseDatabase.instance
                                                      .ref(
                                                          'room/${snapshot.child('id').value}')
                                                      .update(postData);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: 50,
                                                      ),
                                                      Positioned(
                                                        left: 25,
                                                        right: 25,
                                                        child: InkWell(
                                                          child: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20),
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  70,
                                                              height: 50,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: pick
                                                                    ? snapshot.child('score${i}2').value ==
                                                                            true
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .red
                                                                    : Colors
                                                                        .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Text(
                                                                'B. ${snapshot.child('answerText${i}2').value}',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Mono",
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              )),
                                                        ),
                                                      ),
                                                      pick2
                                                          ? Positioned(
                                                              top: 5,
                                                              left: 5,
                                                              child:
                                                                  CircleAvatar(
                                                                foregroundColor:
                                                                    Colors.red,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        '${this.widget.user1['avatar']}'),
                                                                radius: 20,
                                                              ),
                                                            )
                                                          : Container(),
                                                      ((snapshot
                                                                      .child(
                                                                          'answeruser${you}${i}')
                                                                      .value
                                                                      .toString() !=
                                                                  "") &&
                                                              (snapshot
                                                                          .child(
                                                                              'answeruser${notyou}${i}')
                                                                          .value
                                                                          .toString() !=
                                                                      "" &&
                                                                  snapshot
                                                                          .child(
                                                                              'answeruser${notyou}${i}')
                                                                          .value
                                                                          .toString() ==
                                                                      snapshot
                                                                          .child(
                                                                              'answerText${i}2')
                                                                          .value
                                                                          .toString()))
                                                          ? Positioned(
                                                              top: 5,
                                                              right: 5,
                                                              child:
                                                                  CircleAvatar(
                                                                foregroundColor:
                                                                    Colors.red,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        '${this.widget.user2['avatar']}'),
                                                                radius: 20,
                                                              ),
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Stack(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 50,
                                                  ),
                                                  Positioned(
                                                    left: 25,
                                                    right: 25,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              70,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        fuc3
                                            ? InkWell(
                                                onTap: () {
                                                  pick = true;
                                                  pick3 = true;
                                                  int newtotal = 0;
                                                  youranwser = "C";
                                                  if (snapshot
                                                              .child(
                                                                  'score${i}3')
                                                              .value ==
                                                          true &&
                                                      youranwser == "C") {
                                                    if (time == 0) {
                                                      score += x2score * 10;
                                                    } else {
                                                      score +=
                                                          x2score * 10 * time;
                                                    }
                                                  }
                                                  newtotal = int.parse(snapshot
                                                          .child(
                                                              'totalscore${you}')
                                                          .value
                                                          .toString()) +
                                                      score;
                                                  final postData = {
                                                    // "id":snapshot.child('id').value,
                                                    "totalscore${you}":
                                                        newtotal,
                                                    "answeruser${you}${i}":
                                                        snapshot
                                                            .child(
                                                                'answerText${i}3')
                                                            .value
                                                            .toString(),
                                                    "scoreqr${you}${i}": score,
                                                  };
                                                  FirebaseDatabase.instance
                                                      .ref(
                                                          'room/${snapshot.child('id').value}')
                                                      .update(postData);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: 50,
                                                      ),
                                                      Positioned(
                                                        left: 25,
                                                        right: 25,
                                                        child: InkWell(
                                                          child: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20),
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  70,
                                                              height: 50,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: pick
                                                                    ? snapshot.child('score${i}3').value ==
                                                                            true
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .red
                                                                    : Colors
                                                                        .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Text(
                                                                'C. ${snapshot.child('answerText${i}3').value}',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Mono",
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              )),
                                                        ),
                                                      ),
                                                      pick3
                                                          ? Positioned(
                                                              top: 5,
                                                              left: 5,
                                                              child:
                                                                  CircleAvatar(
                                                                foregroundColor:
                                                                    Colors.red,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        '${this.widget.user1['avatar']}'),
                                                                radius: 20,
                                                              ),
                                                            )
                                                          : Container(),
                                                      ((snapshot
                                                                      .child(
                                                                          'answeruser${you}${i}')
                                                                      .value
                                                                      .toString() !=
                                                                  "") &&
                                                              (snapshot
                                                                          .child(
                                                                              'answeruser${notyou}${i}')
                                                                          .value
                                                                          .toString() !=
                                                                      "" &&
                                                                  snapshot
                                                                          .child(
                                                                              'answeruser${notyou}${i}')
                                                                          .value
                                                                          .toString() ==
                                                                      snapshot
                                                                          .child(
                                                                              'answerText${i}3')
                                                                          .value
                                                                          .toString()))
                                                          ? Positioned(
                                                              top: 5,
                                                              right: 5,
                                                              child:
                                                                  CircleAvatar(
                                                                foregroundColor:
                                                                    Colors.red,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        '${this.widget.user2['avatar']}'),
                                                                radius: 20,
                                                              ),
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Stack(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 50,
                                                  ),
                                                  Positioned(
                                                    left: 25,
                                                    right: 25,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              70,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        fuc4
                                            ? InkWell(
                                                onTap: () {
                                                  pick = true;
                                                  pick4 = true;
                                                  youranwser = "D";
                                                  int newtotal = 0;
                                                  if (snapshot
                                                              .child(
                                                                  'score${i}4')
                                                              .value ==
                                                          true &&
                                                      youranwser == "D") {
                                                    if (time == 0) {
                                                      score += x2score * 10;
                                                    } else {
                                                      score +=
                                                          x2score * 10 * time;
                                                    }
                                                  }
                                                  newtotal = int.parse(snapshot
                                                          .child(
                                                              'totalscore${you}')
                                                          .value
                                                          .toString()) +
                                                      score;
                                                  final postData = {
                                                    // "id":snapshot.child('id').value,
                                                    "totalscore${you}":
                                                        newtotal,
                                                    "answeruser${you}${i}":
                                                        snapshot
                                                            .child(
                                                                'answerText${i}4')
                                                            .value
                                                            .toString(),
                                                    "scoreqr${you}${i}": score,
                                                  };
                                                  FirebaseDatabase.instance
                                                      .ref(
                                                          'room/${snapshot.child('id').value}')
                                                      .update(postData);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: 50,
                                                      ),
                                                      Positioned(
                                                        left: 25,
                                                        right: 25,
                                                        child: InkWell(
                                                          child: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20),
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  70,
                                                              height: 50,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: pick
                                                                    ? snapshot.child('score${i}4').value ==
                                                                            true
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .red
                                                                    : Colors
                                                                        .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Text(
                                                                'D. ${snapshot.child('answerText${i}4').value}',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Mono",
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              )),
                                                        ),
                                                      ),
                                                      pick4
                                                          ? Positioned(
                                                              top: 5,
                                                              left: 5,
                                                              child:
                                                                  CircleAvatar(
                                                                foregroundColor:
                                                                    Colors.red,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        '${this.widget.user1['avatar']}'),
                                                                radius: 20,
                                                              ),
                                                            )
                                                          : Container(),
                                                      ((snapshot
                                                                      .child(
                                                                          'answeruser${you}${i}')
                                                                      .value
                                                                      .toString() !=
                                                                  "") &&
                                                              (snapshot
                                                                          .child(
                                                                              'answeruser${notyou}${i}')
                                                                          .value
                                                                          .toString() !=
                                                                      "" &&
                                                                  snapshot
                                                                          .child(
                                                                              'answeruser${notyou}${i}')
                                                                          .value
                                                                          .toString() ==
                                                                      snapshot
                                                                          .child(
                                                                              'answerText${i}4')
                                                                          .value
                                                                          .toString()))
                                                          ? Positioned(
                                                              top: 5,
                                                              right: 5,
                                                              child:
                                                                  CircleAvatar(
                                                                foregroundColor:
                                                                    Colors.red,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        '${this.widget.user2['avatar']}'),
                                                                radius: 20,
                                                              ),
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Stack(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 50,
                                                  ),
                                                  Positioned(
                                                    left: 25,
                                                    right: 25,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              70,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (fuc_5050) {
                                          gold = gold! - 100;
                                          int stt = 0;
                                          for (int tmp = 1; tmp < 5; tmp++) {
                                            if (snapshot
                                                    .child('score${i}${tmp}')
                                                    .value ==
                                                false) {
                                              if (tmp == 1) fuc1 = false;
                                              if (tmp == 2) fuc2 = false;
                                              if (tmp == 3) fuc3 = false;
                                              if (tmp == 4) fuc4 = false;
                                              stt++;
                                            }
                                            if (stt == 2) break;
                                          }
                                          updategold();
                                          fuc_5050 = false;
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: fuc_5050
                                                  ? AssetImage('img/level.png')
                                                  : AssetImage(
                                                      'img/level1.png'),
                                              fit: BoxFit.fill),
                                        ),
                                        child: Text(
                                          '50:50',
                                          style: TextStyle(
                                            fontFamily: "Mono",
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '100',
                                          style: TextStyle(
                                            fontFamily: "Mono",
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Image.asset(
                                          'img/coin.png',
                                          width: 30,
                                          height: 30,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (fuc_master) {
                                          gold = gold! - 250;
                                          int stt = 0;
                                          for (int tmp = 1; tmp < 5; tmp++) {
                                            if (snapshot
                                                    .child('score${i}${tmp}')
                                                    .value ==
                                                false) {
                                              if (tmp == 1) fuc1 = false;
                                              if (tmp == 2) fuc2 = false;
                                              if (tmp == 3) fuc3 = false;
                                              if (tmp == 4) fuc4 = false;
                                              stt++;
                                            }
                                            if (stt == 3) break;
                                          }
                                          updategold();
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: fuc_master
                                                  ? AssetImage('img/level.png')
                                                  : AssetImage(
                                                      'img/level1.png'),
                                              fit: BoxFit.fill),
                                        ),
                                        child: Text(
                                          'hỏi thầy',
                                          style: TextStyle(
                                            fontFamily: "Mono",
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '250',
                                          style: TextStyle(
                                            fontFamily: "Mono",
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Image.asset(
                                          'img/coin.png',
                                          width: 30,
                                          height: 30,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (fuc_x2 == true) {
                                          gold = gold! - 200;
                                          x2score = 2;
                                          fuc_x2 = false;
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: fuc_x2
                                                  ? AssetImage('img/level.png')
                                                  : AssetImage(
                                                      'img/level1.png'),
                                              fit: BoxFit.fill),
                                        ),
                                        child: Text(
                                          'X2 \n  điểm',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "Mono",
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '200',
                                          style: TextStyle(
                                            fontFamily: "Mono",
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Image.asset(
                                          'img/coin.png',
                                          width: 30,
                                          height: 30,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (fuc_time == true) {
                                          time += 5;
                                          fuc_time = false;
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: fuc_time
                                                  ? AssetImage('img/level.png')
                                                  : AssetImage(
                                                      'img/level1.png'),
                                              fit: BoxFit.fill),
                                        ),
                                        child: Text(
                                          '+5 giây',
                                          style: TextStyle(
                                            fontFamily: "Mono",
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '50',
                                          style: TextStyle(
                                            fontFamily: "Mono",
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Image.asset(
                                          'img/coin.png',
                                          width: 30,
                                          height: 30,
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        );
                      }
                      return Container();
                    })));
  }
}
