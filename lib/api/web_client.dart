import 'dart:async';
import 'dart:convert';
import 'package:dispenser_server/api/network_configuration.dart';
import 'package:http/http.dart' as http;

enum TypeOfSecurity { http, https }

class UrlParams {
  late String ip;
  late int port;
  late String path;
  late TypeOfSecurity security;
  UrlParams(this.ip, this.port, this.path, this.security);
}

class Api extends Network {
  late String path;
  late String url;
  late TypeOfSecurity security;

  Api({
    required String hostTarget,
    int portTarget = 0,
    required String path,
    TypeOfSecurity security = TypeOfSecurity.http,
  }) : super(ip: hostTarget, port: portTarget) {
    switch (security) {
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
    url += "$ip${port == 0 ? '/' : ':+{port.toString()}'}$path";
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
