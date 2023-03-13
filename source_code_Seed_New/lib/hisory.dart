import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:init_firebase/detailhisory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'objects/Online.dart';
import 'objects/Profile.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

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
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    padding: EdgeInsets.only(bottom: 15),
                    alignment: Alignment.center,
                    width: 280,
                    height: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('img/frame.png'), fit: BoxFit.fill),
                    ),
                    child: const Text(
                      'Lịch Sử Đấu',
                      style: TextStyle(
                          shadows: [
                            Shadow(
                              offset: Offset(5, 3),
                              blurRadius: 10,
                              color: Colors.black,
                            ),
                          ],
                          color: Colors.white,
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
              height: MediaQuery.of(context).size.height - 150,
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
                            final users = snapshot.data!;
                            return Component(
                              rooms: rooms,
                              profiles: users,
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
            )
          ],
        ),
      ),
    );
  }
}

class Component extends StatefulWidget {
  Component({super.key, required this.rooms, required this.profiles});
  List<Room> rooms;
  List<Profile> profiles;
  @override
  State<Component> createState() => _ComponentState();
}

class _ComponentState extends State<Component> {
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
    return ListView(
      children: [
        for (var i = 0; i < this.widget.rooms.length; i++)
          if (this.widget.rooms[i].user1 == id ||
              this.widget.rooms[i].user2 == id)
            detail(this.widget.rooms[i], this.widget.profiles)
      ],
    );
  }

  Widget detail(Room room, List<Profile> profiles) {
    Profile you=Profile(id: id, character_name: 'character_name', level: 1, rank: 'rank', rank_detail: 'rank_detail', avatar: 'img/avatar.jpg', exp: 55, star: 1, gold: 1, total: 1);
    Profile notyou=Profile(id: id, character_name: 'character_name', level: 1, rank: 'rank', rank_detail: 'rank_detail', avatar: 'img/avatar.jpg', exp: 55, star: 1, gold: 1, total: 1);
    
    bool win = true;
    if (room.user1 == id) {
      for (var profile in profiles) {
        if (profile.id == id)
          you = profile;
        else if (profile.id == room.user2) notyou = profile;
      }
      if (room.totalscore1 > room.totalscore2)
        win = true;
      else
        win = false;
    } else {
      for (var profile in profiles) {
        if (profile.id == id)
          you = profile;
        else if (profile.id == room.user1) notyou = profile;
      }
      if (room.totalscore2 > room.totalscore1)
        win = true;
      else
        win = false;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: win
              ? Text(
                  'Chiến Thắng',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 238, 230, 8),
                      fontFamily: 'Mono',
                      fontSize: 21,
                      fontWeight: FontWeight.w800),
                )
              : Text(
                  'Thất Bại',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Mono',
                      fontSize: 21,
                      fontWeight: FontWeight.w800),
                ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                         DetailHistory(roomid: room.id)));
          },
          child: Container(
            width: MediaQuery.of(context).size.width - 20,
            height: 110,
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.only(left: 20, right: 15),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('img/buttonhome1.png'),
                    fit: BoxFit.fill)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            foregroundColor: Colors.red,
                            backgroundImage: AssetImage('${you.avatar}'),
                            radius: 25,
                          ),
                          Text(
                           "  "+ you.character_name ,
                            style: TextStyle(
                                color: Colors.yellowAccent,
                                fontFamily: 'Mono',
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                // const Text(
                //   'VS',
                //   style: TextStyle(
                //       color: Color.fromARGB(255, 255, 255, 255),
                //       fontFamily: 'Mono',
                //       fontSize: 20,
                //       fontWeight: FontWeight.w800),
                // ),
                Image.asset("img/vs.png",width: 60,height: 60,),
                Container(
                  padding: EdgeInsets.only(top: 20, right: 5, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: 'Mono',
                            fontSize: 14,
                            fontWeight: FontWeight.w800),
                      ),
                      Row(
                        children:  [
                          Text(
                            notyou.character_name+"  ",
                            style: TextStyle(
                                color: Colors.yellowAccent,
                                fontFamily: 'Mono',
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          ),
                          CircleAvatar(
                            backgroundImage: AssetImage('${notyou.avatar}'),
                            radius: 25,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
