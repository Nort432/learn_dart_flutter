import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text('text'),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Open'),
          ),
        ],
      ),
    );
  }
}
