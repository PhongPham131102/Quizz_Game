import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:init_firebase/Room.dart';
import 'package:init_firebase/objects/Profile.dart';
import 'package:uuid/uuid.dart';
import 'objects/querries.dart';
import 'ready.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'objects/Object_literatures.dart';
import 'objects/Online.dart';
import 'objects/provider.dart';

class ScreenWaiting extends StatefulWidget {
  ScreenWaiting({super.key, required this.profile});
  Profile profile;
  @override
  State<ScreenWaiting> createState() => _ScreenWaitingState();
}

class _ScreenWaitingState extends State<ScreenWaiting> {
  List<Querriess> querries = [];
  Future<List<dynamic>> _LoadDanhSach() async {
    final data;
    data = await OnlineProvider.getAllQuerries();
    querries = data;
    return data;
  }

  List<Room> rooms = [];
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  bool haveroom = false;
  String idroom = "";
  Future<List<dynamic>> retrieveRooms() async {
    List<Room> rooms1 = [];
    dbRef.child("room").once().then((snapshot) {
      Map<dynamic, dynamic> messages = snapshot.snapshot.value as Map;
      messages.forEach((key, value) {
        Room rom = Room.fromJson(value);
        rooms.add(rom);
        rooms1.add(rom);
      });
      for (var element in rooms1) {
        if (element.status == false) {
          haveroom = true;
          idroom = element.id;
          setState(() {});
          break;
        }
      }
    });
    return await rooms1;
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
    // _LoadDanhSach();
    // retrieveStudentData();
    // getrooms();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _LoadDanhSach(),
        builder:
            (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot1) {
          if (snapshot1.hasData) {
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
                    String roomid = "";
                    bool status = false;
                    for (var i in rooms) {
                      print(i.id);
                      if (i.status == false) {
                        roomid = i.id;
                        status = true;
                      }
                    }
                    return status
                        ? GetRoom(
                            user2: id,
                            profile: this.widget.profile,
                            idroom: roomid)
                        : CreateRoom(
                            querries: querries,
                            user1: id,
                            profile: this.widget.profile);
                  } else {
                    return Scaffold(
                      body: Center(
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
                                      ),
                    );
                  }
                });
            // return GetRoom(querries: querries);
          } else {
            return Scaffold(
              body: Center(
                child: Center(
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
                  )
              ),
            );
          }
        });
  }
}

class GetRoom extends StatefulWidget {
  GetRoom(
      {super.key,
      required this.user2,
      required this.profile,
      required this.idroom});
  String user2;
  Profile profile;
  String idroom;
  @override
  State<GetRoom> createState() => _GetRoomState();
}

class _GetRoomState extends State<GetRoom> {
  UpdateRoom() {
    final postData = {
      "id": this.widget.idroom,
      "user2": this.widget.user2,
      "status": true
    };
    FirebaseDatabase.instance
        .ref('room/${this.widget.idroom}')
        .update(postData);
  }

  @override
  void initState() {
    UpdateRoom();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(body: RoomPvp(roomid: this.widget.idroom, index: 2));
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: RoomPvp(roomid: this.widget.idroom, index: 2),
    );
  }
}

class CreateRoom extends StatefulWidget {
  CreateRoom(
      {super.key,
      required this.querries,
      required this.user1,
      required this.profile});
  List<Querriess> querries = [];
  String user1;
  Profile profile;
  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  String roomid = "";
  CreateRoom() {
    // DateTime now = DateTime.now();
    // String idd = now.year.toString() +
    //     now.month.toString() +
    //     now.day.toString() +
    //     now.hour.toString() +
    //     now.minute.toString() +
    //     now.second.toString();
    const uuid = Uuid();
    String idd = uuid.v1();
    roomid = idd;
    DatabaseReference ref = FirebaseDatabase.instance.ref("room/" + idd);
    List<dynamic> querriess = this.widget.querries;
    List<dynamic> temp = this.widget.querries;
    temp.shuffle();
    Room room = Room(
        id: idd,
        status: false,
        user1: this.widget.user1,
        user2: "",
        totalscore1: 0,
        totalscore2: 0,
        ready1: false,
        ready2: false,
        answeruser11: "",
        scoreqr11: 0,
        answeruser21: "",
        scoreqr21: 0,
        answeruser12: "",
        scoreqr12: 0,
        answeruser22: "",
        scoreqr22: 0,
        answeruser13: "",
        scoreqr13: 0,
        answeruser23: "",
        scoreqr23: 0,
        answeruser14: "",
        scoreqr14: 0,
        answeruser24: "",
        scoreqr24: 0,
        answeruser15: "",
        scoreqr15: 0,
        answeruser25: "",
        scoreqr25: 0,
        title1: temp[0].title,
        title2: temp[1].title,
        title3: temp[2].title,
        title4: temp[3].title,
        title5: temp[4].title,
        answerText11: temp[0].answers[0].answerText,
        score11: temp[0].answers[0].score,
        answerText12: temp[0].answers[1].answerText,
        score12: temp[0].answers[1].score,
        answerText13: temp[0].answers[2].answerText,
        score13: temp[0].answers[2].score,
        answerText14: temp[0].answers[3].answerText,
        score14: temp[0].answers[3].score,
        answerText21: temp[1].answers[0].answerText,
        score21: temp[1].answers[0].score,
        answerText22: temp[1].answers[1].answerText,
        score22: temp[1].answers[1].score,
        answerText23: temp[1].answers[2].answerText,
        score23: temp[1].answers[2].score,
        answerText24: temp[1].answers[3].answerText,
        score24: temp[1].answers[3].score,
        answerText31: temp[2].answers[0].answerText,
        score31: temp[2].answers[0].score,
        answerText32: temp[2].answers[1].answerText,
        score32: temp[2].answers[1].score,
        answerText33: temp[2].answers[2].answerText,
        score33: temp[2].answers[2].score,
        answerText34: temp[2].answers[3].answerText,
        score34: temp[2].answers[3].score,
        answerText41: temp[3].answers[0].answerText,
        score41: temp[3].answers[0].score,
        answerText42: temp[3].answers[1].answerText,
        score42: temp[3].answers[1].score,
        answerText43: temp[3].answers[2].answerText,
        score43: temp[3].answers[2].score,
        answerText44: temp[3].answers[3].answerText,
        score44: temp[3].answers[3].score,
        answerText51: temp[4].answers[0].answerText,
        score51: temp[4].answers[0].score,
        answerText52: temp[4].answers[1].answerText,
        score52: temp[4].answers[1].score,
        answerText53: temp[4].answers[2].answerText,
        score53: temp[4].answers[2].score,
        answerText54: temp[4].answers[3].answerText,
        score54: temp[4].answers[3].score);
    ref.set(room.toJson()).asStream();
  }

  @override
  void initState() {
    CreateRoom();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: RoomPvp(roomid: roomid, index: 1),
    // );
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: RoomPvp(roomid: roomid, index: 1),
    );
  }
}
