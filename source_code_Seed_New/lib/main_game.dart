import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'hisory.dart';
import 'main.dart';
import 'objects/Profile.dart';
import 'profile.dart';
import 'rank.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'challengeme.dart';
import 'function/rank.dart';
import 'changename.dart';
import 'rule.dart';
// import 'package:seed_new/rule.dart';
// import 'package:seed_new/screens/history.dart';
// import 'package:seed_new/screens/rank.dart';
// import 'screen_waiting.dart';
// import 'challengeme.dart';

class MainGame extends StatefulWidget {
  MainGame({super.key});
  @override
  State<MainGame> createState() => _MainGameState();
}

class _MainGameState extends State<MainGame> {
  AudioPlayer player = AudioPlayer();
  void playLocal() async {
    player.setVolume(1);
    await player.play(AssetSource("audio/select.mp3"));
    setState(() {
      
    });
  }

  String id = "";
  bool is_checked_TL = false;
  Future<void> set_is_logined(String value) async {
    final SharedPreferences cookie = await SharedPreferences.getInstance();
    cookie.setString('is_logined', value);
  }

  Future<void> set_id(String value) async {
    final SharedPreferences cookie = await SharedPreferences.getInstance();
    cookie.setString('id', value);
  }

  get_id() async {
    final SharedPreferences cookie = await SharedPreferences.getInstance();
    id = cookie.getString('id') != null ? cookie.getString('id')! : '';
    setState(() {});
  }

  get_checked_TL() async {
    final SharedPreferences cookie = await SharedPreferences.getInstance();
    is_checked_TL = cookie.getBool('is_checkedTL') != null
        ? cookie.getBool('is_checkedTL')!
        : false;
    setState(() {});
  }

  @override
  void initState() {
    get_id();
    get_checked_TL();
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
    Widget builduser(Profile user) {
      if (user.id == id) {
        double _height = MediaQuery.of(context).size.height;
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('img/background1.png'), fit: BoxFit.fill),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: _height,
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.only(left: 35),
                              width: 120,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('img/icongold.png'),
                                      fit: BoxFit.fill)),
                              child: Text(
                                '${user.gold}',
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
                            onTap: () {},
                          ),
                          InkWell(
                            child: Image.asset(
                              'img/setting.png',
                              height: 50,
                              width: 50,
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => _ontapsetting());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    child: Container(
                        width: 300,
                        height: 170,
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('img/treetable1.png'),
                                fit: BoxFit.fill)),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(12, 86, 0, 0),
                          child: Row(
                            children: [
                              InkWell(
                                child: Image.asset(
                                  '${user.avatar}',
                                  width: 55,
                                  height: 60,
                                  fit: BoxFit.fill,
                                ),
                                onTap: () {
                                 playLocal();
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          Profiles(isyou: true, yourid: id));
                                },
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(25, 10, 0, 0),
                                width: 180,
                                height: 70,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Column(
                                            children: [
                                              Text(
                                                '${user.character_name}',
                                                style: TextStyle(
                                                    shadows: [
                                                      Shadow(
                                                        offset: Offset(5, 3),
                                                        blurRadius: 10,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                    color: Colors.yellowAccent,
                                                    fontFamily: 'Mono',
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              Text(
                                                'cấp : ${user.level}',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    shadows: [
                                                      Shadow(
                                                        offset: Offset(5, 3),
                                                        blurRadius: 10,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 106),
                                                    fontFamily: 'Mono',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          child: Image.asset(
                                            'img/iconchangename.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    changename(id: user.id));
                                          },
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(20, 15, 0, 0),
                                          width: 100,
                                          height: 3,
                                          child: Row(
                                            children: [
                                              Container(
                                                color: Color.fromARGB(
                                                    255, 17, 219, 24),
                                                width: exp(user).toDouble(),
                                                height: 3,
                                              ),
                                              Container(
                                                color: Colors.white,
                                                width: (100 - exp(user))
                                                    .toDouble(),
                                                height: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(5, 15, 0, 0),
                                          child: Text(
                                            '${user.exp}/${Maxexp(user)}',
                                            style: TextStyle(
                                                shadows: [
                                                  Shadow(
                                                    offset: Offset(5, 3),
                                                    blurRadius: 10,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                                color: Color.fromARGB(
                                                    255, 9, 223, 16),
                                                fontFamily: 'Mono',
                                                fontSize: 11,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                  Positioned(
                    left: -15,
                    top: 180,
                    child: Container(
                        width: 110,
                        height: 115,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('${Bg_Rank(user)}'),
                                fit: BoxFit.fill)),
                        child: Container(
                            margin: EdgeInsets.only(top: 15),
                            padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                            width: 100,
                            height: 60,
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  '${Icon_Rank(user)}',
                                  width: 35,
                                  height: 35,
                                ),
                                Text(
                                  user.rank == "Trường Đời"
                                      ? "${user.rank_detail} Sao"
                                      : "${user.rank_detail}",
                                  softWrap: true,
                                  style: TextStyle(
                                      color: user.rank == "Trường Đời"
                                          ? Color.fromARGB(255, 202, 232, 6)
                                          : Color.fromARGB(255, 201, 232, 25),
                                      fontFamily: 'Mono',
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ))),
                  ),
                  Positioned(
                      top: 300,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Container(
                                width: 260,
                                height: 75,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('img/buttonhome1.png'),
                                        fit: BoxFit.fill)),
                                child: const Text(
                                  'Đối Kháng Ngẫu Nhiên',
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
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        RuleDknn(profile: user));
                              },
                            ),
                            InkWell(
                              child: Container(
                                width: 260,
                                height: 75,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('img/buttonhome1.png'),
                                        fit: BoxFit.fill)),
                                child: const Text(
                                  'Đấu Luyện',
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
                                if (is_checked_TL == false) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => RuleTl());
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ChallengeMe()));
                                }
                              },
                            ),
                            InkWell(
                              child: Container(
                                width: 260,
                                height: 75,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('img/buttonhome1.png'),
                                        fit: BoxFit.fill)),
                                child: const Text(
                                  'Xếp Hạng',
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Rank()));
                              },
                            ),
                            InkWell(
                              child: Container(
                                width: 260,
                                height: 75,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('img/buttonhome1.png'),
                                        fit: BoxFit.fill)),
                                child: const Text(
                                  'Lịch Sử',
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const History()));
                              },
                            ),
                            InkWell(
                              child: Container(
                                width: 260,
                                height: 75,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('img/buttonhome1.png'),
                                        fit: BoxFit.fill)),
                                child: const Text(
                                  'Thoát',
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
                                set_is_logined('');
                                set_id('');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyApp()),
                                );
                              },
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset:
            false, //khi bàn phím xuất hiện sẽ không làm vỡ layout của giao diện
        body: Center(
          child: StreamBuilder<List<Profile>>(
            stream: readprofiles(),
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Text('Something wrong ${snapshot.error}');
              else if (snapshot.hasData) {
                final users = snapshot.data!;
                return ListView(
                  children: users.map(builduser).toList(),
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
        ));
  }
}

class _ontapsetting extends StatefulWidget {
  const _ontapsetting({super.key});

