class Student{
  String? key;
  StudentData? studentData;

  Student({this.key,this.studentData});
}

class StudentData{
  String? name;
  String? age;
  String? subject;

  StudentData({this.name,this.age,this.subject});

  StudentData.fromJson(Map<dynamic,dynamic> json){
    name = json["name"];
    age = json["age"];
    subject = json["subject"];
  }
}
class Room {
    Room({
        required this.id,
        required this.user1,
        required this.user2,
        required this.status,
        required this.totalscore1,
        required this.totalscore2,
        required this.ready1,
        required this.ready2,
        required this.answeruser11,
        required this.scoreqr11,
        required this.answeruser21,
        required this.scoreqr21,
        required this.answeruser12,
        required this.scoreqr12,
        required this.answeruser22,
        required this.scoreqr22,
        required this.answeruser13,
        required this.scoreqr13,
        required this.answeruser23,
        required this.scoreqr23,
        required this.answeruser14,
        required this.scoreqr14,
        required this.answeruser24,
        required this.scoreqr24,
        required this.answeruser15,
        required this.scoreqr15,
        required this.answeruser25,
        required this.scoreqr25,
        required this.title1,
        required this.title2,
        required this.title3,
        required this.title4,
        required this.title5,
        required this.answerText11,
        required this.score11,
        required this.answerText12,
        required this.score12,
        required this.answerText13,
        required this.score13,
        required this.answerText14,
        required this.score14,
        required this.answerText21,
        required this.score21,
        required this.answerText22,
        required this.score22,
        required this.answerText23,
        required this.score23,
        required this.answerText24,
        required this.score24,
        required this.answerText31,
        required this.score31,
        required this.answerText32,
        required this.score32,
        required this.answerText33,
        required this.score33,
        required this.answerText34,
        required this.score34,
        required this.answerText41,
        required this.score41,
        required this.answerText42,
        required this.score42,
        required this.answerText43,
        required this.score43,
        required this.answerText44,
        required this.score44,
        required this.answerText51,
        required this.score51,
        required this.answerText52,
        required this.score52,
        required this.answerText53,
        required this.score53,
        required this.answerText54,
        required this.score54,
    });

    final String id;
    final String user1;
    final String user2;
    final bool status;
    final int totalscore1;
    final int totalscore2;
    final bool ready1;
    final bool ready2;
    final String answeruser11;
    final int scoreqr11;
    final String answeruser21;
    final int scoreqr21;
    final String answeruser12;
    final int scoreqr12;
    final String answeruser22;
    final int scoreqr22;
    final String answeruser13;
    final int scoreqr13;
    final String answeruser23;
    final int scoreqr23;
    final String answeruser14;
    final int scoreqr14;
    final String answeruser24;
    final int scoreqr24;
    final String answeruser15;
    final int scoreqr15;
    final String answeruser25;
    final int scoreqr25;
    final String title1;
    final String title2;
    final String title3;
    final String title4;
    final String title5;
    final String answerText11;
    final bool score11;
    final String answerText12;
    final bool score12;
    final String answerText13;
    final bool score13;
    final String answerText14;
    final bool score14;
    final String answerText21;
    final bool score21;
    final String answerText22;
    final bool score22;
    final String answerText23;
    final bool score23;
    final String answerText24;
    final bool score24;
    final String answerText31;
    final bool score31;
    final String answerText32;
    final bool score32;
    final String answerText33;
    final bool score33;
    final String answerText34;
    final bool score34;
    final String answerText41;
    final bool score41;
    final String answerText42;
    final bool score42;
    final String answerText43;
    final bool score43;
    final String answerText44;
    final bool score44;
    final String answerText51;
    final bool score51;
    final String answerText52;
    final bool score52;
    final String answerText53;
    final bool score53;
    final String answerText54;
    final bool score54;

