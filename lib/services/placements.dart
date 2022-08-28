class Placements {
  static String getPlacement(
      {required String playerPosition,
      required int sectorIndex,
      required bool rightHanded}) {
    Map placements = {};

    if (playerPosition == "top") {
      if (rightHanded) {
        placements = {
          1: "Wide Forehand",
          2: "Middle Forehand",
          3: "Middle Forehand",
          4: "Middle Backhand",
          5: "wide Backhand",
          6: "Wide Forehand",
          7: "Middle Forehand",
          8: "Middle Forehand",
          9: "Middle Backhand",
          10: "wide Backhand",
        };
      } else {
        placements = {
          10: "Wide Forehand",
          9: "Middle Forehand",
          8: "Middle Forehand",
          7: "Middle Backhand",
          6: "wide Backhand",
          5: "Wide Forehand",
          4: "Middle Forehand",
          3: "Middle Forehand",
          2: "Middle Backhand",
          1: "wide Backhand",
        };
      }
    } else {
      if (rightHanded) {
        placements = {
          20: "Wide Forehand",
          19: "Middle Forehand",
          18: "Middle Forehand",
          17: "Middle Backhand",
          16: "wide Backhand",
          15: "Wide Forehand",
          14: "Middle Forehand",
          13: "Middle Forehand",
          12: "Middle Backhand",
          11: "wide Backhand",
        };
      } else {
        placements = {
          11: "Wide Forehand",
          12: "Middle Forehand",
          13: "Middle Forehand",
          14: "Middle Backhand",
          15: "wide Backhand",
          16: "Wide Forehand",
          17: "Middle Forehand",
          18: "Middle Forehand",
          19: "Middle Backhand",
          20: "wide Backhand",
        };
      }
    }
    print("chosen sector is \n $placements");
    return placements[sectorIndex];
  }

  static String getPlayerPosition( int sectorIndex){
    if(sectorIndex > 10){
      return "bottom";
    }else{
      return "top";
    }
  }
}
