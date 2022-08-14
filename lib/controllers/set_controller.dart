import 'dart:convert';
import 'package:quantt/services/remote_services.dart';

import '../models/set.dart';

class SetController {
  Future<List<Set>> getSets() async {
    var response = await HTTPRequest.get("/sets");
    // print(" the resonse is actuall: ${response['datat']}");
    return setsFromRequestBody(response["data"]);
  }
}
