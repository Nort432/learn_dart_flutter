import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_dart_flutter/blocs/watch/bloc/watch_bloc.dart';
import 'package:learn_dart_flutter/blocs/watch/page2.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WatchPage(),
    );
  }
}

class WatchPage extends StatelessWidget {
  const WatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('=> WatchPage');

    return BlocProvider<WatchBloc>(
      create: (ctx) => WatchBloc(),
      child: blocBuilder(context),
    );
  }

  Widget blocBuilder(BuildContext context) {
    return BlocBuilder<WatchBloc, WatchState>(builder: (context, state) {
      log(state.toString());

      if (state is WatchLoading) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
      if (state is WatchLoaded) {
        return DashBody(state.text);
      }
      if (state is WatchError) {
        return DashBody(state.errorMessage);
      }

      return const SizedBox();
    });
  }
}

class DashBody extends StatelessWidget {
  DashBody(this.text, {Key? key}) : super(key: key);

  String text;

  @override
  Widget build(BuildContext context) {
    // final bloc = context.read<WatchBloc>();
    // bloc.timer = true;
    log(ModalRoute.of(context)?.settings.name.toString() ?? 'null');

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                context.read<WatchBloc>().add(WatchTestEvent());
              },
              child: Text(text),
            ),
            ElevatedButton(
              onPressed: () {
                // bloc.timer = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PageTwo(),
                  ),
                );
              },
              child: const Text('Navigator'),
            ),
          ],
        ),
      ),
    );
  }
}
