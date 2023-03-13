import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'objects/Account.dart';
import 'objects/Profile.dart';
import 'objects/provider.dart';
import 'objects/querries.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'function/rank.dart';
import 'subject_history.dart';

class Querrries extends StatefulWidget {
  Querrries({super.key, required this.object, required this.level});
  String object;
  int level;
  @override
  State<Querrries> createState() => _QuerrriesState();
}

class _QuerrriesState extends State<Querrries> {
  Future<List<dynamic>> _LoadDanhSach() async {
    final data;
    if (this.widget.object == "Lịch Sử") {
      data = await HistoryProvider.getAllQuerries();
      return data;
    } else if (this.widget.object == "Địa Lý") {
      data = await GeographyProvider.getAllQuerries();
      return data;
    } else if (this.widget.object == "Văn Học") {
      data = await LiteratureProvider.getAllQuerries();
      return data;
    } else if (this.widget.object == "Âm Nhạc") {
      data = await MusicProvider.getAllQuerries();
      return data;
    } else if (this.widget.object == "Lập Trình") {
      data = await ProgrammingProvider.getAllQuerries();
      return data;
    } else {
      return data = List<int>.filled(5, 0);
    }
  }

  String id = "";
  Future<Profile> _LoadNguoiDung() async {
    final data =
        await FirebaseFirestore.instance.collection('profiles').doc("$id");
    final snap = await data.get();

    return Profile.fromJson(snap.data()!);
  }

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
    return Scaffold(
      resizeToAvoidBottomInset:
          false, //khi bàn phím xuất hiện sẽ không làm vỡ layout của giao diện
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('img/background2.png'), fit: BoxFit.fill),
        ),
        child: FutureBuilder(
          future: _LoadDanhSach(),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot1) {
            if (snapshot1.hasData) {
              return FutureBuilder(
                future: _LoadNguoiDung(),
                builder:
                    (BuildContext context, AsyncSnapshot<Profile> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Kết nối có lỗi"),
                    );
                  }
                  if (snapshot.hasData) {
                    return Querry(
                      query: snapshot1.data![this.widget.level - 1].queries,
                      object: this.widget.object,
                      level: this.widget.level,
                      gold: snapshot.data!.gold,
                    );
                  } else
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
                },
              );
            } else
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
          },
        ),
      ),
    );
  }
}

class Querry extends StatefulWidget {
  Querry(
      {super.key,
      required this.query,
      required this.object,
      required this.level,
      required this.gold});
  List<dynamic> query;
  String object;
  int level;
  int gold;
  @override
  State<Querry> createState() => _QuerryState();
}

