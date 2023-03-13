import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import "package:flutter/material.dart";
import 'package:init_firebase/main_game.dart';
import 'package:init_firebase/objects/Profile.dart';
import 'package:init_firebase/screen_waiting.dart';

class ResultMath extends StatefulWidget {
  ResultMath(
      {super.key,
      required this.roomid,
      required this.user1,
      required this.user2,
      required this.scoreyou,
      required this.scorenotyou});
  String roomid;
  final user1;
  final user2;
  int scoreyou;
  int scorenotyou;
  @override
  State<ResultMath> createState() => _ResultMathState();
}

class _ResultMathState extends State<ResultMath> {
  bool? result;
  Profile? profile;
  @override
  void initState() {
    profile = Profile(
        id: this.widget.user1['id'],
        star: this.widget.user1['star'],
        character_name: this.widget.user1['character_name'],
        level: this.widget.user1['level'],
        rank: this.widget.user1['rank'],
        rank_detail: this.widget.user1['rank_detail'],
        avatar: this.widget.user1['avatar'],
        exp: this.widget.user1['exp'],
        gold: this.widget.user1['gold'],
        total: this.widget.user1['total']);
    if (this.widget.scoreyou > this.widget.scorenotyou) {
      result = true;
    } else {
      result = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return result!
        ? Scaffold(
            resizeToAvoidBottomInset:
                false, //khi bàn phím xuất hiện sẽ không làm vỡ layout của giao diện
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/background2.png'),
                      fit: BoxFit.fill),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'img/tree.png',
                      width: 300,
                      height: 150,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: const Text(
                        'bạn quả là bách khoa toàn thư khâm phục khâm phục !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Mono',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.2,
                        ),
                        Positioned(
                          top: 25,
                          left: MediaQuery.of(context).size.width / 2 - 170,
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 20, right: 20),
                              width: 340,
                              height:
                                  MediaQuery.of(context).size.height / 2.5 - 20,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('img/frame2.png'),
                                    fit: BoxFit.fill),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5, left: 5),
                                    width: 300,
                                    height: 100,
                                    padding:
                                        EdgeInsets.fromLTRB(30, 10, 30, 20),
                                    alignment: Alignment.center,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    foregroundColor: Colors.red,
                                                    backgroundImage: AssetImage(
                                                        '${this.widget.user1['avatar']}'),
                                                    radius: 35,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                          '${this.widget.user1['character_name']}',
                                                          style: TextStyle(
                                                              fontFamily: 'UTM',
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontSize: 17,
                                                              color: Colors
                                                                  .white)),
                                                      Text(
                                                          '${this.widget.user1['rank']}',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Mono',
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .white)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '${this.widget.scoreyou}',
                                            style: TextStyle(
                                                fontFamily: 'UTM',
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 242, 203, 7)),
                                          ),
                                        ]),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5, left: 5),
                                    width: 300,
                                    height: 100,
                                    padding:
                                        EdgeInsets.fromLTRB(30, 10, 30, 20),
                                    alignment: Alignment.center,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    foregroundColor: Colors.red,
                                                    backgroundImage: AssetImage(
                                                        '${this.widget.user2['avatar']}'),
                                                    radius: 35,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                          '${this.widget.user2['character_name']}',
                                                          style: TextStyle(
                                                              fontFamily: 'UTM',
                                                              fontSize: 17,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Colors
                                                                  .white)),
                                                      Text(
                                                          '${this.widget.user2['rank']}',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Mono',
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .white)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '${this.widget.scorenotyou}',
                                            style: TextStyle(
                                                fontFamily: 'UTM',
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 242, 203, 7)),
                                          ),
                                        ]),
                                  ),
                                ],
                              )),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width / 2 - 70,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: 140,
                              height: 50,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('img/button4.png'),
                                    fit: BoxFit.fill),
                              ),
                              child: const Text(
                                'Bạn Thắng',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 0),
                                  fontFamily: 'UTM',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: const Text(
                        'Bộ câu hỏi này có vẻ thách thức bạn, bạn có muốn xem lại đáp án không?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Mono',
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 180,
                      height: 60,
                      padding: EdgeInsets.only(bottom: 5),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('img/button1.png'),
                              fit: BoxFit.fill)),
                      child: InkWell(
                        child: const Text(
                          'Xem Câu Hỏi',
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                  offset: Offset(5, 3),
                                  blurRadius: 10,
                                  color: Colors.black,
                                ),
                              ],
                              color: Colors.white,
                              fontFamily: 'Mono',
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  WatchQuestion(roomid: this.widget.roomid));
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 160,
                          height: 80,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('img/button5.png'),
                                  fit: BoxFit.fill)),
                          child: InkWell(
                            child: const Text(
                              'Trang Chủ',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontFamily: 'Mono',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                            onTap: () {
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainGame()));
                            },
                          ),
                        ),
                        Container(
                          width: 160,
                          height: 80,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('img/button5.png'),
                                  fit: BoxFit.fill)),
                          child: InkWell(
                            child: const Text(
                              'Chơi Tiếp',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontFamily: 'Mono',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScreenWaiting(
                                          profile: profile!)));
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          )
        : Scaffold(
            resizeToAvoidBottomInset:
                false, //khi bàn phím xuất hiện sẽ không làm vỡ layout của giao diện
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/background2.png'),
                      fit: BoxFit.fill),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'img/tree1.png',
                      width: 300,
                      height: 150,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: const Text(
                        'Bạn không nản, chỉ là bước đầu tiên dẫn đến vinh quang!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromARGB(255, 119, 255, 0),
                            fontFamily: 'Mono',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.2,
                        ),
                        Positioned(
                          top: 25,
                          left: MediaQuery.of(context).size.width / 2 - 170,
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 20, right: 20),
                              width: 340,
                              height:
                                  MediaQuery.of(context).size.height / 2.5 - 20,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('img/frame2.png'),
                                    fit: BoxFit.fill),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5, left: 5),
                                    width: 300,
                                    height: 100,
                                    padding:
                                        EdgeInsets.fromLTRB(30, 10, 30, 20),
                                    alignment: Alignment.center,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    foregroundColor: Colors.red,
                                                    backgroundImage: AssetImage(
                                                        '${this.widget.user1['avatar']}'),
                                                    radius: 35,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                          '${this.widget.user1['character_name']}',
                                                          style: TextStyle(
                                                              fontFamily: 'UTM',
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontSize: 17,
                                                              color: Colors
                                                                  .white)),
                                                      Text(
                                                          '${this.widget.user1['rank']}',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Mono',
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .white)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '${this.widget.scoreyou}',
                                            style: TextStyle(
                                                fontFamily: 'UTM',
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 242, 203, 7)),
                                          ),
                                        ]),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5, left: 5),
                                    width: 300,
                                    height: 100,
                                    padding:
                                        EdgeInsets.fromLTRB(30, 10, 30, 20),
                                    alignment: Alignment.center,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    foregroundColor: Colors.red,
                                                    backgroundImage: AssetImage(
                                                        '${this.widget.user2['avatar']}'),
                                                    radius: 35,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                          '${this.widget.user2['character_name']}',
                                                          style: TextStyle(
                                                              fontFamily: 'UTM',
                                                              fontSize: 17,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Colors
                                                                  .white)),
                                                      Text(
                                                          '${this.widget.user2['rank']}',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Mono',
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .white)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '${this.widget.scorenotyou}',
                                            style: TextStyle(
                                                fontFamily: 'UTM',
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 242, 203, 7)),
                                          ),
                                        ]),
                                  ),
                                ],
                              )),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width / 2 - 70,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: 140,
                              height: 50,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('img/button4.png'),
                                    fit: BoxFit.fill),
                              ),
                              child: const Text(
                                'Bạn Thua',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: 'UTM',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: const Text(
                        'Bộ câu hỏi này có vẻ thách thức bạn, bạn có muốn xem lại đáp án không?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Mono',
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 180,
                      height: 60,
                      padding: EdgeInsets.only(bottom: 5),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('img/button1.png'),
                              fit: BoxFit.fill)),
                      child: InkWell(
                        child: const Text(
                          'Xem Câu Hỏi',
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                  offset: Offset(5, 3),
                                  blurRadius: 10,
                                  color: Colors.black,
                                ),
                              ],
                              color: Colors.white,
                              fontFamily: 'Mono',
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  WatchQuestion(roomid: this.widget.roomid));
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 160,
                          height: 80,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('img/button5.png'),
                                  fit: BoxFit.fill)),
                          child: InkWell(
                            child: const Text(
                              'Trang Chủ',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontFamily: 'Mono',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Container(
                          width: 160,
                          height: 80,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('img/button5.png'),
                                  fit: BoxFit.fill)),
                          child: InkWell(
                            child: const Text(
                              'Chơi Tiếp',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontFamily: 'Mono',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScreenWaiting(
                                          profile: profile!)));
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          );
  }
}

