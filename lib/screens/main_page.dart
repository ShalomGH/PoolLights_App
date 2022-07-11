import 'dart:io';

import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:http/http.dart' as http;

import '../functoins/find_port.dart';
import '../functoins/mem_functions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  // check if ip from mem == null
  Future<void> checkForIp() async {
    String? ip = await getIp();
    if (ip == null) {
      await _findDevice();
    }
  }

  _scan(stream) async {
    int? ipFlag;
    await stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');
        setIp(addr.ip);
        ipFlag = 1;
      }
    }, onDone: () {
      if (ipFlag == null) {
        _showAlertDialog("device Тot found");
      }
    });
  }

  void pingDevice() async {
    print("Ping start");
    checkForIp();
    final ip = await getIp();

    Socket.connect(ip, 23223, timeout: const Duration(seconds: 2))
        .then((socket) {
      print("Old ip works");
      socket.destroy();
    }).catchError((error) {
      if (error is SocketException) {
        _findDevice();
        print("Ping exception");
      }
    });
  }

  controlDevice(String params) async {
    http.Response? response;

    print("Control start");
    await checkForIp();
    String? ip = await getIp();

    if (ip != null) {
      final String host = "http://$ip:23223$params";
      print('host = $host');

      try {
        response = await http.get(Uri.parse(host));
      } catch (e) {
        _showAlertDialog("Connection error");
      }

      if (response != null) {
        if (response.statusCode != 200) {
          print('Failed response');
          _showAlertDialog("Connection error");
        }
      }
    }
  }

  _findDevice() async {
    print("find");
    const int port = 23223;
    final String? wifiBroadcast = await NetworkInfo()
        .getWifiBroadcast(); // returns null if WiFi is turned off

    if (wifiBroadcast != null) {
      final String? wifiIPv4 = await NetworkInfo().getWifiIP();
      print('wifiIPv4 = $wifiIPv4');

      if (wifiIPv4 != null) {
        print("wifiIPv4 != null");
        final String subnet = wifiIPv4.substring(0, wifiIPv4.lastIndexOf('.'));
        final stream = NetworkAnalyzer.discover(subnet, port);
        _scan(stream);
      } else {
        _showAlertDialog("WiFi error");
      }
    } else {
      _showAlertDialog("Turn on Wi-Fi");
    }
  }

  void _showAlertDialog(String massage) {
    final alert = AlertDialog(
      title: const Text('Error'),
      titlePadding: const EdgeInsets.all(20.0),
      content: Text(massage),
      contentPadding: const EdgeInsets.all(20.0),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            if (!mounted) return;
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

  @override
  void initState() {
    super.initState();
    pingDevice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        appBar: AppBar(
          title: const Text('Фонари бассейна'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Color(0xFF2F2F2F),
              ),
              onPressed: () {
                delIp();
              },
            ),
          ],
        ),
        body: Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: FractionallySizedBox(
                        widthFactor: 1,
                        alignment: Alignment.center,
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(30, 27, 30, 0),
                            child: ElevatedButton(
                                onPressed: () =>
                                    controlDevice("/effect?mode=0&param=0"),
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFFFFFBEC)),
                                child: const Text('Включение',
                                    style: TextStyle(fontSize: 32))))),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            padding: const EdgeInsets.fromLTRB(30, 27, 14, 0),
                            child: ElevatedButton(
                                onPressed: () =>
                                    controlDevice("/effect?mode=100&param=0"),
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFFFFEEAF)),
                                child: const Icon(Icons.arrow_back_sharp))),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            margin: const EdgeInsets.only(top: 27),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD2E3FF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child:
                                  Text("Режим", style: TextStyle(fontSize: 15)),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            padding: const EdgeInsets.fromLTRB(14, 27, 30, 0),
                            child: ElevatedButton(
                                onPressed: () =>
                                    controlDevice("/effect?mode=100&param=1"),
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFFFFEEAF)),
                                child: const Icon(Icons.arrow_forward_sharp))),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: const EdgeInsets.fromLTRB(30, 27, 14, 0),
                            child: ElevatedButton(
                                onPressed: () =>
                                    controlDevice("/effect?mode=2&param=0"),
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFFF8FEFF)),
                                child: const Text('Белый',
                                    style: TextStyle(fontSize: 15)))),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: const EdgeInsets.fromLTRB(14, 27, 30, 0),
                            child: ElevatedButton(
                                onPressed: () =>
                                    controlDevice("/effect?mode=5&param=0"),
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFFFA9595)),
                                child: const Text('Красный',
                                    style: TextStyle(fontSize: 15)))),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: const EdgeInsets.fromLTRB(30, 27, 14, 0),
                            child: ElevatedButton(
                                onPressed: () =>
                                    controlDevice("/effect?mode=3&param=0"),
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFFFFF693)),
                                child: const Text('Жёлтый',
                                    style: TextStyle(fontSize: 15)))),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: const EdgeInsets.fromLTRB(14, 27, 30, 0),
                            child: ElevatedButton(
                                onPressed: () =>
                                    controlDevice("/effect?mode=6&param=0"),
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF9DFA95)),
                                child: const Text('Зелёный',
                                    style: TextStyle(fontSize: 15)))),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                padding:
                                    const EdgeInsets.fromLTRB(30, 27, 14, 0),
                                child: ElevatedButton(
                                    onPressed: () =>
                                        controlDevice("/effect?mode=4&param=0"),
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color(0xFFDA9CF7)),
                                    child: const Text('Фиолетовый',
                                        style: TextStyle(fontSize: 15)))),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                padding:
                                    const EdgeInsets.fromLTRB(14, 27, 30, 0),
                                child: ElevatedButton(
                                    onPressed: () =>
                                        controlDevice("/effect?mode=7&param=0"),
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color(0xFFA4ADFF)),
                                    child: const Text('Синий',
                                        style: TextStyle(fontSize: 15))))
                          ]))
                ])));
  }
}