  @override
  State<_ontapsetting> createState() => __ontapsettingState();
}

class __ontapsettingState extends State<_ontapsetting> {
  double currentvol = 0.5;
  AudioPlayer player = AudioPlayer();
  AudioCache cache = AudioCache();

  @override
  void initState() {
    super.initState();
    PerfectVolumeControl.hideUI = false;
    PerfectVolumeControl.setVolume(currentvol);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0x00000000),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 150.0,
            child: Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                height: 400,
                width: 360,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('img/frame4.png'), fit: BoxFit.fill)),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(50, 80, 50, 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '    Nhạc Nền',
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
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'img/music.png',
                                height: 50,
                                width: 50,
                              ),
                              Slider(
                                min: 0,
                                max: 1,
                                divisions: 100,
                                activeColor: Color.fromARGB(255, 107, 226, 9),
                                inactiveColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                thumbColor: Color.fromARGB(255, 107, 226, 9),
                                value: currentvol,
                                onChanged: (value) {
                                  currentvol = value;
                                  PerfectVolumeControl.setVolume(
                                      value); //set new volume
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context, builder: (context) => rule());
                        },
                        child: Container(
                          width: 180,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('img/button4.png'),
                                  fit: BoxFit.fill)),
                          child: const Text(
                            'LUẬT CHƠI',
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
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Positioned(
            top: 510,
            child: Container(
              width: 100,
              height: 50,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/button1.png'), fit: BoxFit.fill)),
              child: InkWell(
                child: const Text(
                  'Lưu',
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
                onTap: () {},
              ),
            ),
          ),
          Positioned(
              top: 120,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 40),
                    alignment: Alignment.center,
                    width: 200,
                    height: 70,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('img/frame1.png'),
                          fit: BoxFit.fill),
                    ),
                    child: const Text(
                      'Cài Đặt',
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
                  InkWell(
                    child: Image.asset(
                      'img/cancelbutton.png',
                      width: 50,
                      height: 50,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              )),
        ],
      ),
    );
  }
}

_await(BuildContext context) {
  return Material(
      color: const Color(0x00000000), child: Center(
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
                  ));
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
