import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'find_port.dart';
import 'dart:io';

void checkForIp(BuildContext context){
  if (getIp() == null){
    print("check");
    _findDevice(context);
  }
}

Future<String?> getIp() async {
  var prefs = await SharedPreferences.getInstance();
  final String? ip = prefs.getString("ip");
  print('ip from mem = $ip');
  return ip;
}

setIp(var ip) async {
  var prefs = await SharedPreferences.getInstance();
  prefs.setString("ip", ip);
}

delIp() async {
  var prefs = await SharedPreferences.getInstance();
  prefs.remove('ip');
}

_scan(stream) {
  stream.listen((NetworkAddress addr) {
    if (addr.exists) {
      print('Found device: ${addr.ip}');
      setIp(addr.ip);
      return true;
    } else {
      return false;
    }
  });
}

Future<void> _findDevice(BuildContext context) async {
  print("find");
  const int port = 23223;
  final String? wifiBroadcast = await NetworkInfo()
      .getWifiBroadcast(); // returns null if WiFi is turned off

  if (wifiBroadcast != null) {
    final String? wifiIPv4 = await NetworkInfo().getWifiIP();
    print(wifiIPv4);

    if (wifiIPv4 != null) {
      final String subnet = wifiIPv4.substring(0, wifiIPv4.lastIndexOf('.'));
      final stream = NetworkAnalyzer.discover(subnet, port);

      if (_scan(stream) == null) {
        _showAlertDialog(context, "Device not found");
      }
    } else {
      _showAlertDialog(context, "WiFi error");
    }
  } else {
    _showAlertDialog(context, "Turn on Wi-Fi");
  }
}

void pingDevice(BuildContext context) async {
  checkForIp(context);
  print("Ping start");
  final ip = getIp();

  if (ip != null) {
    Socket.connect(ip, 23223, timeout: const Duration(seconds: 2))
        .then((socket) {
      print("Old ip works");
      socket.destroy();
    }).catchError((error) {
      if (error is SocketException) {
        _findDevice(context);
        print("Ping exception");
      }
    });
  } else {
    _findDevice(context);
  }
}

controlDevice(String params, BuildContext context) async {
  checkForIp(context);
  print("Control start");
  var response;
  String? ip = await getIp();

  if (ip == null) {
    _findDevice(context);
    ip = await getIp();
  }

  final String host = "http://$ip:23223$params";
  print('host = ${host}');

  try {
    response = await http.get(Uri.parse(host));
  } catch (e) {
    print(e);
  }

  if (response != null) {
    if (response.statusCode == 200) {
      print("Success response");
    } else {
      print('Failed response');
    }
  }
}

void _showAlertDialog(BuildContext context, String massage) {
  final alert = AlertDialog(
    title: const Text('Error'),
    titlePadding: const EdgeInsets.all(20.0),
    content: Text(massage),
    contentPadding: const EdgeInsets.all(20.0),
    actions: <Widget>[
      MaterialButton(
        onPressed: () {
          Navigator.of(context).pop(Page);
        },
        child: const Text('Ok'),
      ),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
