import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'find_port.dart';
import 'dart:io';

findDevice() async {
  var prefs = await SharedPreferences.getInstance();
  const int port = 23223;

  final String? wifiIPv4 = await NetworkInfo().getWifiIP();

  if (wifiIPv4 != null) {
    final String subnet = wifiIPv4.substring(0, wifiIPv4.lastIndexOf('.'));
    final stream = NetworkAnalyzer.discover(subnet, port);
    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');
        prefs.setString("ip", addr.ip);
      }
    });
  } else {
    print("error");
  }
}

void pingDevice() async {
  var prefs = await SharedPreferences.getInstance();
  final String? ip = prefs.getString("ip");
  if (ip != null) {
    Socket.connect(ip, 23223, timeout: const Duration(seconds: 1)).then((socket){
      print("Old ip works");
      socket.destroy();
    }).catchError((error){
      if (error is SocketException){
        findDevice();
        print("Ping exception");
      }
    });
  }
}

controlDevice(String params) async {
  var prefs = await SharedPreferences.getInstance();
  final String? ip = prefs.getString("ip");

  final String host = "http://${ip}:23223$params";

  final response = await http.get(Uri.parse(host));
  if (response.statusCode == 200) {
    print("Success response");
  } else {
    pingDevice;
    print('Failed response');
  }
}
