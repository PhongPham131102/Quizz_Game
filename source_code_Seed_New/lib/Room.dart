import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:init_firebase/playpvp.dart';
import 'package:init_firebase/ready.dart';

import 'already.dart';

class RoomPvp extends StatelessWidget {
  RoomPvp({super.key, required this.roomid, required this.index});
  String roomid;
  int index;

  @override
  Widget build(BuildContext context) {
    final dbRef = FirebaseDatabase.instance.ref('room');
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: FirebaseAnimatedList(
            shrinkWrap: true,
            query: dbRef,
            itemBuilder: (context, snapshot, animation, i) {
              print(index);
              if (snapshot.child('id').value == roomid &&
                  snapshot.child('user2').value != "") {
                return Container(
                    width: _width,
                    height: _height,
                    child: Ready(
                        roomid: roomid,
                        user1: snapshot.child('user1').value.toString(),
                        user2: snapshot.child('user2').value.toString(),
                        index: index));
              } else if(snapshot.child('id').value == roomid &&
                  snapshot.child('user2').value == ""){
                return Container(
                    width: _width,
                    height: _height,
                    padding: EdgeInsets.only(bottom: 30),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('img/background2.png'),
                          fit: BoxFit.fill),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              child: Image.asset(
                                'img/return.png',
                                width: 50,
                                height: 50,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                dbRef.child(roomid).remove();
                              },
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: _width,
                          height: _height - (_height - 400),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                child: Image.asset(
                                  'img/tree.png',
                                  width: 200,
                                  height: 200,
                                ),
                              ),
                              Container(
                                height: _height - (_height - 50),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: const [
                                    Text(
                                      'Đang Tìm Đối Thủ',
                                      style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              offset: Offset(5, 3),
                                              blurRadius: 10,
                                              color: Colors.black,
                                            ),
                                          ],
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontFamily: 'Mono',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'img/light.png',
                                  height: 50,
                                  width: 50,
                                ),
                                const Text(
                                  'Mẹo Nhỏ Mách Bạn:',
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
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            const Text(
                              'khi bạn gặp khó khăn trong việc tìm đáp  án có thể dùng xu để mua quyền trợ giúp nhé !!!',
                              textAlign: TextAlign.center,
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
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ));
              }
              return Container();
            }));
  }
}
