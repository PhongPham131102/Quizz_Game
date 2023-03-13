import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'objects/Object_literatures.dart';
import 'objects/Online.dart';
import 'objects/provider.dart';

// import 'ready.dart';
class ScreenWaiting2 extends StatefulWidget {
  const ScreenWaiting2({super.key});

  @override
  State<ScreenWaiting2> createState() => _ScreenWaiting2State();
}

class _ScreenWaiting2State extends State<ScreenWaiting2> {
  final dbRef = FirebaseDatabase.instance.ref('room');
  Future<List<dynamic>> _LoadDanhSach() async {
    final data;
    data = await HistoryProvider.getAllQuerries();

    return data;
  }

  String id = "";

  get_id() async {
    final SharedPreferences cookie = await SharedPreferences.getInstance();
    id = cookie.getString('id') != null ? cookie.getString('id')! : '';
    setState(() {});
  }

  int time = 0;
  void start() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (time != -1) {
        setState(() {
          time++;
        });
      }
    });
  }

  @override
  void initState() {
    start();
    get_id();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset:
            false, //khi bàn phím xuất hiện sẽ không làm vỡ layout của giao diện
        body: FutureBuilder(
          future: _LoadDanhSach(),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot1) {
            if (snapshot1.hasData) {
              return FirebaseAnimatedList(
                shrinkWrap: true,
                query: dbRef,
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot.child('status').value == false) {
                      //update user 2
                      return Center(child: Text("ok"),);


                    // if (snapshot.child('user1').value.toString() == "") {
                    //   //update user 1
                    // } else {
                    //   //udate user 2
                    //   // update status room
                    // }

                    // return Center(
                    //   child: Text(id.toString()),
                    // );
                  } else {
                    DateTime now = DateTime.now();
                    String idd = now.year.toString() +
                        now.month.toString() +
                        now.day.toString() +
                        now.hour.toString() +
                        now.microsecond.toString();
                    DatabaseReference ref =
                        FirebaseDatabase.instance.ref("room/" + idd);
                    List<dynamic> temp = snapshot1.data![0].queries;
                    Room room = Room(
                        id: idd,
                        status: false,
                        user1: id,
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
                    // if (snapshot.child('user1').value.toString() == "") {
                    //   return Text(snapshot.child('id').value.toString());
                    // } else {
                    //   return Container(
                    //     child: Text("sdgd"),
                    //   );
                    // }
                    if (snapshot.child('user2').value.toString() != "") {
                      return Center(child: Text('vo game'),);
                    }
                    else
                    {
                      return  Center(child: Text('doi ty'),);
                    }
                  }
                },
              );
            } else
              return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
