import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'objects/Object_Hisories.dart';
import 'querries.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:seed_new/screens/play1.dart';
class Subject_History extends StatefulWidget {
  const Subject_History({super.key});

  @override
  State<Subject_History> createState() => _Subject_HistoryState();
}

class _Subject_HistoryState extends State<Subject_History> {
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

  Future<List<ObjectHistory>> fetchhistory() async {
    var records =
        await FirebaseFirestore.instance.collection('objecthistories').get();
    final _list = records.docs
        .map((e) => ObjectHistory(
            id: e["id"],
            level1: e["level1"],
            score1: e["score1"],
            level2: e["level2"],
            score2: e["score2"],
            level3: e["level3"],
            score3: e["score3"],
            level4: e["level4"],
            score4: e["score4"]))
        .toList();

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    Widget builduser(ObjectHistory user) {
      if (user.id == id) {
        double _height = MediaQuery.of(context).size.height;
        return Column(
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
                      'Lịch Sử',
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Querrries(object: "Lịch Sử", level: 1)),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: user.level1 ? 100 : 120,
                              height: 150,
                            ),
                            user.level1
                                ? Positioned(
                                    top: 20,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('img/level.png'),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    top: 20,
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'img/levelclose.png'),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ),
                            user.score1 == 0
                                ? Container()
                                : (user.score1 >= 200
                                    ? Positioned(
                                        left: 5,
                                        child: Image.asset(
                                          'img/sao3.png',
                                          width: 90,
                                          height: 50,
                                        ),
                                      )
                                    : (user.score1 >= 150
                                        ? Positioned(
                                            left: 5,
                                            child: Image.asset(
                                              'img/sao2.png',
                                              width: 90,
                                              height: 50,
                                            ),
                                          )
                                        : Positioned(
                                            left: 5,
                                            child: Image.asset(
                                              'img/sao1.png',
                                              width: 90,
                                              height: 50,
                                            ),
                                          ))),
                            Positioned(
                              top: 45,
                              left: 25,
                              child: Text(
                                'Level \n 1',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'UTM',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            user.score1 > 0
                                ? Positioned(
                                    bottom: 0,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5),
                                      width: 100,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('img/banner.png'),
                                            fit: BoxFit.fill),
                                      ),
                                      child: Text(
                                        '${user.score1..toString()}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'UTM',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ))
                                : Container()
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (user.level2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Querrries(object: "Lịch Sử", level: 2)),
                            );
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: user.level2 ? 100 : 120,
                              height: 150,
                            ),
                            user.level2
                                ? Positioned(
                                    top: 20,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('img/level.png'),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    top: 20,
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'img/levelclose.png'),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ),
                            user.score2 == 0
                                ? Container()
                                : (user.score2 >= 200
                                    ? Positioned(
                                        left: 5,
                                        child: Image.asset(
                                          'img/sao3.png',
                                          width: 90,
                                          height: 50,
                                        ),
                                      )
                                    : (user.score2 >= 150
                                        ? Positioned(
                                            left: 5,
                                            child: Image.asset(
                                              'img/sao2.png',
                                              width: 90,
                                              height: 50,
                                            ),
                                          )
                                        : Positioned(
                                            left: 5,
                                            child: Image.asset(
                                              'img/sao1.png',
                                              width: 90,
                                              height: 50,
                                            ),
                                          ))),
                            Positioned(
                              top: 45,
                              left: 25,
                              child: Text(
                                'Level \n 2',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'UTM',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            user.score2 > 0
                                ? Positioned(
                                    bottom: 0,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5),
                                      width: 100,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('img/banner.png'),
                                            fit: BoxFit.fill),
                                      ),
                                      child: Text(
                                        '${user.score2.toString()}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'UTM',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ))
                                : Container()
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (user.level3) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Querrries(object: "Lịch Sử", level: 3)),
                            );
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: user.level3 ? 100 : 120,
                              height: 150,
                            ),
                            user.level3
                                ? Positioned(
                                    top: 20,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('img/level.png'),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    top: 20,
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'img/levelclose.png'),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ),
                            user.score3 == 0
                                ? Container()
                                : (user.score3 >= 200
                                    ? Positioned(
                                        left: 5,
                                        child: Image.asset(
                                          'img/sao3.png',
                                          width: 90,
                                          height: 50,
                                        ),
                                      )
                                    : (user.score3 >= 150
                                        ? Positioned(
                                            left: 5,
                                            child: Image.asset(
                                              'img/sao2.png',
                                              width: 90,
                                              height: 50,
                                            ),
                                          )
                                        : Positioned(
                                            left: 5,
                                            child: Image.asset(
                                              'img/sao1.png',
                                              width: 90,
                                              height: 50,
                                            ),
                                          ))),
                            Positioned(
                              top: 45,
                              left: 25,
                              child: Text(
                                'Level \n 3',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'UTM',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            user.score3 > 0
                                ? Positioned(
                                    bottom: 0,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5),
                                      width: 100,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('img/banner.png'),
                                            fit: BoxFit.fill),
                                      ),
                                      child: Text(
                                        '${user.score3.toString()}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'UTM',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ))
                                : Container()
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          if (user.level4) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Querrries(object: "Lịch Sử", level: 4)),
                            );
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: user.level4 ? 100 : 120,
                              height: 150,
                            ),
                            user.level4
                                ? Positioned(
                                    top: 20,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('img/level.png'),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    top: 20,
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'img/levelclose.png'),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ),
                            user.score4 == 0
                                ? Container()
                                : (user.score4 >= 200
                                    ? Positioned(
                                        left: 5,
                                        child: Image.asset(
                                          'img/sao3.png',
                                          width: 90,
                                          height: 50,
                                        ),
                                      )
                                    : (user.score4 >= 150
                                        ? Positioned(
                                            left: 5,
                                            child: Image.asset(
                                              'img/sao2.png',
                                              width: 90,
                                              height: 50,
                                            ),
                                          )
                                        : Positioned(
                                            left: 5,
                                            child: Image.asset(
                                              'img/sao1.png',
                                              width: 90,
                                              height: 50,
                                            ),
                                          ))),
                            Positioned(
                              top: 45,
                              left: 25,
                              child: Text(
                                'Level \n 4',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'UTM',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            user.score4 > 0
                                ? Positioned(
                                    bottom: 0,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5),
                                      width: 100,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('img/banner.png'),
                                            fit: BoxFit.fill),
                                      ),
                                      child: Text(
                                        '${user.score1..toString()}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'UTM',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ))
                                : Container()
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      } else {
        return Container();
      }
    }

    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('img/background3.png'), fit: BoxFit.fill),
          ),
          child: FutureBuilder<List<ObjectHistory>>(
            future: fetchhistory(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Mất kết nối với máy chủ");
              } else if (snapshot.hasData) {
                final hsr = snapshot.data!;
                return ListView(
                  children: hsr.map(builduser).toList(),
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
    );
  }
}
