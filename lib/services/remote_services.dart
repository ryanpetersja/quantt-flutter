import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quantt/services/strings.dart';

class HTTPRequest {
  static get(String endpoint) async {
    Uri uri = Uri.parse("${Strings.base_url}$endpoint");

    final response = await http.get(uri,
        headers: <String, String>{"Content-Type": "application/json"});

    if (response.statusCode != 200) {
      throw "HTTP STATUS ERROR";
    }

    return jsonDecode(response.body);
  }

  static Future<Map> post(String endpoint, {required Object body}) async {
    Uri uri = Uri.parse("${Strings.base_url}$endpoint");
    print("this is the body: \n $body");
    final response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      print(response.statusCode);
      throw "HTTP STATUS ERROR";
    }
    print("+++++++++");
    print(response.body);
    return jsonDecode(response.body);
  }
}
