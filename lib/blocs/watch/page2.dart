import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learn_dart_flutter/blocs/watch/page.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    log(ModalRoute.of(context)?.settings.name.toString() ?? 'null');
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const WatchPage(),
              ),
            );
          },
          child: const Text('<- Back'),
        ),
      ),
    );
  }
}
