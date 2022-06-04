import 'dart:async';

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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<String>? myStream;
  String? newText;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: myStream,
              initialData: 'Hello World',
              builder: (_, snapshot) {
                print('StreamBuilder');
                String myData = snapshot.data as String;
                return SizedBox(
                  height: 75,
                  width: 75,
                  child: Text(newText ?? myData),
                );
              },
            ),
            ElevatedButton(
              onPressed: doStream,
              child: const Text('Create Stream'),
            ),
          ],
        ),
      ),
    );
  }

  doStream() {
    final streamControllerText = StreamController<String>();

    streamControllerText.sink.add('`Second` Data');

    streamControllerText.stream
        .listen((event) => newText = event);

    streamControllerText.close();


    setState(() {
      // myStream = streamControllerText.stream;
    });
  }
}
