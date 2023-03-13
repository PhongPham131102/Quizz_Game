import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'objects/Account.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with Input {
  List<Account> accounts = [];
  @override
  void initState() {
    feth();
    super.initState();
  }

  feth() async {
    var records = await FirebaseFirestore.instance.collection('accounts').get();
    maprecords(records);
  }

  maprecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map((e) => Account(
            id: e ['id'],
            name: e['name'],
            username: e['username'],  
            password: e['password'],
            phone: e['phone']))
        .toList();
    accounts = _list;
  }

  final formGlobalKey = GlobalKey<FormState>();
  bool _name = true;
  bool _username = true;
  bool _pass = true;
  bool _repass = true;
  bool _phone = true;
  final name = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  Future createAccount(
      {required String name,
      required String username,
      required String password,
      required String phone}) async {
    final docUser = FirebaseFirestore.instance.collection('accounts').doc();
    final account =  Account(
        id: docUser.id,
        name: name,
        username: username,
        password: password,
        phone: phone);
    final json = account.toJson();
    await docUser.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:
            true, //khi bàn phím xuất hiện sẽ không làm vỡ layout của giao diện
        body: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('img/background.png'), fit: BoxFit.fill),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 2 - 180),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          child: Image.asset(
                            'img/return.png',
                            width: 50,
                            height: 50,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 27),
                          child: Image.asset(
                            'img/logo.png',
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      //stack dùng để làm cho các con trong stack có thể chồng lên nhau
                      Stack(
                        children: [
                          Container(
                              width: 300,
                              height: 470,
                              child: Container(
                                alignment: Alignment.topCenter,
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
                                    top: 30,
                                    left: 35,
                                    child: Text(
                                      'ĐĂNG KÝ',
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
                              )),
                          Positioned(
                            top: 62.0,
                            right: 0.0,
                            left: 0.0,
                            child: Container(
                                alignment: Alignment.center,
                                height: 400,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('img/registertb.png'),
                                        fit: BoxFit.fill)),
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 20),
                                  child: Form(
                                    key: formGlobalKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Họ và tên',
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
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: 220,
                                          child: TextFormField(
                                            controller: name,
                                            validator: (name) {
                                              if (!checkname(name!)) {
                                                _name = false;
                                              } else {
                                                _name = true;
                                              }
                                            },
                                            cursorColor: Colors.black,
                                            cursorWidth: 3,
                                            cursorHeight: 20,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                            decoration: const InputDecoration(
                                              filled: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                              ),
                                              fillColor: Color(0xffFF8C4B),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          'Tên đăng nhập',
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
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: 220,
                                          child: TextFormField(
                                            controller: username,
                                            validator: (username) {
                                              if (!checkusername(username!)) {
                                                _username = false;
                                              } else {
                                                _username = true;
                                              }
                                            },
                                            cursorColor: Colors.black,
                                            cursorWidth: 3,
                                            cursorHeight: 20,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                            decoration: const InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xffFF8C4B),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          'Mật khẩu',
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
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: 220,
                                          child: TextFormField(
                                            controller: password,
                                            validator: (password) {
                                              if (!checkpassword(password!)) {
                                                _pass = false;
                                              } else {
                                                _pass = true;
                                              }
                                            },
                                            obscureText: true,
                                            cursorColor: Colors.black,
                                            cursorWidth: 3,
                                            cursorHeight: 20,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                            decoration: const InputDecoration(
                                              filled: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                              ),
                                              fillColor: Color(0xffFF8C4B),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          'Nhập lại mật khẩu',
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
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: 220,
                                          child: TextFormField(
                                            validator: (repassword) {
                                              if (!checkrepassword(
                                                  repassword!)) {
                                                _repass = false;
                                              } else {
                                                _repass = true;
                                              }
                                            },
                                            obscureText: true,
                                            cursorColor: Colors.black,
                                            cursorWidth: 3,
                                            cursorHeight: 20,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Mono',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                            decoration: const InputDecoration(
                                              filled: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                              ),
                                              fillColor: Color(0xffFF8C4B),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          'Số điện thoại',
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
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: 220,
                                          child: TextFormField(
                                            controller: phone,
                                            validator: (phone) {
                                              if (!checkphone(phone!)) {
                                                _phone = false;
                                              } else {
                                                _phone = true;
                                              }
                                            },
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
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                              ),
                                              fillColor: Color(0xffFF8C4B),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 300,
                        child: InkWell(
                          child: Container(
                            width: 150,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('img/table.png'),
                                    fit: BoxFit.fill)),
                            child: const Text(
                              'Đăng Ký',
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
                          onTap: () {
                            if (formGlobalKey.currentState!.validate()) {
                              bool isexist = false;
                              for (var element in accounts) {
                                if (element.username == username.text)
                                  isexist = true;
                              }
                              if (isexist) {
                                showDialog(
                                    context: context,
                                    builder: (context) => _onTapRegister(
                                        context, 'Tài Khoản Đã Tồn Tại'));
                              } else if (_name == false) {
                                showDialog(
                                    context: context,
                                    builder: (context) => _onTapRegister(
                                        context, 'Chưa Nhập Họ Và Tên'));
                              } else if (_username == false) {
                                showDialog(
                                    context: context,
                                    builder: (context) => _onTapRegister(
                                        context, 'Chưa Nhập Tên Đăng Nhập'));
                              } else if (_pass == false) {
                                showDialog(
                                    context: context,
                                    builder: (context) => _onTapRegister(
                                        context,
                                        'Mật Khẩu Phải Trên 8 ký tự'));
                              } else if (_repass == false) {
                                showDialog(
                                    context: context,
                                    builder: (context) => _onTapRegister(
                                        context,
                                        'Mật Khẩu Nhập Lại KHông Khớp'));
                              } else if (_phone == false) {
                                showDialog(
                                    context: context,
                                    builder: (context) => _onTapRegister(
                                        context,
                                        'Số Điện Thoại Sai Định Dạng'));
                              } else {
                                final name1 = name.text;
                                final username1 = username.text;
                                final password1 = password.text;
                                final phone1 = phone.text;

                                createAccount(name: name1, username: username1, password: password1, phone: phone1);
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        _onTapRegistersuccess(context));
                              }
                            }
                            ;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

_onTapRegister(BuildContext context, String info) {
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

_onTapRegistersuccess(BuildContext context) {
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
                top: 10,
                left: 25,
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
                      "Đăng Ký Thành Công !",
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
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Login()),
                    (Route route) => false);
              },
            ),
          ),
        ),
      ],
    ),
  );
}

mixin Input {
  String? pass;
  bool checkusername(String username) {
    if (username.length > 0)
      return true;
    else
      return false;
  }

  bool checkname(String name) {
    if (name.length > 0)
      return true;
    else
      return false;
  }

  bool checkphone(String phone) {
    String pattern = r'^[0-9]{10}$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(phone);
  }

  bool checkpassword(String password) {
    String pattern = r'^\b.{7,}$';
    RegExp regex = new RegExp(pattern);
    pass = password;
    return regex.hasMatch(password);
  }

  bool checkrepassword(String password) {
    if (password == pass)
      return true;
    else
      return false;
  }
}
