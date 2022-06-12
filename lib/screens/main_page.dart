import 'package:flutter/material.dart';
import 'package:flutter_first/screens/settings_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        title: const Text(
          'Фонари бассейна',
          style: TextStyle(color: Color(0xFF2F2F2F)),
        ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: FractionallySizedBox(
                widthFactor: 1,
                alignment: Alignment.center,
                child: Container(
                    // color: const Color(0xFFFFD4D4),
                    padding: const EdgeInsets.all(27),
                    child: const ElevatedButton(
                        onPressed: null,
                        child: Text('Включение',
                            style: TextStyle(fontSize: 32))))),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: const Color(0xFFFFABAB),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton.large(
                    child: const Text(
                      "On",
                      style: TextStyle(fontSize: 30),
                    ),
                    onPressed: () {},
                  ),
                  FloatingActionButton.large(
                    child: const Text(
                      "On",
                      style: TextStyle(fontSize: 30),
                    ),
                    onPressed: () {},
                  ),
                  FloatingActionButton.large(
                    child: const Text(
                      "On",
                      style: TextStyle(fontSize: 30),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
