import 'package:flutter/material.dart';
import 'package:init_firebase/objects/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'challengeme.dart';
import 'screen_waiting.dart';

class rule extends StatefulWidget {
  const rule({super.key});

  @override
  State<rule> createState() => _ruleState();
}

class _ruleState extends State<rule> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0x00000000),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 40,
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              height: MediaQuery.of(context).size.height - 50,
              width: 360,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/frame2.png'), fit: BoxFit.fill)),
              child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 50, 30, 80),
                  child: ListView(
                    children: [
                      Container(
                        height: 650,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Đối Kháng Ngẫu Nhiên',
                              style: TextStyle(
                                  shadows: [
                                    Shadow(
                                      offset: Offset(5, 3),
                                      blurRadius: 10,
                                      color: Colors.black,
                                    ),
                                  ],
                                  color: Color.fromARGB(255, 217, 221, 7),
                                  fontFamily: 'UTM',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            Image.asset(
                              'img/dkng.png',
                              width: 360,
                              height: 90,
                              fit: BoxFit.fill,
                            ),
                            const Text(
                              '- Ở giao diện màn hình chính nhấn vào đấu luyện .\n- Bạn hãy chọn 1 trong 5 chủ đề (lịch sử, địa lý, văn học, âm nhạc và lập trình).\n- Sau khi đã chọn xong thì mỗi chủ đề sẽ có các level tương ứng .\n- Trả lời đúng để đi tiếp , sai sẽ kết thúc lượt chơi\n- bạn hãy chọn level được mở khóa trả lời đúng và chính xác để mở khóa các level tiếp theo bạn nhé !',
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
                                  fontWeight: FontWeight.w600),
                            ),
                            const Text(
                              'Tự Chơi',
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                    offset: Offset(5, 3),
                                    blurRadius: 10,
                                    color: Colors.black,
                                  ),
                                ],
                                color: Color.fromARGB(255, 217, 221, 7),
                                fontFamily: 'UTm',
                                fontSize: 18,
                              ),
                            ),
                            Image.asset(
                              'img/tl.png',
                              width: 360,
                              height: 90,
                              fit: BoxFit.fill,
                            ),
                            const Text(
                              '- Ở giao diện màn hình chính nhấn vào đối kháng ngẫu nhiên.\n- Sau khi tìm thấy trận nhấn vào nút sãn sẵng để tham gia đấu .\n- Trả lời 5 câu hỏi trong trận đấu\n- Trả lời đúng và nhanh để đạt điểm cao\n- Lưu ý :Câu hỏi số 5 nhân đôi số điểm bạn nhé !.',
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
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Positioned(
            bottom: 5,
            child: Container(
              width: 150,
              height: 50,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/button1.png'), fit: BoxFit.fill)),
              child: InkWell(
                child: const Text(
                  'Đã Hiểu',
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
          Positioned(
              top: 10,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 40),
                    alignment: Alignment.center,
                    width: 250,
                    height: 80,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('img/frame.png'), fit: BoxFit.fill),
                    ),
                    child: const Text(
                      'Luật Chơi',
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

class RuleDknn extends StatefulWidget {
   RuleDknn({super.key,required this.profile});
  Profile profile;
  @override
  State<RuleDknn> createState() => _RuleDknnState();
}

class _RuleDknnState extends State<RuleDknn> {
  bool isChecked = false;
  Color getColor(Set<MaterialState> states) {
    return Color.fromARGB(255, 183, 222, 6);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0x00000000),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            bottom: 10,
            child: Container(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                height: 300,
                width: 360,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('img/frame2.png'), fit: BoxFit.fill)),
                child: ListView(
                  children: [
                    Container(
                      height: 240,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Đối Kháng Ngẫu Nhiên',
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                    offset: Offset(5, 3),
                                    blurRadius: 10,
                                    color: Colors.black,
                                  ),
                                ],
                                color: Color.fromARGB(255, 217, 221, 7),
                                fontFamily: 'UTM',
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                          Image.asset(
                            'img/dkng.png',
                            width: 360,
                            height: 90,
                            fit: BoxFit.fill,
                          ),
                          const Text(
                            '- tìm đối thủ ngẫu nhiên đang chơi.\n- trả lời 5 câu hỏi , X2 điểm ở câu 5.\n- trả lời đúng và nhanh để đạt điểm cao.\n- Chiến thắng để lên hạng , thất bại sẽ rớt hạng bạn nhé !.',
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
                                fontWeight: FontWeight.w600),
                          ),
                         Container(width: 20,height: 40,)
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 150,
              height: 50,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/button1.png'), fit: BoxFit.fill)),
              child: InkWell(
                child: const Text(
                  'Đã Hiểu',
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ScreenWaiting(profile: this.widget.profile)));
                },
              ),
            ),
          ),
          Positioned(
              bottom: 270,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 40),
                    alignment: Alignment.center,
                    width: 250,
                    height: 90,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('img/frame.png'), fit: BoxFit.fill),
                    ),
                    child: const Text(
                      'Hướng Dẫn',
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

class RuleTl extends StatefulWidget {
  const RuleTl({super.key});

  @override
  State<RuleTl> createState() => _RuleTlState();
}

class _RuleTlState extends State<RuleTl> {
  Future<void> set_is_checkedTL(bool value) async {
    final SharedPreferences cookie = await SharedPreferences.getInstance();
    cookie.setBool('is_checkedTL', value);
  }

  bool isChecked = false;
  Color getColor(Set<MaterialState> states) {
    return Color.fromARGB(255, 183, 222, 6);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0x00000000),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            bottom: 10,
            child: Container(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                height: 300,
                width: 360,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('img/frame2.png'), fit: BoxFit.fill)),
                child: ListView(
                  children: [
                    Container(
                      height: 260,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tự Luyện',
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                    offset: Offset(5, 3),
                                    blurRadius: 10,
                                    color: Colors.black,
                                  ),
                                ],
                                color: Color.fromARGB(255, 217, 221, 7),
                                fontFamily: 'UTM',
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                          Image.asset(
                            'img/tl.png',
                            width: 360,
                            height: 90,
                            fit: BoxFit.fill,
                          ),
                          const Text(
                            '- Chơi một mình, trả lời đúng để đi tiếp, sai sẽ kết thúc lượt chơi.\n- trả lời nhanh và chính xác để nhận được số sao và điểm tối đa.\n- vượt qua các level của mỗi chủ đề sẽ có cơ hội nhận vàng và kinh nghiệm .',
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
                                fontWeight: FontWeight.w600),
                          ),
 Container(width: 20,height: 40,)
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 150,
              height: 50,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/button1.png'), fit: BoxFit.fill)),
              child: InkWell(
                child: const Text(
                  'Đã Hiểu',
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChallengeMe()));
                },
              ),
            ),
          ),
          Positioned(
              bottom: 270,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 40),
                    alignment: Alignment.center,
                    width: 250,
                    height: 90,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('img/frame.png'), fit: BoxFit.fill),
                    ),
                    child: const Text(
                      'Hướng Dẫn',
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
