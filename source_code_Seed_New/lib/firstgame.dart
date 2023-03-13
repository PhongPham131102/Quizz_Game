import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'objects/Object_geographies.dart';
import 'objects/Object_literatures.dart';
import 'objects/Object_musics.dart';
import 'objects/Object_program.dart';
import 'objects/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_game.dart';
import 'objects/Object_Hisories.dart';

class Firstgame extends StatefulWidget {
  const Firstgame({super.key});

  @override
  State<Firstgame> createState() => _FirstgameState();
}

class _FirstgameState extends State<Firstgame> {
  String id = "";
  String is_logined = "";

  get_is_logined() async {
    final SharedPreferences cookie = await SharedPreferences.getInstance();
    is_logined = cookie.getString('is_logined') != null
        ? cookie.getString('is_logined')!
        : '';
    setState(() {});
  }

  get_id() async {
    final SharedPreferences cookie = await SharedPreferences.getInstance();
    id = cookie.getString('id') != null ? cookie.getString('id')! : '';
    setState(() {});
  }

  @override
  void initState() {
    get_id();
    get_is_logined();
    super.initState();
  }

  Future createProfile({required Profile profile}) async {
    final docUser =
        FirebaseFirestore.instance.collection('profiles').doc("${profile.id}");
    final _proflie = Profile(
        id: id,
        star: profile.star,
        character_name: profile.character_name,
        level: profile.level,
        rank: profile.rank,
        avatar: profile.avatar,
        exp: profile.exp,
        gold: profile.gold,
        rank_detail: profile.rank_detail,
        total: profile.total);
    final json = _proflie.toJson();
    await docUser.set(json);
  }

  Future createHistory({required ObjectHistory history}) async {
    final docUser = FirebaseFirestore.instance
        .collection('objecthistories')
        .doc("${history.id}");
    final _history = ObjectHistory(
        id: history.id,
        level1: history.level1,
        score1: history.score1,
        level2: history.level2,
        score2: history.score2,
        level3: history.level3,
        score3: history.score3,
        level4: history.level4,
        score4: history.score4);
    final json = _history.toJson();
    await docUser.set(json);
  }

  Future createprogramming({required ObjectProgram program}) async {
    final docUser = FirebaseFirestore.instance
        .collection('objectprograming')
        .doc("${program.id}");
    final _program = ObjectProgram(
        id: program.id,
        level1: program.level1,
        score1: program.score1,
        level2: program.level2,
        score2: program.score2,
        level3: program.level3,
        score3: program.score3,
        level4: program.level4,
        score4: program.score4);
    final json = _program.toJson();
    await docUser.set(json);
  }

  Future creategeography({required ObjectGeo geography}) async {
    final docUser = FirebaseFirestore.instance
        .collection('objectgeography')
        .doc("${geography.id}");
    final _geography = ObjectGeo(
        id: geography.id,
        level1: geography.level1,
        score1: geography.score1,
        level2: geography.level2,
        score2: geography.score2,
        level3: geography.level3,
        score3: geography.score3,
        level4: geography.level4,
        score4: geography.score4);
    final json = _geography.toJson();
    await docUser.set(json);
  }

  Future createliterature({required Objectliteratures literature}) async {
    final docUser = FirebaseFirestore.instance
        .collection('objectliterature')
        .doc("${literature.id}");
    final _literature = Objectliteratures(
        id: literature.id,
        level1: literature.level1,
        score1: literature.score1,
        level2: literature.level2,
        score2: literature.score2,
        level3: literature.level3,
        score3: literature.score3,
        level4: literature.level4,
        score4: literature.score4);
    final json = _literature.toJson();
    await docUser.set(json);
  }

  Future createmusic({required ObjectMucsic music}) async {
    final docUser = FirebaseFirestore.instance
        .collection('objectmucsic')
        .doc("${music.id}");
    final _music = ObjectMucsic(
        id: music.id,
        level1: music.level1,
        score1: music.score1,
        level2: music.level2,
        score2: music.score2,
        level3: music.level3,
        score3: music.score3,
        level4: music.level4,
        score4: music.score4);
    final json = _music.toJson();
    await docUser.set(json);
  }