class _QuerryState extends State<Querry> {
  List<dynamic> query = [];
  int gold = 0;
  int goldplus = 0;
  int index = 0;
  int score = 0;
  int exp = 0;
  late bool anwser1 = query[index].answers[0].score;
  late bool anwser2 = query[index].answers[0].score;
  late bool anwser3 = query[index].answers[0].score;
  late bool anwser4 = query[index].answers[0].score;
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
  int time = 30;
  int timeonce = 10;
  int x2score = 1;
  void start() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (time >= 0) {
        setState(() {
          time--;
          timeonce--;
          updategold();
        });
      } else {
        showDialog(
            context: context,
            builder: (context) => EndGame(
                object: widget.object,
                level: widget.level,
                goldplus: goldplus,
                gold: gold,
                score: score,
                exp: exp));
        timer.cancel();
      }
    });
  }

  void addgold() {
    Random random = new Random();
    int randomNumber = random.nextInt(150) + 10;
    goldplus += randomNumber;
    setState(() {});
  }

  void onpress() {
    Future.delayed(const Duration(seconds: 2), () {
      index++;
      if (index == 5) {
        time = 0;
        index--;
      } else {
        anwser1 = query[index].answers[0].score;
        anwser2 = query[index].answers[0].score;
        anwser3 = query[index].answers[0].score;
        anwser4 = query[index].answers[0].score;
        fuc1 = true;
        fuc2 = true;
        fuc3 = true;
        fuc4 = true;
        pick = false;
        x2score = 1;
        youranwser = "";
        timeonce = 10;
      }
      updategold();
      setState(() {});
    });
  }

  void fuc5050() {
    gold -= 100;
    int stt = 0;
    for (int i = 0; i < 4; i++) {
      if (query[index].answers[i].score == false) {
        if (i == 0) fuc1 = false;
        if (i == 1) fuc2 = false;
        if (i == 2) fuc3 = false;
        if (i == 3) fuc4 = false;
        stt++;
      }
      if (stt == 2) break;
    }
    updategold();
    setState(() {});
  }

  void fucmaxster() {
    gold -= 250;
    int stt = 0;
    for (int i = 0; i < 4; i++) {
      if (query[index].answers[i].score == false) {
        if (i == 0) fuc1 = false;
        if (i == 1) fuc2 = false;
        if (i == 2) fuc3 = false;
        if (i == 3) fuc4 = false;
        stt++;
      }
      if (stt == 3) break;
    }
    updategold();
    setState(() {});
  }

  void updategold() {
    if (gold < 250) {
      fuc_master = false;
    }
    if (gold < 200) {
      fuc_x2 = false;
    }
    if (gold < 100) {
      fuc_5050 = false;
    }
    if (gold < 50) {
      fuc_x2 = false;
    }
  }

  @override
  void initState() {
    query = this.widget.query;
    gold = this.widget.gold;
    start();
    updategold();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(25, 5, 0, 0),
                padding: EdgeInsets.only(bottom: 15),
                alignment: Alignment.center,
                width: 280,
                height: 80,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/frame.png'), fit: BoxFit.fill),
                ),
                child: Text(
                  '${this.widget.object}',
                  style: TextStyle(
                      shadows: [
                        Shadow(
                          offset: Offset(5, 3),
                          blurRadius: 10,
                          color: Colors.black,
                        ),
                      ],
                      color: Color.fromARGB(255, 251, 255, 0),
                      fontFamily: 'UTM',
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                // showDialog(
                //     context: context, builder: (context) => _levelup(context));
              },
              child: Container(
                alignment: Alignment.center,
                width: 120,
                height: 50,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/frame5.png'), fit: BoxFit.fill),
                ),
                child: Text(
                  'Level ${this.widget.level.toString()}',
                  style: TextStyle(
                      shadows: [
                        Shadow(
                          offset: Offset(5, 3),
                          blurRadius: 10,
                          color: Colors.black,
                        ),
                      ],
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontFamily: 'UTM',
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('img/circle.gif'), fit: BoxFit.fill),
              ),
              child: Text(
                time > 0 ? time.toString() : "0",
                style: TextStyle(
                    shadows: [
                      Shadow(
                        offset: Offset(5, 3),
                        blurRadius: 10,
                        color: Colors.black,
                      ),
                    ],
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontFamily: 'UTM',
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('img/frame5.png'), fit: BoxFit.fill),
              ),
              child: Text(
                '$score'.toString(),
                style: TextStyle(
                    shadows: [
                      Shadow(
                        offset: Offset(5, 3),
                        blurRadius: 10,
                        color: Colors.black,
                      ),
                    ],
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontFamily: 'UTM',
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height / 1.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.all(25),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 50,
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(44, 254, 254, 254),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    widget.query[index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Mono',
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  )),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 50,
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    fuc1
                        ? InkWell(
                            onTap: () {
                              pick = true;
                              youranwser = "A";
                              if (this.widget.query[index].answers[0].score ==
                                      true &&
                                  youranwser == "A") {
                                addgold();
                                if (timeonce > 5) {
                                  score += x2score * 50;
                                  exp += 30;
                                } else {
                                  score += x2score * 10 * timeonce;
                                  exp += 5 * timeonce;
                                  if (timeonce == 0) {
                                    score += x2score * 10;
                                    exp += 5;
                                  }
                                }
                              }
                              onpress();
                              setState(() {});
                            },
                            child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 20),
                                width: MediaQuery.of(context).size.width - 70,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: pick
                                      ? this
                                              .widget
                                              .query[index]
                                              .answers[0]
                                              .score
                                          ? Colors.green
                                          : Colors.red
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'A. ${this.widget.query[index].answers[0].answerText}',
                                  style: TextStyle(
                                    fontFamily: "Mono",
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          )
                        : Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            width: MediaQuery.of(context).size.width - 70,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                    fuc2
                        ? InkWell(
                            onTap: () {
                              pick = true;
                              youranwser = "B";
                              if (this.widget.query[index].answers[1].score ==
                                      true &&
                                  youranwser == "B") {
                                addgold();
                                if (timeonce > 5) {
                                  score += x2score * 50;
                                  exp += 30;
                                } else {
                                  score += x2score * 10 * timeonce;
                                  exp += 5 * timeonce;
                                  if (timeonce == 0) {
                                    score += x2score * 10;
                                    exp += 5;
                                  }
                                }
                              }
                              onpress();
                              setState(() {});
                            },
                            child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 20),
                                width: MediaQuery.of(context).size.width - 70,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: pick
                                      ? this
                                              .widget
                                              .query[index]
                                              .answers[1]
                                              .score
                                          ? Colors.green
                                          : Colors.red
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'B. ${this.widget.query[index].answers[1].answerText}',
                                  style: TextStyle(
                                    fontFamily: "Mono",
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          )
                        : Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            width: MediaQuery.of(context).size.width - 70,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                    fuc3
                        ? InkWell(
                            onTap: () {
                              pick = true;
                              youranwser = "C";
                              if (this.widget.query[index].answers[2].score ==
                                      true &&
                                  youranwser == "C") {
                                addgold();
                                if (timeonce > 5) {
                                  score += x2score * 50;
                                  exp += 30;
                                } else {
                                  score += x2score * 10 * timeonce;
                                  exp += 5 * timeonce;
                                  if (timeonce == 0) {
                                    score += x2score * 10;
                                    exp += 5;
                                  }
                                }
                              }
                              onpress();
                              setState(() {});
                            },
                            child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 20),
                                width: MediaQuery.of(context).size.width - 70,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: pick
                                      ? this
                                              .widget
                                              .query[index]
                                              .answers[2]
                                              .score
                                          ? Colors.green
                                          : Colors.red
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'C. ${this.widget.query[index].answers[2].answerText}',
                                  style: TextStyle(
                                    fontFamily: "Mono",
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          )
                        : Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            width: MediaQuery.of(context).size.width - 70,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                    fuc4
                        ? InkWell(
                            onTap: () {
                              pick = true;
                              youranwser = "D";
                              if (this.widget.query[index].answers[3].score ==
                                      true &&
                                  youranwser == "D") {
                                addgold();
                                if (timeonce > 5) {
                                  score += x2score * 50;
                                  exp += 30;
                                } else {
                                  score += x2score * 10 * timeonce;
                                  exp += 5 * timeonce;
                                  if (timeonce == 0) {
                                    score += x2score * 10;
                                    exp += 5;
                                  }
                                }
                              }
                              onpress();
                              setState(() {});
                            },
                            child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 20),
                                width: MediaQuery.of(context).size.width - 70,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: pick
                                      ? this
                                              .widget
                                              .query[index]
                                              .answers[3]
                                              .score
                                          ? Colors.green
                                          : Colors.red
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'D. ${this.widget.query[index].answers[3].answerText}',
                                  style: TextStyle(
                                    fontFamily: "Mono",
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          )
                        : Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            width: MediaQuery.of(context).size.width - 70,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                      fuc5050();
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
                              : AssetImage('img/level1.png'),
                          fit: BoxFit.fill),
                    ),
                    child: Text(
                      '50:50',
                      style: TextStyle(
                        fontFamily: "Mono",
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 255, 255),
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
                        color: Color.fromARGB(255, 255, 255, 255),
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
                      fucmaxster();
                      fuc_master = false;
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
                              : AssetImage('img/level1.png'),
                          fit: BoxFit.fill),
                    ),
                    child: Text(
                      'hỏi thầy',
                      style: TextStyle(
                        fontFamily: "Mono",
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 255, 255),
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
                        color: Color.fromARGB(255, 255, 255, 255),
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
                    if (fuc_x2) {
                      gold -= 200;
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
                              : AssetImage('img/level1.png'),
                          fit: BoxFit.fill),
                    ),
                    child: Text(
                      'X2 \n số điểm',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Mono",
                        fontSize: 14,
                        color: Color.fromARGB(255, 255, 255, 255),
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
                        color: Color.fromARGB(255, 255, 255, 255),
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
                    if (fuc_time) {
                      gold -= 50;
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
                              : AssetImage('img/level1.png'),
                          fit: BoxFit.fill),
                    ),
                    child: Text(
                      '+5 giây',
                      style: TextStyle(
                        fontFamily: "Mono",
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '50',
                      style: TextStyle(
                        fontFamily: "Mono",
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 255, 255),
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
}

class EndGame extends StatefulWidget {
  EndGame(
      {super.key,
      required this.object,
      required this.level,
      required this.goldplus,
      required this.gold,
      required this.score,
      required this.exp});
  int level;
  int gold;
  int goldplus;
  int score;
  int exp;
  String object;
  @override
  State<EndGame> createState() => _EndGameState();
}

class _EndGameState extends State<EndGame> {
  String id = "";
  Future<Profile> get_id() async {
    final SharedPreferences cookie = await SharedPreferences.getInstance();
    id = cookie.getString('id') != null ? cookie.getString('id')! : '';
    final data =
        await FirebaseFirestore.instance.collection('profiles').doc("$id");
    final snap = await data.get();

    final prf = Profile.fromJson(snap.data()!);
    int totalsrc = prf.total;
    totalsrc += this.widget.score;
    data.update({'total': totalsrc});
    int oldlevel = prf.level;
    int exptopup = percentexp(prf);
    int nowexp = prf.exp + widget.exp;
    int totalgold = widget.gold + widget.goldplus;
    if (nowexp >= exptopup) {
      oldlevel++;
      exptopup = nowexp - exptopup;

      data.update({'gold': totalgold, 'exp': exptopup, 'level': oldlevel});
    } else {
      data.update({'gold': totalgold, 'exp': nowexp});
    }
    if (widget.object == "Lịch Sử") {
      final data1 = await FirebaseFirestore.instance
          .collection('objecthistories')
          .doc("$id");
      final snap1 = await data.get();
      int i = widget.level;
      data1.update({'level${i + 1}': true, 'score${i}': widget.score});
    } else if (widget.object == "Địa Lý") {
      final data1 = await FirebaseFirestore.instance
          .collection('objectgeography')
          .doc("$id");
      final snap1 = await data.get();
      int i = widget.level;
      data1.update({'level${i + 1}': true, 'score${i}': widget.score});
    } else if (widget.object == "Văn Học") {
      final data1 = await FirebaseFirestore.instance
          .collection('objectliterature')
          .doc("$id");
      final snap1 = await data.get();
      int i = widget.level;
      data1.update({'level${i + 1}': true, 'score${i}': widget.score});
    } else if (widget.object == "Âm Nhạc") {
      final data1 = await FirebaseFirestore.instance
          .collection('objectmucsic')
          .doc("$id");
      final snap1 = await data.get();
      int i = widget.level;
      data1.update({'level${i + 1}': true, 'score${i}': widget.score});
    } else if (widget.object == "Lập Trình") {
      final data1 = await FirebaseFirestore.instance
          .collection('objectprograming')
          .doc("$id");
      final snap1 = await data.get();
      int i = widget.level;
      data1.update({'level${i + 1}': true, 'score${i}': widget.score});
    }
    return prf;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: const Color(0x00000000),
        child: FutureBuilder(
          future: get_id(),
          builder: (BuildContext context, AsyncSnapshot<Profile> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Kết nối có lỗi"),
              );
            }
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 15, bottom: 50),
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('img/frametable.png'),
                          fit: BoxFit.fill),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Level ${this.widget.level}',
                          style: TextStyle(
                              fontFamily: 'UTM',
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        this.widget.score >= 200
                            ? Image.asset(
                                'img/sao3.png',
                                width: 200,
                                height: 80,
                                fit: BoxFit.fill,
                              )
                            : (this.widget.score >= 150
                                ? Image.asset(
                                    'img/sao2.png',
                                    width: 200,
                                    height: 80,
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    'img/sao1.png',
                                    width: 200,
                                    height: 80,
                                    fit: BoxFit.fill,
                                  )),
                        Text(
                          '${this.widget.score} Điểm',
                          style: TextStyle(
                              fontFamily: 'UTM',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 50,
                              child: Row(
                                children: [
                                  Text(
                                    '+${this.widget.goldplus}',
                                    style: TextStyle(
                                      fontFamily: "Mono",
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 234, 219, 8),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Image.asset(
                                    'img/coin.png',
                                    width: 40,
                                    height: 40,
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '+${this.widget.exp}',
                                  style: TextStyle(
                                    fontFamily: "Mono",
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 234, 219, 8),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Image.asset(
                                  'img/exp.png',
                                  width: 50,
                                  height: 50,
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 50,
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                             Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 20),
                            alignment: Alignment.topCenter,
                            width: 140,
                            height: 80,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('img/buttonaction.png'),
                                  fit: BoxFit.fill),
                            ),
                            child: Text(
                              'Quay Về',
                              style: TextStyle(
                                fontFamily: "Mono",
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Querrries(
                                      object: widget.object,
                                      level: widget.level)),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 20),
                            alignment: Alignment.topCenter,
                            width: 140,
                            height: 80,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('img/buttonaction.png'),
                                  fit: BoxFit.fill),
                            ),
                            child: Text(
                              'Chơi Lại',
                              style: TextStyle(
                                fontFamily: "Mono",
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else
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
          },
        ));
  }
}
