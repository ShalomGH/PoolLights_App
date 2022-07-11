import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getIp() async {
  var prefs = await SharedPreferences.getInstance();
  final String? ip = prefs.getString("ip");
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
