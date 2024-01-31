import 'package:dispenser_server/server/web_server.dart';
import 'package:dispenser_server/api/tcp_client.dart';

void main() async {
  final webServer = WebServer(port: 1818);
  webServer.launch();
  final tcpClient = TcpClient(ip: '192,168,0,1', port: 1100);
  print('${tcpClient.getPort()}');
}
