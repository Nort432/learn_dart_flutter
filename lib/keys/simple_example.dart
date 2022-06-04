import 'dart:math';

import 'package:flutter/material.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final containers = [
    // ColorFulContainer(key: UniqueKey(),),
    // ColorFulContainer(key: UniqueKey(),),
    ColorFulContainer(),
    ColorFulContainer(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: _swap, child: const Text('Swap')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: containers,
          )
        ],
      ),
    );
  }

  void _swap() {
    setState(() {
      containers.add(containers.removeAt(0));
      // containers.insert(1, containers.removeAt(0));
    });
  }
}

class ColorFulContainer extends StatefulWidget {
  @override
  State<ColorFulContainer> createState() => _ColorFulContainerState();
}

class _ColorFulContainerState extends State<ColorFulContainer> {
  final Color myColor = ColorGen.fetchColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: myColor,
    );
  }
}

class ColorGen {
  const ColorGen();

  static final _ran = Random();

  static Color fetchColor() {
    return Color.fromRGBO(
      _ran.nextInt(256),
      _ran.nextInt(256),
      _ran.nextInt(256),
      1,
    );
  }
}
