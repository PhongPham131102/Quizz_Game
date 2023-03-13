import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:init_firebase/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'function/rank.dart';
import 'objects/Profile.dart';
// import 'package:seed_new/screens/historydetail.dart';

class Rank extends StatefulWidget {
  const Rank({super.key});

  @override
  State<Rank> createState() => _RankState();
}

class _RankState extends State<Rank> {
  int _index = 0;
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
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('img/background3.png'), fit: BoxFit.fill),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
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
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.only(bottom: 15),
                    alignment: Alignment.center,
                    width: 280,
                    height: 90,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('img/frame.png'), fit: BoxFit.fill),
                    ),
                    child: const Text(
                      'Bảng Xếp Hạng',
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
                          fontSize: 18,
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
                    setState(() {
                      _index = 0;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('img/frame5.png'),
                          fit: BoxFit.fill),
                    ),
                    child: const Text(
                      'Đối Kháng',
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _index = 1;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('img/frame5.png'),
                          fit: BoxFit.fill),
                    ),
                    child: const Text(
                      'Tự Luyện',
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            IndexedStack(
              index: _index,
              children: [
                const RankForYou(),
                const RankPVP(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RankPVP extends StatefulWidget {
  const RankPVP({super.key});

  @override
  State<RankPVP> createState() => _RankPVPState();
}

class _RankPVPState extends State<RankPVP> {
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
        .orderBy("total", descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Profile.fromJson(doc.data())).toList());
    return Container(
      margin: EdgeInsets.only(top: 5, left: 5, right: 5),
      width: MediaQuery.of(context).size.width - 10,
      height: MediaQuery.of(context).size.height - 160,
      child: StreamBuilder<List<Profile>>(
        stream: readprofiles(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Text('Something wrong ${snapshot.error}');
          else if (snapshot.hasData) {
            final users = snapshot.data!;
            Profile you = users[0];
            int st = 0;
            for (var element in users) {
              st++;
              if (element.id == id) {
                you = element;
                break;
              }
            }
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 10,
                      height: MediaQuery.of(context).size.height - 480,
                    ),
                    Positioned(
                      top: 5,
                      left: 115,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => Profiles(
                                  isyou: false, yourid: snapshot.data![0].id));
                        },
                        child: Container(
                          width: 120,
                          height: 170,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'img/1stlogo.png',
                                width: 35,
                                height: 30,
                                fit: BoxFit.fill,
                              ),
                              Stack(
                                children: [
                                  Positioned(
                                    left: 5,
                                    top: 2,
                                    child: CircleAvatar(
                                      foregroundColor: Colors.red,
                                      backgroundImage: AssetImage(
                                          '${snapshot.data![0].avatar}'),
                                      radius: 45,
                                    ),
                                  ),
                                  Image.asset(
                                    'img/st1.png',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  '${snapshot.data![0].character_name}',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 9, 15, 198),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                '${snapshot.data![0].total} điểm',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 213, 239, 13),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: 10,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => Profiles(
                                  isyou: false, yourid: snapshot.data![2].id));
                        },
                        child: Container(
                          width: 100,
                          height: 145,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'img/3stlogo.png',
                                width: 25,
                                height: 20,
                                fit: BoxFit.fill,
                              ),
                              Stack(
                                children: [
                                  Positioned(
                                    left: 12,
                                    top: 2,
                                    child: CircleAvatar(
                                      foregroundColor: Colors.red,
                                      backgroundImage: AssetImage(
                                          '${snapshot.data![2].avatar}'),
                                      radius: 38,
                                    ),
                                  ),
                                  Image.asset(
                                    'img/st3.png',
                                    width: 100,
                                    height: 90,
                                    fit: BoxFit.fill,
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  '${snapshot.data![2].character_name}',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 9, 15, 198),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                '${snapshot.data![2].total} điểm',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 213, 239, 13),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => Profiles(
                                  isyou: false, yourid: snapshot.data![0].id));
                        },
                        child: Container(
                          width: 110,
                          height: 155,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'img/2stlogo.png',
                                width: 30,
                                height: 25,
                                fit: BoxFit.fill,
                              ),
                              Stack(
                                children: [
                                  Positioned(
                                    left: 12,
                                    top: 2,
                                    child: CircleAvatar(
                                      foregroundColor: Colors.red,
                                      backgroundImage: AssetImage(
                                          '${snapshot.data![1].avatar}'),
                                      radius: 38,
                                    ),
                                  ),
                                  Image.asset(
                                    'img/st2.png',
                                    width: 100,
                                    height: 90,
                                    fit: BoxFit.fill,
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  '${snapshot.data![1].character_name}',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 9, 15, 198),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                '${snapshot.data![1].total} điểm',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 213, 239, 13),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Xếp hạng dựa trên mức hạng trong chế độ thi đấu tự luyện cá nhân.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Mono',
                    fontSize: 13,
                    color: Color.fromARGB(255, 245, 237, 132),
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: MediaQuery.of(context).size.height / 3.7,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('img/frame6.png'), fit: BoxFit.fill),
                  ),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, left: 5),
                            width: 300,
                            height: 80,
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('img/buttonhome1.png'),
                                    fit: BoxFit.fill)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        '4.',
                                        style: TextStyle(
                                            fontFamily: 'UTM',
                                            fontSize: 15,
                                            color: Colors.white),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      Profiles(
                                                          isyou: false,
                                                          yourid: snapshot
                                                              .data![3].id));
                                            },
                                            child: CircleAvatar(
                                              foregroundColor: Colors.red,
                                              backgroundImage: AssetImage(
                                                  '${snapshot.data![3].avatar}'),
                                              radius: 25,
                                            ),
                                          ),
                                          Text(
                                              '${snapshot.data![3].character_name}',
                                              style: TextStyle(
                                                  fontFamily: 'UTM',
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${snapshot.data![3].total} điểm',
                                    style: TextStyle(
                                        fontFamily: 'UTM',
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 242, 203, 7)),
                                  ),
                                ]),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, left: 5),
                            width: 300,
                            height: 80,
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('img/buttonhome1.png'),
                                    fit: BoxFit.fill)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        '5.',
                                        style: TextStyle(
                                            fontFamily: 'UTM',
                                            fontSize: 15,
                                            color: Colors.white),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      Profiles(
                                                          isyou: false,
                                                          yourid: snapshot
                                                              .data![4].id));
                                            },
                                            child: CircleAvatar(
                                              foregroundColor: Colors.red,
                                              backgroundImage: AssetImage(
                                                  '${snapshot.data![4].avatar}'),
                                              radius: 25,
                                            ),
                                          ),
                                          Text(
                                              '${snapshot.data![4].character_name}',
                                              style: TextStyle(
                                                  fontFamily: 'UTM',
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${snapshot.data![4].total} điểm',
                                    style: TextStyle(
                                        fontFamily: 'UTM',
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 242, 203, 7)),
                                  ),
                                ]),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  width: 320,
                  height: 80,
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('img/buttonhome1.png'),
                          fit: BoxFit.fill)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '$st',
                              style: TextStyle(
                                  fontFamily: 'UTM',
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  foregroundColor: Colors.red,
                                  backgroundImage: AssetImage('${you.avatar}'),
                                  radius: 25,
                                ),
                                Text('${you.character_name}',
                                    style: TextStyle(
                                        fontFamily: 'UTM',
                                        fontSize: 15,
                                        color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          '${you.total} điểm',
                          style: TextStyle(
                              fontFamily: 'UTM',
                              fontSize: 15,
                              color: Color.fromARGB(255, 242, 203, 7)),
                        ),
                      ]),
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
      ),
    );
  }
}

