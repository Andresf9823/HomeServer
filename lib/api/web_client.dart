import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum TypeOfSecurity { http, https }

class UrlParams {
  late String ip;
  late int port;
  late String path;
  late TypeOfSecurity security;
  UrlParams(this.ip, this.port, this.path, this.security);
}

class Api {
  late String url;

  Api(UrlParams param) {
    switch (param.security) {
      case TypeOfSecurity.http:
        url = "http://";
        break;

      case TypeOfSecurity.https:
        url = "https://";
        break;

      default:
        url = "http://";
        break;
    }
    url += "${param.ip}:${param.port}${param.path}";
  }

  Future<Map<String, dynamic>> getRequest() async {
    try {
      var response = await http.get(Uri.parse(url));
      print(
          " STATUS: ${response.statusCode} \n\r CONTENT LENGTH: ${response.contentLength} \n\r HEAERS: ${response.headers} \n\r BODY: ${response.body}\n");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("FATAL ERROR CHECK THE URL: $url \n\n");
    }
    Map<String, dynamic> r = {};
    return r;
  }
}
