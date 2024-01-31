import 'dart:io';

class TcpClient {
  int port;
  String ip;
  late InternetAddress network;

  TcpClient({required this.ip, required this.port}) {
    print('Creating Tcp Socket at port: $port');
  }
  TcpClient.fromJson(Map<String, dynamic> json)
      : ip = json['ip'] ?? '0.0.0.0',
        port = json['port'] ?? 0;

  int getPort() {
    return port;
  }
}
