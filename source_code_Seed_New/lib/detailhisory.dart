import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'objects/Online.dart';
import 'objects/Profile.dart';

class DetailHistory extends StatefulWidget {
  DetailHistory({super.key, required this.roomid});
  String roomid;
  @override
  State<DetailHistory> createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  String id = "";
  get_id() async {
    final SharedPreferences cookie = await SharedPreferences.getInstance();
    id = cookie.getString('id') != null ? cookie.getString('id')! : '';
    setState(() {});
  }

  @override
  void initState() {
    get_id();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<Profile>> readprofiles() => FirebaseFirestore.instance
        .collection('profiles')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Profile.fromJson(doc.data())).toList());
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('img/background3.png'), fit: BoxFit.fill),
      ),
      child: FutureBuilder(
          future: dbRef.child("room").once(),
          builder: (BuildContext context, snapshot) {
            List<Room> rooms = [];
            if (snapshot.hasData) {
              Map<dynamic, dynamic> messages =
                  snapshot.data!.snapshot.value as Map;
              messages.forEach((key, value) {
                Room rom = Room.fromJson(value);
                rooms.add(rom);
              });
              return StreamBuilder<List<Profile>>(
                stream: readprofiles(),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return Text('Something wrong ${snapshot.error}');
                  else if (snapshot.hasData) {
                    List<Profile> profiles = snapshot.data!;
                    Profile you = Profile(
                        id: '1',
                        character_name: 'character_name',
                        level: 1,
                        rank: 'rank',
                        rank_detail: 'rank_detail',
                        avatar: 'img/avatar.jpg',
                        exp: 55,
                        star: 1,
                        gold: 1,
                        total: 1);
                    Profile notyou = Profile(
                        id: '1',
                        character_name: 'character_name',
                        level: 1,
                        rank: 'rank',
                        rank_detail: 'rank_detail',
                        avatar: 'img/avatar.jpg',
                        exp: 55,
                        star: 1,
                        gold: 1,
                        total: 1);
                    int indexyou = 0;
                    Room _room = Room(
                        id: id,
                        user1: 'user1',
                        user2: 'user2',
                        status: true,
                        totalscore1: 1,
                        totalscore2: 1,
                        ready1: true,
                        ready2: true,
                        answeruser11: 'answeruser11',
                        scoreqr11: 1,
                        answeruser21: 'answeruser21',
                        scoreqr21: 1,
                        answeruser12: 'answeruser12',
                        scoreqr12: 1,
                        answeruser22: 'answeruser22',
                        scoreqr22: 1,
                        answeruser13: 'answeruser13',
                        scoreqr13: 1,
                        answeruser23: 'answeruser23',
                        scoreqr23: 1,
                        answeruser14: 'answeruser14',
                        scoreqr14: 1,
                        answeruser24: 'answeruser24',
                        scoreqr24: 1,
                        answeruser15: 'answeruser15',
                        scoreqr15: 1,
                        answeruser25: 'answeruser25',
                        scoreqr25: 1,
                        title1: 'title1',
                        title2: 'title2',
                        title3: 'title3',
                        title4: 'title4',
                        title5: 'title5',
                        answerText11: 'answerText11',
                        score11: true,
                        answerText12: 'answerText12',
                        score12: true,
                        answerText13: 'answerText13',
                        score13: true,
                        answerText14: 'answerText14',
                        score14: true,
                        answerText21: 'answerText21',
                        score21: true,
                        answerText22: 'answerText22',
                        score22: true,
                        answerText23: 'answerText23',
                        score23: true,
                        answerText24: 'answerText24',
                        score24: true,
                        answerText31: 'answerText31',
                        score31: true,
                        answerText32: 'answerText32',
                        score32: true,
                        answerText33: 'answerText33',
                        score33: true,
                        answerText34: 'answerText34',
                        score34: true,
                        answerText41: 'answerText41',
                        score41: true,
                        answerText42: 'answerText42',
                        score42: true,
                        answerText43: 'answerText43',
                        score43: true,
                        answerText44: 'answerText44',
                        score44: true,
                        answerText51: 'answerText51',
                        score51: true,
                        answerText52: 'answerText52',
                        score52: true,
                        answerText53: 'answerText53',
                        score53: true,
                        answerText54: 'answerText54',
                        score54: true);
                    bool win = true;
                    for (var room in rooms) {
                      if (room.id == this.widget.roomid) {
                        if (room.user1 == id) {
                          if (room.totalscore1 > room.totalscore2) {
                            win = true;
                          } else {
                            win = false;
                          }
                          _room = room;
                          indexyou = 1;
                          for (var profile in profiles) {
                            if (profile.id == room.user1) {
                              you = profile;
                            }
                            if (profile.id == room.user2) {
                              notyou = profile;
                            }
                          }
                        } else if (room.user2 == id) {
                          if (room.totalscore1 < room.totalscore2) {
                            win = true;
                          } else {
                            win = false;
                          }
                          _room = room;
                          indexyou = 2;
                          for (var profile in profiles) {
                            if (profile.id == room.user2) {
                              you = profile;
                            }
                            if (profile.id == room.user1) {
                              notyou = profile;
                            }
                          }
                        }
                        break;
                      }
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                child: Image.asset(
                                  'img/return.png',
                                  width: 40,
                                  height: 40,
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.only(bottom: 15),
                                alignment: Alignment.center,
                                width: 280,
                                height: 100,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('img/frame.png'),
                                      fit: BoxFit.fill),
                                ),
                                child: win
                                    ? Text(
                                        'Chiến Thắng',
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
                                      )
                                    : Text(
                                        'Thất Bại',
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
                              )
                            ],
                          ),
                        ),
                        Container(
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
                                        MediaQuery.of(context).size.width / 2 -
                                            15,
                                    height: 80,
                                  ),
                                  Positioned(
                                    bottom: 7,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          15,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'img/leftframe1.png'),
                                            fit: BoxFit.fill),
                                      ),
                                      child: you == 1
                                          ? Text(
                                              '${_room.totalscore1}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'UTM',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          : Text(
                                              '${_room.totalscore2}',
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
                                          backgroundImage:
                                              AssetImage('${you.avatar}'),
                                          radius: 25,
                                        ),
                                        Text(
                                          '${you.character_name}',
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
                                        MediaQuery.of(context).size.width / 2 -
                                            15,
                                    height: 80,
                                  ),
                                  Positioned(
                                    bottom: 7,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          15,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'img/rightframe1.png'),
                                            fit: BoxFit.fill),
                                      ),
                                      child: you == 1
                                          ? Text(
                                              '${_room.totalscore2}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'UTM',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          : Text(
                                              '${_room.totalscore1}',
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
                                          '${notyou.character_name}',
                                          style: TextStyle(
                                              color: Colors.yellowAccent,
                                              fontFamily: 'Mono',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        CircleAvatar(
                                          foregroundColor: Colors.red,
                                          backgroundImage:
                                              AssetImage('${notyou.avatar}'),
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
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 210,
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(42, 246, 246, 246),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(5),
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Câu 1',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              '${_room.title1}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              you == 1
                                                  ? 'Điểm: ${_room.scoreqr11}'
                                                  : 'Điểm: ${_room.scoreqr21}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              you == 1
                                                  ? 'Điểm: ${_room.scoreqr21}'
                                                  : 'Điểm: ${_room.scoreqr11}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(42, 246, 246, 246),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(5),
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Câu 2',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              '${_room.title2}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              you == 1
                                                  ? 'Điểm: ${_room.scoreqr12}'
                                                  : 'Điểm: ${_room.scoreqr22}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              you == 1
                                                  ? 'Điểm: ${_room.scoreqr22}'
                                                  : 'Điểm: ${_room.scoreqr12}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(42, 246, 246, 246),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(5),
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Câu 3',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              '${_room.title3}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              you == 1
                                                  ? 'Điểm: ${_room.scoreqr13}'
                                                  : 'Điểm: ${_room.scoreqr23}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              you == 1
                                                  ? 'Điểm: ${_room.scoreqr23}'
                                                  : 'Điểm: ${_room.scoreqr13}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(42, 246, 246, 246),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(5),
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Câu 4',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              '${_room.title4}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              you == 1
                                                  ? 'Điểm: ${_room.scoreqr14}'
                                                  : 'Điểm: ${_room.scoreqr24}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              you == 1
                                                  ? 'Điểm: ${_room.scoreqr24}'
                                                  : 'Điểm: ${_room.scoreqr14}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(42, 246, 246, 246),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(5),
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Câu 5',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              '${_room.title5}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              you == 1
                                                  ? 'Điểm: ${_room.scoreqr15}'
                                                  : 'Điểm: ${_room.scoreqr25}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              you == 1
                                                  ? 'Điểm: ${_room.scoreqr25}'
                                                  : 'Điểm: ${_room.scoreqr15}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'img/fire.gif',
                          width: 150,
                          height: 150,
                        ),
                        Text(
                          'Đang tải',
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
                        )
                      ],
                    ),
                  );
                  }
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'img/fire.gif',
                          width: 150,
                          height: 150,
                        ),
                        Text(
                          'Đang tải',
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
                        )
                      ],
                    ),
                  );
            } else {
              return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'img/fire.gif',
                          width: 150,
                          height: 150,
                        ),
                        Text(
                          'Đang tải',
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
                        )
                      ],
                    ),
                  );
            }
          }),
    ));
  }
}
