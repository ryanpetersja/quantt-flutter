class Helper {
 static bool isForehand({area, player}) {
    bool isForehand;
    print(player);
    if (player['right_handed' ] == 'true') {
      if (area == 1 || area == 4) {
        return true;
      } else {
        return false;
      }
    } else {
      if (area == 2 || area == 3) {
        return true;
      } else {
        return false;
      }
    }
  }
}
