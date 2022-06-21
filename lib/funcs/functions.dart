import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'find_port.dart';
import 'dart:io';

findDevice(BuildContext context) async {
  print("Find start");
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
      } else {
        simpleDialog(context);
      }
    });
  } else {
    print("error");
    simpleDialog(context);
  }
}

void pingDevice(BuildContext context) async {
  print("Ping start");
  var prefs = await SharedPreferences.getInstance();
  final String? ip = prefs.getString("ip");
  if (ip != null) {
    Socket.connect(ip, 23223, timeout: const Duration(seconds: 1))
        .then((socket) {
      print("Old ip works");
      socket.destroy();
    }).catchError((error) {
      if (error is SocketException) {
        findDevice(context);
        print("Ping exception");
      }
    });
  } else {
    findDevice(context);
  }
}

controlDevice(String params, BuildContext context) async {
  print("Control start");
  var response;
  var prefs = await SharedPreferences.getInstance();
  final String? ip = prefs.getString("ip");

  if (ip != null) {
    final String host = "http://$ip:23223$params";
    print(host);

    try {
      response = await http.get(Uri.parse(host));
      if (response.statusCode == 200) {
        print("Success response");
      } else {
        print('Failed response');
      }
    } catch (e) {
      print(e);
    }
  } else {
    pingDevice(context);
  }
}

Future simpleDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Title'),
        content: Text('Dialog content'),
        actions: <Widget>[
          ElevatedButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}