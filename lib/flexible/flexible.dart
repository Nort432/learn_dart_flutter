import 'package:flutter/material.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 80,
                  color: Colors.redAccent,
                ),

                Flexible(
                  // flex: 1,
                  fit: FlexFit.loose,
                  child: Container(
                    child: Text('12345'),
                    // width: 350,
                    height: 80,
                    color: Colors.yellowAccent,
                  ),
                ),

                Flexible(
                  // flex: 6,
                  fit: FlexFit.loose,
                  child: Container(
                    // width: 300,
                    height: 80,
                    color: Colors.green,
                  ),
                ),






              ],
            ),
          ),
        ],
      ),
    );
  }
}

