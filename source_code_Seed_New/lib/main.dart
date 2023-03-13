import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main_game.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firstgame.dart';
import 'login.dart';
import 'register.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Music();
  }
}

class Music extends StatefulWidget {
  const Music({super.key});

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  final player = AudioPlayer();
  void playLocal() async {
    await player.play(AssetSource("audio/QuizMusic.mp3"));
  }

  void loop() {
    player.setReleaseMode(ReleaseMode.loop);
  }


  @override
  Widget build(BuildContext context) {
    playLocal();
    loop();
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  @override
  Widget build(BuildContext context) {
    if (is_logined == "1" && id != "") {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainGame(),
      );
    } else {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainForm(),
      );
    }
  }
}

class MainForm extends StatefulWidget {
  const MainForm({super.key});

  @override
  State<MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(top: 30),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('img/background.png'), fit: BoxFit.fill),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'img/logo.png',
            width: 200,
            height: 200,
          ),
          Column(
            children: [
              InkWell(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 100, 0, 20),
                  width: 150,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('img/table.png'),
                          fit: BoxFit.fill)),
                  child: const Text(
                    'Đăng Nhập',
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
              ),
              InkWell(
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Register()));
                },
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
