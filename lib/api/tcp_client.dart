import 'dart:io';

import 'package:dispenser_server/api/network_configuration.dart';

class TcpClient extends Network {
  late InternetAddress network;

  TcpClient({required String ipTarget, required int portTarget})
      : super(ip: ipTarget, port: portTarget);

  void sendMessage(String message) {
    print('Sending: $message');
  }
}
