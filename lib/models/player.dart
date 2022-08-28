// To parse this JSON data, do
//
//     final player = playerFromJson(jsonString);

// ignore: depend_on_referenced_packages
import 'dart:convert';

Player playerFromJson(String str) => Player.fromJson(json.decode(str));

String playerToJson(Player data) => json.encode(data.toJson());

class Player {
    Player({
        required this.id,
        required this.name,
        required this.playingStyle,
        required this.rightHanded,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String name;
    String playingStyle;
    bool rightHanded;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"],
        name: json["name"],
        playingStyle: json["playing_style"],
        rightHanded: json["right_handed"] == 'true' ? true : false,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "playing_style": playingStyle,
        "right_handed": rightHanded,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
