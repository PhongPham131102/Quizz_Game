import 'package:flutter/material.dart';

class Profile {
    Profile({
        required this.id,
        required this.character_name,
        required this.level,
        required this.rank,
        required this.rank_detail,
        required this.avatar,
        required this.exp,
        required this.star,
        required this.gold,
        required this.total,
    });

    String id;
    String character_name;
    int level;
    String rank;
    String rank_detail;
    String avatar;
    int exp;
    int gold;
    int star;
    int total;

    factory Profile.fromJson(Map<dynamic, dynamic> json) => Profile(
        id: json["id"],
        character_name: json["character_name"],
        level: json["level"],
        rank: json["rank"],
        avatar: json["avatar"],
        exp: json["exp"],
        star:json["star"],
        gold: json["gold"],
        rank_detail: json["rank_detail"],
        total:json["total"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "character_name": character_name,
        "level": level,
        "rank": rank,
        "avatar": avatar,
        "exp": exp,
        "star":star,
        "gold":gold,
        "rank_detail":rank_detail,
        "total":total,
    };
}