class RankForYou extends StatefulWidget {
  const RankForYou({super.key});

  @override
  State<RankForYou> createState() => _RankForYouState();
}

class _RankForYouState extends State<RankForYou> {
  Future<List<Profile>> fethaccount() async {
    var records = await FirebaseFirestore.instance.collection('profiles').get();
    final _list = records.docs
        .map((e) => Profile(
            id: e['id'],
            star: e['star'],
            character_name: e['character_name'],
            level: e['level'],
            rank: e['rank'],
            rank_detail: e['rank_detail'],
            avatar: e['avatar'],
            exp: e['exp'],
            gold: e['gold'],
            total: e['total']))
        .toList();
    return _list;
  }

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
        .orderBy("star", descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Profile.fromJson(doc.data())).toList());
    return Container(
      margin: EdgeInsets.only(top: 5, left: 5, right: 5),
      width: MediaQuery.of(context).size.width - 10,
      height: MediaQuery.of(context).size.height - 160,
      child: StreamBuilder<List<Profile>>(
        stream: readprofiles(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Text('Something wrong ${snapshot.error}');
          else if (snapshot.hasData) {
            List<Profile> users = snapshot.data!;
            Profile you = users[0];
            int st = 99;

            for (int i = 0; i < users.length; i++)
              if (users[i].id == id) {
                you = users[i];
                st = i + 1;
                break;
              }
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 10,
                      height: MediaQuery.of(context).size.height - 480,
                    ),
                    Positioned(
                      top: 5,
                      left: 115,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  Profiles(isyou: false, yourid: users[0].id));
                        },
                        child: Container(
                          width: 120,
                          height: 190,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'img/1stlogo.png',
                                width: 35,
                                height: 30,
                                fit: BoxFit.fill,
                              ),
                              Stack(
                                children: [
                                  Positioned(
                                    left: 5,
                                    top: 2,
                                    child: CircleAvatar(
                                      foregroundColor: Colors.red,
                                      backgroundImage:
                                          AssetImage('${users[0].avatar}'),
                                      radius: 45,
                                    ),
                                  ),
                                  Image.asset(
                                    'img/st1.png',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  '${users[0].character_name}',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 9, 15, 198),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    '${Icon_Rank(users[0])}',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.fill,
                                  ),
                                  Text(
                                    users[0].rank == "Trường Đời"
                                        ? "${users[0].rank_detail} Sao"
                                        : "${users[0].rank_detail}",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 213, 239, 13),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 80,
                      left: 10,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  Profiles(isyou: false, yourid: users[2].id));
                        },
                        child: Container(
                          width: 100,
                          height: 165,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'img/3stlogo.png',
                                width: 25,
                                height: 20,
                                fit: BoxFit.fill,
                              ),
                              Stack(
                                children: [
                                  Positioned(
                                    left: 12,
                                    top: 2,
                                    child: CircleAvatar(
                                      foregroundColor: Colors.red,
                                      backgroundImage:
                                          AssetImage('${users[2].avatar}'),
                                      radius: 38,
                                    ),
                                  ),
                                  Image.asset(
                                    'img/st3.png',
                                    width: 100,
                                    height: 90,
                                    fit: BoxFit.fill,
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  '${users[2].character_name}',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 9, 15, 198),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    '${Icon_Rank(users[2])}',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.fill,
                                  ),
                                  Text(
                                    users[2].rank == "Trường Đời"
                                        ? "${users[2].rank_detail} Sao"
                                        : "${users[2].rank_detail}",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 213, 239, 13),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 55,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  Profiles(isyou: false, yourid: users[1].id));
                        },
                        child: Container(
                          width: 110,
                          height: 170,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'img/2stlogo.png',
                                width: 30,
                                height: 25,
                                fit: BoxFit.fill,
                              ),
                              Stack(
                                children: [
                                  Positioned(
                                    left: 12,
                                    top: 2,
                                    child: CircleAvatar(
                                      foregroundColor: Colors.red,
                                      backgroundImage:
                                          AssetImage('${users[1].avatar}'),
                                      radius: 38,
                                    ),
                                  ),
                                  Image.asset(
                                    'img/st2.png',
                                    width: 100,
                                    height: 90,
                                    fit: BoxFit.fill,
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  '${users[1].character_name}',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 9, 15, 198),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    '${Icon_Rank(users[1])}',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.fill,
                                  ),
                                  Text(
                                    users[1].rank == "Trường Đời"
                                        ? "${users[1].rank_detail} Sao"
                                        : "${users[1].rank_detail}",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 213, 239, 13),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Xếp hạng dựa trên mức hạng trong chế độ đối kháng ngẫu nhiên.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Mono',
                    fontSize: 13,
                    color: Color.fromARGB(255, 245, 237, 132),
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: MediaQuery.of(context).size.height / 3.7,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('img/frame6.png'), fit: BoxFit.fill),
                  ),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, left: 5),
                            width: 300,
                            height: 80,
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('img/buttonhome1.png'),
                                    fit: BoxFit.fill)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      '4.',
                                      style: TextStyle(
                                          fontFamily: 'UTM',
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) => Profiles(
                                                    isyou: false,
                                                    yourid: users[3].id));
                                          },
                                          child: CircleAvatar(
                                            foregroundColor: Colors.red,
                                            backgroundImage: AssetImage(
                                                '${users[3].avatar}'),
                                            radius: 25,
                                          ),
                                        ),
                                        Text('${users[3].character_name}',
                                            style: TextStyle(
                                                fontFamily: 'UTM',
                                                fontSize: 15,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      '${Icon_Rank(users[3])}',
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      users[3].rank == "Trường Đời"
                                          ? "${users[3].rank_detail} Sao"
                                          : "${users[3].rank_detail}",
                                      style: TextStyle(
                                          fontFamily: 'UTM',
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(255, 242, 203, 7)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, left: 5),
                            width: 300,
                            height: 80,
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('img/buttonhome1.png'),
                                    fit: BoxFit.fill)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      '5.',
                                      style: TextStyle(
                                          fontFamily: 'UTM',
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) => Profiles(
                                                    isyou: false,
                                                    yourid: users[4].id));
                                          },
                                          child: CircleAvatar(
                                            foregroundColor: Colors.red,
                                            backgroundImage: AssetImage(
                                                '${users[4].avatar}'),
                                            radius: 25,
                                          ),
                                        ),
                                        Text('${users[4].character_name}',
                                            style: TextStyle(
                                                fontFamily: 'UTM',
                                                fontSize: 15,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      '${Icon_Rank(users[4])}',
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      users[4].rank == "Trường Đời"
                                          ? "${users[4].rank_detail} Sao"
                                          : "${users[4].rank_detail}",
                                      style: TextStyle(
                                          fontFamily: 'UTM',
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(255, 242, 203, 7)),
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
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  width: 320,
                  height: 80,
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('img/buttonhome1.png'),
                          fit: BoxFit.fill)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${st}.',
                            style: TextStyle(
                                fontFamily: 'UTM',
                                fontSize: 15,
                                color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                foregroundColor: Colors.red,
                                backgroundImage: AssetImage('${you.avatar}'),
                                radius: 25,
                              ),
                              Text('${you.character_name}',
                                  style: TextStyle(
                                      fontFamily: 'UTM',
                                      fontSize: 15,
                                      color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            '${Icon_Rank(you)}',
                            width: 30,
                            height: 30,
                            fit: BoxFit.fill,
                          ),
                          Text(
                            you.rank == "Trường Đời"
                                ? "${you.rank_detail} Sao"
                                : "${you.rank_detail}",
                            style: TextStyle(
                                fontFamily: 'UTM',
                                fontSize: 15,
                                color: Color.fromARGB(255, 242, 203, 7)),
                          ),
                        ],
                      ),
                    ],
                  ),
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
      ),
    );
  }
}

///
///
