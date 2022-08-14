import 'dart:convert';

List<Set> setsFromRequestBody(List<dynamic> requestBody) =>
    List<Set>.from(List<Set>.from(
      requestBody.map(
        (x) => Set.fromJson(x),
      ),
    ));

class Set {
  int id;
  String player1;
  String player2;
  dynamic date;
  dynamic tableTupe;
  dynamic tournament;
  dynamic tableType;
  String? venue;

  Set({
    required this.id,
    required this.player1,
    required this.player2,
    this.date,
    this.tableTupe,
    this.tournament,
    this.tableType,
    this.venue,
  });

  factory Set.fromJson(Map<String, dynamic> json) => Set(
        id: json["id"],
        player1: json["player1"],
        player2: json["player2"],
        date: json["date"],
        tableTupe: json["table_tupe"],
        tournament: json["tournament"],
        tableType: json["table_type"],
        venue: json["venue"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "player1_id": player1,
        "player2_id": player2,
        "date": date,
        "table_tupe": tableTupe,
        "tournament": tournament,
        "table_type": tableType,
        "venue": venue,
      };
}
