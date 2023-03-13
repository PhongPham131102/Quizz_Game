import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'main_game.dart';
import 'objects/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firstgame.dart';
import 'objects/Account.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<void> set_is_logined(String value) async {
    final SharedPreferences cookie = await SharedPreferences.getInstance();
    cookie.setString('is_logined', value);
  }

  Future<void> set_id(String value) async {
    final SharedPreferences cookie = await SharedPreferences.getInstance();
    cookie.setString('id', value);
  }

  List<Account> accounts = [];
  @override
  void initState() {
    feth();
    fethprofile();
    setState(() {});
    super.initState();
  }

  feth() async {
    var records = await FirebaseFirestore.instance.collection('accounts').get();
  }

  Future<List<Account>> fethaccount() async {
    var records = await FirebaseFirestore.instance.collection('accounts').get();
    final _list = records.docs
        .map((e) => Account(
            id: e['id'],
            name: e['name'],
            username: e['username'],
            password: e['password'],
            phone: e['phone']))
        .toList();
    return _list;
  }

  maprecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map((e) => Account(
            id: e['id'],
            name: e['name'],
            username: e['username'],
            password: e['password'],
            phone: e['phone']))
        .toList();
    accounts = _list;
  }

  List<Profile> profiles = [];

  fethprofile() async {
    var records = await FirebaseFirestore.instance.collection('profiles').get();
    maprecordsproflie(records);
  }

  maprecordsproflie(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map((json) => Profile(
            id: json["id"],
            star: json["star"],
            character_name: json["character_name"],
            level: json["level"],
            rank: json["rank"],
            avatar: json["avatar"],
            exp: json["exp"],
            gold: json["gold"],
            rank_detail: json["rank_detail"],
            total: json["total"]))
        .toList();
    profiles = _list;
  }

  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Container(
            padding: const EdgeInsets.only(top: 30),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('img/background.png'), fit: BoxFit.fill),
            ),
            child: FutureBuilder<List<Account>>(
              future: fethaccount(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Mất kết nối với máy chủ");
                } else if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            child: Image.asset(
                              'img/return.png',
                              width: 50,
                              height: 50,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyHomePage()));
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset(
                              'img/logo.png',
                              width: 200,
                              height: 200,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          //stack dùng để làm cho các con trong stack có thể chồng lên nhau
                          Stack(
                            children: [
                              Container(
                                  width: 300,
                                  height: 270,
                                  child: Container(
                                    alignment: Alignment.topCenter,
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
                                        top: 30,
                                        left: 25,
                                        child: Text(
                                          'ĐĂNG NHẬP',
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
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ]),
                                  )),
                              Positioned(
                                top: 56.0,
                                left: 0,
                                right: 0,
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 200,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage('img/logintb.png'),
                                            fit: BoxFit.fill)),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 30, 0, 30),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Tên đăng nhập',
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
                                            height: 40,
                                            width: 220,
                                            child: TextField(
                                              controller: username,
                                              cursorColor: Colors.black,
                                              cursorWidth: 3,
                                              cursorHeight: 20,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Mono',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                              decoration: InputDecoration(
                                                filled: true,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5.0)),
                                                ),
                                                fillColor: Color(0xffFF8C4B),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Mật khẩu',
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
                                            height: 40,
                                            width: 220,
                                            child: TextField(
                                              controller: password,
                                              cursorColor: Colors.black,
                                              cursorWidth: 3,
                                              cursorHeight: 20,
                                              obscureText: true,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Mono',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Color(0xffFF8C4B),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5.0)),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          InkWell(
                            child: Container(
                              width: 150,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('img/table.png'),
                                      fit: BoxFit.fill)),
                              child: const Text(
                                'Bắt Đầu',
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
                            ),
                            onTap: () {
                              List<Account> accountss = snapshot.data!;
                              bool isexist = false;
                              String _id = "";
                              for (var element in accountss) {
                                if (element.username == username.text &&
                                    element.password == password.text) {
                                  _id = element.id;
                                  set_is_logined('1');
                                  set_id(element.id);
                                  isexist = true;
                                }
                              }
                              if (isexist) {
                                Profile temp = Profile(
                                    id: "",
                                    character_name: "character_name",
                                    level: 0,
                                    rank: "rank",
                                    rank_detail: "",
                                    avatar: "avatar",
                                    star: 1,
                                    exp: 0,
                                    gold: 0,
                                    total: 0);
                                bool isnotexistname = false;
                                for (var element in profiles) {
                                  if (element.id == _id) {
                                    temp = element;
                                    isnotexistname = true;
                                    break;
                                  }
                                }
                                if (isnotexistname == true) {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainGame()));
                                } else {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Firstgame()));
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => _messagebox(context,
                                        'Tên Đăng Nhập Hoặc Mật Khẩu Không Đúng.'));
                              }
                            },
                          ),
                        ],
                      ),
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
            )),
      ],
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
