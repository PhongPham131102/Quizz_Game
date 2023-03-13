import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ontapchangeavatar extends StatefulWidget {
  const ontapchangeavatar({super.key});

  @override
  State<ontapchangeavatar> createState() => _ontapchangeavatarState();
}

class _ontapchangeavatarState extends State<ontapchangeavatar> {
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

  bool avatar1 = false;
  bool avatar2 = false;
  bool avatar3 = false;
  String avatar = "";
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0x00000000),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 200.0,
            child: Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                height: 400,
                width: 340,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('img/frame2.png'), fit: BoxFit.fill)),
                child: Container(
                  margin: EdgeInsets.fromLTRB(15, 40, 20, 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    avatar1 = true;
                                    avatar2 = false;
                                    avatar3 = false;
                                    avatar = "img/avatar.jpg";
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        border: avatar1
                                            ? Border.all(
                                                color: Colors.yellowAccent,
                                                width: 3.0,
                                              )
                                            : Border.all(),
                                        image: DecorationImage(
                                            image: AssetImage('img/frame3.png'),
                                            fit: BoxFit.fill)),
                                    child: Image.asset(
                                      'img/avatar.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    avatar1 = false;
                                    avatar2 = true;
                                    avatar3 = false;
                                    avatar = "img/avatar1.jpg";
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        border: avatar2
                                            ? Border.all(
                                                color: Colors.yellowAccent,
                                                width: 3.0,
                                              )
                                            : Border.all(),
                                        image: DecorationImage(
                                            image: AssetImage('img/frame3.png'),
                                            fit: BoxFit.fill)),
                                    child: Image.asset(
                                      'img/avatar1.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    avatar1 = false;
                                    avatar2 = false;
                                    avatar3 = true;
                                    avatar = "img/avatar2.jpg";
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        border: avatar3
                                            ? Border.all(
                                                color: Colors.yellowAccent,
                                                width: 3.0,
                                              )
                                            : Border.all(),
                                        image: DecorationImage(
                                            image: AssetImage('img/frame3.png'),
                                            fit: BoxFit.fill)),
                                    child: Image.asset(
                                      'img/avatar2.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Positioned(
              top: 190,
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
          Positioned(
            top: 565,
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
                onTap: () {
                  final doc = FirebaseFirestore.instance
                      .collection('profiles')
                      .doc("$id");
                  doc.update({'avatar': avatar});
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