class WatchQuestion extends StatefulWidget {
  WatchQuestion({super.key, required this.roomid});
  String roomid;
  @override
  State<WatchQuestion> createState() => _WatchQuestionState();
}

class _WatchQuestionState extends State<WatchQuestion> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('room');
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0x00000000),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 60.0,
            child: Container(
                height: 650,
                width: 340,
                padding: EdgeInsets.only(bottom: 50),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('img/frame2.png'), fit: BoxFit.fill)),
                child: FirebaseAnimatedList(
                    shrinkWrap: true,
                    query: dbRef,
                    itemBuilder: (context, snapshot, animation, nooo) {
                      if (snapshot.child('id').value == this.widget.roomid) {
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                          padding: EdgeInsets.only(bottom: 180),
                          child: ListView(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (int i = 1; i < 6; i++)
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(67, 253, 252, 252),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      width: 300,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Câu $i:',
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
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              '${snapshot.child('title$i').value.toString()}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontFamily: 'Mono',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                          for (int j = 1; j < 5; j++)
                                            Container(
                                                margin: EdgeInsets.all(5),
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    70,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: snapshot
                                                              .child(
                                                                  'score${i}${j}')
                                                              .value ==
                                                          true
                                                      ? Color.fromARGB(
                                                          255, 10, 239, 18)
                                                      : Color.fromARGB(
                                                          255, 255, 255, 255),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  (j == 1
                                                          ? 'A.'
                                                          : (j == 2
                                                              ? 'B.'
                                                              : (j == 3
                                                                  ? "C."
                                                                  : (j == 4
                                                                      ? "D."
                                                                      : "D.")))) +
                                                      '${snapshot.child('answerText${i}${j}').value}',
                                                  style: TextStyle(
                                                    fontFamily: "Mono",
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    })),
          ),
          Positioned(
              top: 30,
              child: Container(
                alignment: Alignment.center,
                width: 280,
                height: 90,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/frame.png'), fit: BoxFit.fill),
                ),
                child: const Text(
                  'Bộ Câu Hỏi',
                  style: TextStyle(
                      shadows: [
                        Shadow(
                          offset: Offset(5, 3),
                          blurRadius: 10,
                          color: Colors.black,
                        ),
                      ],
                      color: Color.fromARGB(255, 242, 255, 0),
                      fontFamily: 'Mono',
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              )),
          Positioned(
              top: 40,
              right: 5,
              child: InkWell(
                child: Image.asset(
                  'img/cancelbutton.png',
                  width: 50,
                  height: 50,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )),
        ],
      ),
    );
  }
}
