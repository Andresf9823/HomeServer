import 'package:dispenser_server/api/api_client.dart' as api_client;
import 'package:dispenser_server/loggin/users.dart';
import 'package:dispenser_server/server/server.dart' as app_server;

String ip = "localhost";
int port = 1818;
String path = "/user/getInformation/andresf9806@gmail.com";

void main() async {
  final server = app_server.Server('localhost', 1818);
  server.launch();

  final userUrlParams =
      api_client.UrlParams(ip, port, path, api_client.TypeOfSecurity.http);
      
  final api = api_client.Api(userUrlParams);
  var user = User.createFromJson(await api.getRequest());
  print(user.email);
  print(user.password);
  print(user.name);
}