  final firstname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:
            false, //khi bàn phím xuất hiện sẽ không làm vỡ layout của giao diện
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('img/background1.png'), fit: BoxFit.fill),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'img/in4.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  const Positioned(
                    top: 80,
                    right: 35,
                    child: Text(
                      'SEED NEW',
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            offset: Offset(5, 3),
                            blurRadius: 10,
                            color: Colors.black,
                          ),
                        ],
                        color: Colors.yellow,
                        fontFamily: 'Coppper',
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 120,
                    right: 70,
                    child: Text(
                      'FLUTTER',
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            offset: Offset(5, 3),
                            blurRadius: 10,
                            color: Colors.black,
                          ),
                        ],
                        color: Colors.yellow,
                        fontFamily: 'Coppper',
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 165,
                    right: 35,
                    child: Text(
                      'CDTHPM20C',
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            offset: Offset(5, 3),
                            blurRadius: 10,
                            color: Colors.black,
                          ),
                        ],
                        color: Colors.yellow,
                        fontFamily: 'Coppper',
                        fontSize: 13,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  //stack dùng để làm cho các con trong stack có thể chồng lên nhau
                  Stack(
                    children: [
                      Container(
                          width: 360,
                          height: 270,
                          child: Container(
                            alignment: Alignment.topLeft,
                            width: 150,
                            height: 50,
                            child: Stack(children: [
                              Positioned(
                                left: 20,
                                child: Image.asset(
                                  'img/logintoptb.png',
                                  height: 70,
                                  width: 150,
                                ),
                              ),
                              //positon được dùng trong widget stack dùng để chỉnh vị trí của witget con của positon ở vị trí mong muốn
                              const Positioned(
                                top: 30,
                                left: 45,
                                child: Text(
                                  'Tên Nhân Vật',
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ]),
                          )),
                      Positioned(
                        top: 62.0,
                        right: 0.0,
                        left: 0.0,
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            alignment: Alignment.center,
                            height: 100,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('img/table.png'),
                                    fit: BoxFit.fill)),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 30),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "xin chào",
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 220,
                                    child: TextField(
                                      controller: firstname,
                                      cursorColor: Colors.black,
                                      cursorWidth: 3,
                                      cursorHeight: 20,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Mono',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                        fillColor: Color(0xffFF8C4B),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Positioned(
                        top: 155,
                        child: Container(
                          margin: const EdgeInsets.only(left: 40),
                          padding: const EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          width: 200,
                          height: 60,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('img/in4small.png'),
                                  fit: BoxFit.fill)),
                          child: const Text(
                            'Lưu ý: \n Tên nhân vật không quá 10 ký tự',
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                    offset: Offset(5, 3),
                                    blurRadius: 10,
                                    color: Colors.black,
                                  ),
                                ],
                                color: Colors.yellow,
                                fontFamily: 'Mono',
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 170,
                        left: 250,
                        child: InkWell(
                          child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('img/arrowright.png'),
                                    fit: BoxFit.fill)),
                            child: const Text(
                              'Tiếp Tục',
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
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          onTap: () {
                            if (firstname.text == null ||
                                firstname.text == "") {
                              showDialog(
                                  context: context,
                                  builder: (context) => _messagebox(context,
                                      'Bạn chưa nhập tên nhân vật.'));
                            } else if (firstname.text.length > 10) {
                              showDialog(
                                  context: context,
                                  builder: (context) => _messagebox(context,
                                      'Tên nhân vật không quá 10 ký tự.'));
                            } else {
                              final _makeprofile = Profile(
                                  id: id,
                                  character_name: firstname.text,
                                  level: 1,
                                  rank: "Mầm Non",
                                  avatar: "img/avatar.jpg",
                                  exp: 0,
                                  star: 1,
                                  gold: 99,
                                  rank_detail: "Lớp Mầm",
                                  total: 0);
                              final _makehistory = ObjectHistory(
                                  id: id,
                                  level1: true,
                                  score1: 0,
                                  level2: false,
                                  score2: 0,
                                  level3: false,
                                  score3: 0,
                                  level4: false,
                                  score4: 0);
                                  final _makeprograming = ObjectProgram(
                                  id: id,
                                  level1: true,
                                  score1: 0,
                                  level2: false,
                                  score2: 0,
                                  level3: false,
                                  score3: 0,
                                  level4: false,
                                  score4: 0);
                                  final _makegeography = ObjectGeo(
                                  id: id,
                                  level1: true,
                                  score1: 0,
                                  level2: false,
                                  score2: 0,
                                  level3: false,
                                  score3: 0,
                                  level4: false,
                                  score4: 0);
                                  final _makeliterature = Objectliteratures(
                                  id: id,
                                  level1: true,
                                  score1: 0,
                                  level2: false,
                                  score2: 0,
                                  level3: false,
                                  score3: 0,
                                  level4: false,
                                  score4: 0);
                                  final _makemusic = ObjectMucsic(
                                  id: id,
                                  level1: true,
                                  score1: 0,
                                  level2: false,
                                  score2: 0,
                                  level3: false,
                                  score3: 0,
                                  level4: false,
                                  score4: 0);
                              createHistory(history: _makehistory);
                              createprogramming(program: _makeprograming);
                              creategeography(geography: _makegeography);
                              createliterature(literature: _makeliterature);
                              createmusic(music: _makemusic);
                              createProfile(profile: _makeprofile);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainGame()));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

_messagebox(BuildContext context, String info) {
  return Material(
    color: const Color(0x00000000),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: 300,
          child: Container(
            margin: const EdgeInsets.only(right: 180),
            width: 150,
            height: 50,
            child: Stack(children: [
              Image.asset(
                'img/logintoptb.png',
                height: 70,
                width: 150,
              ),
              //positon được dùng trong widget stack dùng để chỉnh vị trí của witget con của positon ở vị trí mong muốn
              const Positioned(
                top: 15,
                left: 60,
                child: Text(
                  'Lỗi',
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
                      fontWeight: FontWeight.w600),
                ),
              )
            ]),
          ),
        ),
        Positioned(
          top: 346.0,
          child: Container(
              margin: const EdgeInsets.only(
                left: 10,
              ),
              alignment: Alignment.topCenter,
              height: 120,
              width: 340,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/messagebox.png'),
                      fit: BoxFit.fill)),
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      '$info',
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
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )),
        ),
        Positioned(
          top: 460,
          child: Container(
            margin: const EdgeInsets.only(left: 240),
            width: 100,
            height: 50,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('img/buttonsmall.png'),
                    fit: BoxFit.fill)),
            child: InkWell(
              child: const Text(
                'Ok',
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
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    ),
  );
}
