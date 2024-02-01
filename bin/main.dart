import 'package:dispenser_server/server/web_server.dart';
import 'package:dispenser_server/api/tcp_client.dart';
import 'package:dispenser_server/api/web_client.dart';

void main() async {
  final webServer = WebServer(port: 1818);
  webServer.launch();

  final webClient = Api(
      hostTarget: 'pokeapi.co',
      security: TypeOfSecurity.https,
      path: 'api/v2/pokemon/charmander');
  webClient.getRequest();

  final tcpClient = TcpClient(ipTarget: '192.168.0.1', portTarget: 1100);
  tcpClient.sendMessage('Prueba');
}
