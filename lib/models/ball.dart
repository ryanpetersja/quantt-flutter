// To parse this JSON data, do
//
//     final ball = ballFromJson(jsonString);

import 'dart:convert';

import '../services/remote_services.dart';

Ball ballFromJson(String str) => Ball.fromJson(json.decode(str));

String ballToJson(Ball data) => json.encode(data.toJson());

class Ball {
    Ball({
        this.id,
        required this.pointId,
        required this.winner,
        required this.spin,
        required this.from,
        required this.to,
        required this.strokeType,
        this.isService,
        required this.playerId,
        required this.loser,
        this.updatedAt,
        this.createdAt,
    });

    int? id;
    int pointId;
    bool winner;
    String spin;
    String from;
    String to;
    String strokeType;
    bool? isService;
    int playerId;
    int loser;
    DateTime? updatedAt;
    DateTime? createdAt;

    factory Ball.fromJson(Map<String, dynamic> json) => Ball(
        pointId: json["point_id"],
        winner: json["winner"],
        spin: json["spin"],
        from: json["from"],
        to: json["to"],
        strokeType: json["stroke_type"],
        isService: json["is_service"],
        playerId: json["player_id"],
        loser: json["loser"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
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
        "loser": loser,
    
    };


  save (){
    
    HTTPRequest.post("/balls", body: ballToJson(this));
  }
}
