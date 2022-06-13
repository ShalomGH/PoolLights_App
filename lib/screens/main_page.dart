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
            flex: 1,
            child: Container(
              color: const Color(0xFFFFABAB),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      color: const Color(0xFF8ACEFA),
                      width: MediaQuery.of(context).size.width * 0.32,
                      padding: const EdgeInsets.fromLTRB(30, 27, 14, 0),
                      // padding: const EdgeInsets.all(27),
                      child: const ElevatedButton(
                          onPressed: null,
                          child: Icon(Icons.arrow_back_sharp))),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.34,
                      color: const Color(0xFFA7FF9A),
                      padding: const EdgeInsets.fromLTRB(14, 27, 14, 0),
                      // padding: const EdgeInsets.all(27),
                      child: const ElevatedButton(
                          onPressed: null,
                          child:
                              Text('Режим', style: TextStyle(fontSize: 15)))),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.32,
                      color: const Color(0xFFA7FF9A),
                      padding: const EdgeInsets.fromLTRB(14, 27, 30, 0),
                      // padding: const EdgeInsets.all(27),
                      child: const ElevatedButton(
                          onPressed: null,
                          child: Icon(Icons.arrow_forward_sharp))),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFFFFABAB),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      color: const Color(0xFF8ACEFA),
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.fromLTRB(30, 27, 14, 0),
                      // padding: const EdgeInsets.all(27),
                      child: const ElevatedButton(
                          onPressed: null,
                          child:
                              Text('Белый', style: TextStyle(fontSize: 15)))),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: const Color(0xFFA7FF9A),
                      padding: const EdgeInsets.fromLTRB(14, 27, 30, 0),
                      // padding: const EdgeInsets.all(27),
                      child: const ElevatedButton(
                          onPressed: null,
                          child:
                              Text('Красный', style: TextStyle(fontSize: 15)))),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFFFFABAB),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      color: const Color(0xFF8ACEFA),
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.fromLTRB(30, 27, 14, 0),
                      // padding: const EdgeInsets.all(27),
                      child: const ElevatedButton(
                          onPressed: null,
                          child:
                              Text('Жёлтый', style: TextStyle(fontSize: 15)))),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: const Color(0xFFA7FF9A),
                      padding: const EdgeInsets.fromLTRB(14, 27, 30, 0),
                      // padding: const EdgeInsets.all(27),
                      child: const ElevatedButton(
                          onPressed: null,
                          child:
                              Text('Зелёный', style: TextStyle(fontSize: 15)))),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFFFFABAB),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      color: const Color(0xFF8ACEFA),
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.fromLTRB(30, 27, 14, 0),
                      // padding: const EdgeInsets.all(27),
                      child: const ElevatedButton(
                          onPressed: null,
                          child:
                              Text('Фиолетовый', style: TextStyle(fontSize: 15)))),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: const Color(0xFFA7FF9A),
                      padding: const EdgeInsets.fromLTRB(14, 27, 30, 0),
                      // padding: const EdgeInsets.all(27),
                      child: const ElevatedButton(
                          onPressed: null,
                          child:
                              Text('Синий', style: TextStyle(fontSize: 15)))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
