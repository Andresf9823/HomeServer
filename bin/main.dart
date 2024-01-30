import 'package:dispenser_server/server/web_server.dart' as app_server;

String ip = "localhost";
int port = 1818;
String path = "/user/getInformation/andresf9806@gmail.com";

void main() async {
  final server = app_server.Server('localhost', 1818);
  server.launch();
}