    factory Room.fromJson(Map<dynamic, dynamic> json) => Room(
        id: json["id"],
        user1: json["user1"],
        user2: json["user2"],
        status: json["status"],
        totalscore1: json["totalscore1"],
        totalscore2: json["totalscore2"],
        ready1: json["ready1"],
        ready2: json["ready2"],
        answeruser11: json["answeruser11"],
        scoreqr11: json["scoreqr11"],
        answeruser21: json["answeruser21"],
        scoreqr21: json["scoreqr21"],
        answeruser12: json["answeruser12"],
        scoreqr12: json["scoreqr12"],
        answeruser22: json["answeruser22"],
        scoreqr22: json["scoreqr22"],
        answeruser13: json["answeruser13"],
        scoreqr13: json["scoreqr13"],
        answeruser23: json["answeruser23"],
        scoreqr23: json["scoreqr23"],
        answeruser14: json["answeruser14"],
        scoreqr14: json["scoreqr14"],
        answeruser24: json["answeruser24"],
        scoreqr24: json["scoreqr24"],
        answeruser15: json["answeruser15"],
        scoreqr15: json["scoreqr15"],
        answeruser25: json["answeruser25"],
        scoreqr25: json["scoreqr25"],
        title1: json["title1"],
        title2: json["title2"],
        title3: json["title3"],
        title4: json["title4"],
        title5: json["title5"],
        answerText11: json["answerText11"],
        score11: json["score11"],
        answerText12: json["answerText12"],
        score12: json["score12"],
        answerText13: json["answerText13"],
        score13: json["score13"],
        answerText14: json["answerText14"],
        score14: json["score14"],
        answerText21: json["answerText21"],
        score21: json["score21"],
        answerText22: json["answerText22"],
        score22: json["score22"],
        answerText23: json["answerText23"],
        score23: json["score23"],
        answerText24: json["answerText24"],
        score24: json["score24"],
        answerText31: json["answerText31"],
        score31: json["score31"],
        answerText32: json["answerText32"],
        score32: json["score32"],
        answerText33: json["answerText33"],
        score33: json["score33"],
        answerText34: json["answerText34"],
        score34: json["score34"],
        answerText41: json["answerText41"],
        score41: json["score41"],
        answerText42: json["answerText42"],
        score42: json["score42"],
        answerText43: json["answerText43"],
        score43: json["score43"],
        answerText44: json["answerText44"],
        score44: json["score44"],
        answerText51: json["answerText51"],
        score51: json["score51"],
        answerText52: json["answerText52"],
        score52: json["score52"],
        answerText53: json["answerText53"],
        score53: json["score53"],
        answerText54: json["answerText54"],
        score54: json["score54"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user1": user1,
        "user2": user2,
        "status": status,
        "totalscore1": totalscore1,
        "totalscore2": totalscore2,
        "ready1": ready1,
        "ready2": ready2,
        "answeruser11": answeruser11,
        "scoreqr11": scoreqr11,
        "answeruser21": answeruser21,
        "scoreqr21": scoreqr21,
        "answeruser12": answeruser12,
        "scoreqr12": scoreqr12,
        "answeruser22": answeruser22,
        "scoreqr22": scoreqr22,
        "answeruser13": answeruser13,
        "scoreqr13": scoreqr13,
        "answeruser23": answeruser23,
        "scoreqr23": scoreqr23,
        "answeruser14": answeruser14,
        "scoreqr14": scoreqr14,
        "answeruser24": answeruser24,
        "scoreqr24": scoreqr24,
        "answeruser15": answeruser15,
        "scoreqr15": scoreqr15,
        "answeruser25": answeruser25,
        "scoreqr25": scoreqr25,
        "title1": title1,
        "title2": title2,
        "title3": title3,
        "title4": title4,
        "title5": title5,
        "answerText11": answerText11,
        "score11": score11,
        "answerText12": answerText12,
        "score12": score12,
        "answerText13": answerText13,
        "score13": score13,
        "answerText14": answerText14,
        "score14": score14,
        "answerText21": answerText21,
        "score21": score21,
        "answerText22": answerText22,
        "score22": score22,
        "answerText23": answerText23,
        "score23": score23,
        "answerText24": answerText24,
        "score24": score24,
        "answerText31": answerText31,
        "score31": score31,
        "answerText32": answerText32,
        "score32": score32,
        "answerText33": answerText33,
        "score33": score33,
        "answerText34": answerText34,
        "score34": score34,
        "answerText41": answerText41,
        "score41": score41,
        "answerText42": answerText42,
        "score42": score42,
        "answerText43": answerText43,
        "score43": score43,
        "answerText44": answerText44,
        "score44": score44,
        "answerText51": answerText51,
        "score51": score51,
        "answerText52": answerText52,
        "score52": score52,
        "answerText53": answerText53,
        "score53": score53,
        "answerText54": answerText54,
        "score54": score54,
    };
}
