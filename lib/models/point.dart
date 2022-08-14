// To parse this JSON data, do
//
//     final point = pointFromJson(jsonString);

import 'dart:convert';

Point pointFromJson(String str) => Point.fromJson(json.decode(str));

String pointToJson(Point data) => json.encode(data.toJson());

class Point {
    Point({
        this.id,
        required this.setId,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String setId;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Point.fromJson(Map<String, dynamic> json) => Point(
        id: json["id"],
        setId: json["set_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "set_id": setId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
