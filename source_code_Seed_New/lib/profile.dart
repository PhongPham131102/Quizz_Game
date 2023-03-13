import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'objects/Online.dart';
import 'objects/Profile.dart';
import 'changeavatar.dart';

class Profiles extends StatefulWidget {
  Profiles({super.key, required this.isyou, required this.yourid});
  bool isyou;
  String yourid;
  @override
  State<Profiles> createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    Stream<List<Profile>> readprofiles() => FirebaseFirestore.instance
        .collection('profiles')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Profile.fromJson(doc.data())).toList());
    return Material(
        color: const Color(0x00000000),
        child: StreamBuilder<List<Profile>>(
          stream: readprofiles(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Text('Something wrong ${snapshot.error}');
            else if (snapshot.hasData) {
              List<Profile> users = snapshot.data!;
              Profile you = users[0];
              for (int i = 0; i < users.length; i++)
                if (users[i].id == this.widget.yourid) {
                  you = users[i];
                  break;
                }
              return FutureBuilder(
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
                      int winmath = 0;
                      int countmath = 0;
                      for (var i in rooms) {
                        if (i.user1 == this.widget.yourid) {
                          countmath++;
                          if (i.totalscore1 > i.totalscore2) winmath++;
                        } else if (i.user2 == this.widget.yourid) {
                          countmath++;
                          if (i.totalscore1 < i.totalscore2) winmath++;
                        }
                      }
                      double percent=(winmath/countmath)*100;
                      return builduser(you,this.widget.isyou,countmath,percent);
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
                  });
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
        ));
  }

  Widget builduser(Profile user,bool isyou,int countmath,double percent) {
    String percentst = percent.toStringAsFixed(2);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: 60.0,
          child: Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 100),
              height: 650,
              width: 340,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/frame2.png'), fit: BoxFit.fill)),
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 80, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(90, 0, 90, 0),
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('${user.avatar}'),
                            radius: 40,
                          ),
                          isyou?
                          Positioned(
                            top: 60,
                            right: 0,
                            child: InkWell(
                              child: Image.asset(
                                'img/iconchangename.png',
                                width: 20,
                                height: 20,
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => ontapchangeavatar());
                              },
                            ),
                          ):Container()
                        ],
                      ),
                    ),
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
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontFamily: 'Mono',
                          fontSize: 15,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      'Cấp ${user.level}',
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
                    Container(
                      width: 350,
                      height: 135,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Đối Kháng Ngẫu Nhiên',
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'Mono',
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          ),
                          Container(
                            width: 270,
                            height: 100,
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('img/buttonhome.png'),
                                    fit: BoxFit.fill)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children:  [
                                    Text(
                                      'Số Trận',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 245, 196, 0),
                                          fontFamily: 'Mono',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      '$countmath Trận',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 242, 197, 116),
                                          fontFamily: 'Mono',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                                Container(
                                  color: Color.fromARGB(255, 255, 244, 212),
                                  width: 2,
                                  height: 50,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children:  [
                                    Text(
                                      'Tỷ Lệ Thắng',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 245, 196, 0),
                                          fontFamily: 'Mono',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      '$percentst %',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 242, 197, 116),
                                          fontFamily: 'Mono',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 350,
                      height: 135,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tự Luyện',
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'Mono',
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          ),
                          Container(
                            width: 270,
                            height: 100,
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('img/buttonhome.png'),
                                    fit: BoxFit.fill)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Tổng Điểm',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 245, 196, 0),
                                          fontFamily: 'Mono',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      '${user.total}',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 242, 197, 116),
                                          fontFamily: 'Mono',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
        Positioned(
            top: 30,
            child: Container(
              alignment: Alignment.center,
              width: 280,
              height: 90,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('img/frame1.png'), fit: BoxFit.fill),
              ),
              child: const Text(
                'Trang Cá Nhân',
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
    );
  }
}
