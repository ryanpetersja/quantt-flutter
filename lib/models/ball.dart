// To parse this JSON data, do
//
//     final ball = ballFromJson(jsonString);

import 'dart:convert';

Ball ballFromJson(String str) => Ball.fromJson(json.decode(str));

String ballToJson(Ball data) => json.encode(data.toJson());

class Ball {
    Ball({
        this.pointId,
        this.winner,
        this.spin,
        required this.from,
        required this.to,
        required this.strokeType,
        this.isService,
        required this.playerId,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    String? pointId;
    String? winner;
    String? spin;
    String from;
    String to;
    String strokeType;
    String? isService;
    String playerId;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    factory Ball.fromJson(Map<String, dynamic> json) => Ball(
        pointId: json["point_id"],
        winner: json["winner"],
        spin: json["spin"],
        from: json["from"],
        to: json["to"],
        strokeType: json["stroke_type"],
        isService: json["is_service"],
        playerId: json["player_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "point_id": pointId,
        "winner": winner,
        "spin": spin,
        "from": from,
        "to": to,
        "stroke_type": strokeType,
        "is_service": isService,
        "player_id": playerId,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
