import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class changename extends StatelessWidget {
  changename({super.key, required this.id});
  String id;

  @override
  Widget build(BuildContext context) {
    final username = TextEditingController();
    return Material(
      color: const Color(0x00000000),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 300.0,
            child: Container(
                margin: const EdgeInsets.only(
                  left: 10,
                ),
                height: 200,
                width: 340,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('img/frame2.png'), fit: BoxFit.fill)),
                child: Container(
                  margin: EdgeInsets.fromLTRB(50, 50, 50, 70),
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        'Nhập Tên Mới:',
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
                      SizedBox(
                        height: 40,
                        width: 220,
                        child: TextField(
                          controller: username,
                          cursorColor: Colors.black,
                          cursorWidth: 3,
                          cursorHeight: 20,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Mono',
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffFF8C4B),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Positioned(
              top: 250,
              child: Container(
                alignment: Alignment.center,
                width: 280,
                height: 90,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/frame1.png'), fit: BoxFit.fill),
                ),
                child: const Text(
                  'Đổi Tên Nhân Vật',
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
                      fontWeight: FontWeight.w800),
                ),
              )),
          Positioned(
            top: 460,
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
                  if (username.text == null || username.text == "") {
                    showDialog(
                        context: context,
                        builder: (context) => _messagebox(
                            context, 'Bạn chưa nhập tên nhân vật.'));
                  } else if (username.text.length > 10) {
                    showDialog(
                        context: context,
                        builder: (context) => _messagebox(
                            context, 'Tên nhân vật không quá 10 ký tự.'));
                  } else {
                    final doc = FirebaseFirestore.instance
                        .collection('profiles')
                        .doc("$id");
                    String name = username.text;
                    doc.update({'character_name': name});
                    showDialog(
                        context: context,
                        builder: (context) => _messagebox(
                            context, 'Thay Đổi Tên Nhân Vật Thành Công.'));
                  }
                },
              ),
            ),
          ),
          Positioned(
              top: 280,
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
      ),
    );
  }
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
                top: 18,
                left: 30,
                child: Text(
                  'Thông Báo',
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
