import 'package:flutter/material.dart';
import 'package:flutter_first/screens/settings_page.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:ping_discover_network/ping_discover_network.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  findDevice() async {
    const int port = 23223;

    final NetworkInfo networkInfo = NetworkInfo();
    String? wifiIPv4 = await networkInfo.getWifiIP();

    if (wifiIPv4 != null) {
      final String subnet = wifiIPv4.substring(0, wifiIPv4.lastIndexOf('.'));
      final stream = NetworkAnalyzer.discover2(subnet, port);
      stream.listen((NetworkAddress addr) {
        if (addr.exists) {
          print('Found device: ${addr.ip}');
        }
      });
    } else {
      print("error");
    }
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
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => const SettingsPage()));
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
                                onPressed: findDevice,
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
                                onPressed: findDevice,
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
                                onPressed: findDevice,
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
                                onPressed: findDevice,
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFFF8FEFF)),
                                child: const Text('Белый',
                                    style: TextStyle(fontSize: 15)))),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: const EdgeInsets.fromLTRB(14, 27, 30, 0),
                            child: ElevatedButton(
                                onPressed: findDevice,
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
                                onPressed: findDevice,
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFFFFF693)),
                                child: const Text('Жёлтый',
                                    style: TextStyle(fontSize: 15)))),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: const EdgeInsets.fromLTRB(14, 27, 30, 0),
                            child: ElevatedButton(
                                onPressed: findDevice,
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
                                    onPressed: findDevice,
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color(0xFFDA9CF7)),
                                    child: const Text('Фиолетовый',
                                        style: TextStyle(fontSize: 15)))),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                padding:
                                    const EdgeInsets.fromLTRB(14, 27, 30, 0),
                                child: ElevatedButton(
                                    onPressed: findDevice,
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color(0xFFA4ADFF)),
                                    child: const Text('Синий',
                                        style: TextStyle(fontSize: 15)))),
                          ]))
                ])));
  }
}
