class StrokeHelper {
  static bool isService(String shot) {
   return services.contains(shot) ? true : false;
  }

  static List<String> offensive = [
    "Drive",
    "Slow Topspin",
    "Counter Topspin",
    "Flick",
    "Smash",
    'punch',
    "Banna Flick"
  ];

  static List<String> defensive = [
    "Block",
    "Push",
    "Lob",
    "Chop",
  ];

  static List<String> services = [
    "Pendullum",
    "Cork Screw",
    "Reverse pendullum",
    "Shovel",
    "Birdman",
  ];
}
