import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  Future<String> ipGetter() async {
    var prefs = await SharedPreferences.getInstance();
    final String? ip = prefs.getString("ip");
    if (ip is String){
      return ip;
    } else {
      return "fail getting ip";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: Center(
        child: Column(
            children: const [
              Text("ip from memory", style: TextStyle(fontSize: 24)),
              // Text(ipGetter(), style: const TextStyle(fontSize: 24)),
            ]),
      ),
    );
  }
}
