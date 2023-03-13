class ObjectGeo {
    ObjectGeo({
        required this.id,
        required this.level1,
        required this.score1,
        required this.level2,
        required this.score2,
        required this.level3,
        required this.score3,
        required this.level4,
        required this.score4,
    });

    final String id;
    final bool level1;
    final int score1;
    final bool level2;
    final int score2;
    final bool level3;
    final int score3;
    final bool level4;
    final int score4;

    factory ObjectGeo.fromJson(Map<String, dynamic> json) => ObjectGeo(
        id: json["id"],
        level1: json["level1"],
        score1: json["score1"],
        level2: json["level2"],
        score2: json["score2"],
        level3: json["level3"],
        score3: json["score3"],
        level4: json["level4"],
        score4: json["score4"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "level1": level1,
        "score1": score1,
        "level2": level2,
        "score2": score2,
        "level3": level3,
        "score3": score3,
        "level4": level4,
        "score4": score4,
    };
}
