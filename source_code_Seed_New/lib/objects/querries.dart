class Level {
    Level({
        required this.id,
        required this.queries,
    });

    final int id;
    final List<Querriess> queries;

    factory Level.fromJson(Map<String, dynamic> json) => Level(
        id: json["id"],
        queries: List<Querriess>.from(json["queries"].map((x) => Querriess.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "queries": List<dynamic>.from(queries.map((x) => x.toJson())),
    };
}

class Querriess {
    Querriess({
        required this.id,
        required this.title,
        required this.answers,
    });

    final int id;
    final String title;
    final List<Answer> answers;

    factory Querriess.fromJson(Map<String, dynamic> json) => Querriess(
        id: json["id"],
        title: json["title"],
        answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
    };
}

class Answer {
    Answer({
        required this.answerText,
        required this.score,
    });

    final String answerText;
    final bool score;

    factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        answerText: json["answerText"],
        score: json["score"],
    );

    Map<String, dynamic> toJson() => {
        "answerText": answerText,
        "score": score,
    };
}
