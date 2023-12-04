import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf_static/shelf_static.dart' as shelf_static;

String? myEmail = "andresf9806@gmail.com", myPassword = "Chan.61522_", myName = "Andrés Berdugo";

Future<Response?> _getUserInformation(Request request, String userEmail) async {
  try {
    if (userEmail == myEmail) {
      Map<String, dynamic> jsonResponse = {
        'status': 200,
        'email': myEmail,
        'password': myPassword,
        'name': myName
      };
      return Response.ok(jsonEncode(jsonResponse));
    }
    return Response.notFound(
        jsonEncode({'status': 401, 'Message': 'User not exist: $userEmail'}));
  } catch (e) {
    print(e);
    return Response.badRequest();
  }
}

Future<Response?> _userAuthentication(Request request) async {
  try {
    if (request.isEmpty) {
      return Response.badRequest();
    }
    Map<String, dynamic> jsonRequest = jsonDecode(await request.readAsString());

    if (jsonRequest['email'] == myEmail &&
        jsonRequest['password'] == myPassword) {
      Map<String, dynamic> jsonResponse = {
        'status': 200,
        'message': "Welcome $myEmail"
      };
      return Response.ok(jsonEncode(jsonResponse));
    }

    return Response.unauthorized(
        jsonEncode({'status': 401, 'message': 'unAuthorized'}));
  } catch (e) {
    print(e.toString());
    return Response.badRequest();
  }
}

Future<Response?> _deleteUser(Request request) async {
  try {
    String? email;
    String? password;
    if (request.isEmpty) {
      throw Exception();
    }

    Map<String, dynamic> jsonRequest = jsonDecode(await request.readAsString());
    if (jsonRequest.containsKey('email')) {
      email = jsonRequest['email'];
    }
    if (jsonRequest.containsKey('password')) {
      password = jsonRequest['password'];
    }
    if (email == myEmail && password == myPassword) {
      myEmail = myPassword = null;
      return Response.ok(
          jsonEncode({'status': 200, 'deleted': true, 'userDeleted': email}));
    }

    return Response.notFound(
        jsonEncode({"satus": 404, "message": "User not found"}));
  } catch (e) {
    print(e.toString());
    return Response.badRequest();
  }
}

Future<Response?> _createUser(Request request) async {
  try {
    Map<String, dynamic> jsonRequest = jsonDecode(await request.readAsString());

    myEmail = jsonRequest['email'];
    myName = jsonRequest['name'];
    myPassword = jsonRequest['password'];

    Map<String, dynamic> jsonResponse = {
      'status': 200,
      'created': true,
      'email': '$myEmail',
      'name': '$myName',
      'password': '$myPassword'
    };
    return Response.ok(jsonEncode(jsonResponse));
  } catch (e) {
    print(e.toString());
    return Response.badRequest();
  }
}

class Server {
  Server(this.ipAddress, this.port);
  String ipAddress;
  int port;
  late HttpServer server;

  final _staticHandler =
      shelf_static.createStaticHandler('public', defaultDocument: 'index.html');

  final _router = shelf_router.Router()
    ..get('/user/getInformation/<userEmail>', _getUserInformation)
    ..post('/user/userAuthentication', _userAuthentication)
    ..delete('/user/deleteUser', _deleteUser)
    ..patch('/user/createUser', _createUser);

  Future<HttpServer?> launch() async {
    try {
      final cascade = Cascade().add(_staticHandler).add(_router);

      server = await shelf_io.serve(logRequests().addHandler(cascade.handler),
          InternetAddress.anyIPv4, port);
      server.autoCompress = true;
      print('Serving at http://${server.address.host}:${server.port}');
      return server;
    } catch (e) {
      print('Cannot init server at $ipAddress:$port');
      return null;
    }
  }
}
