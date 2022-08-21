List<Set> setsFromRequestBody(List<dynamic> requestBody) =>
    List<Set>.from(List<Set>.from(
      requestBody.map(
        (x) => Set.fromJson(x),
      ),
    ));

class Set {
  int id;
  Map player1;
  Map player2;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map['player1'] = {
      "id":player1["id"],
      "name": player1["name"],
      "playing_style": player1["playing_style"],
      "right_handed": player1["right_handed"],
    };
    map['player2'] = {
      "id":player2["id"],
      "name": player2["name"],
      "playing_style": player2["playing_style"],
      "right_handed": player2["right_handed"],
    };    map["date"] = date;
    map["table_tupe"] = tableTupe;
    map["tournament"] = tournament;
    map["table_type"] = tableType;
    map["venue"] = venue;

    return map;
  }
}
