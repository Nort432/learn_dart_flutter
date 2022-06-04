import 'package:flutter/material.dart';
import 'package:learn_dart_flutter/stream/bloc/color_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    ColorBloc _bloc = ColorBloc();

    @override
    void dispose() {
      _bloc.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: _bloc.outputStateStream,
              initialData: Colors.black,
              builder: (_, snapshot){
                print('StreamBuilder');
                Color myColor = snapshot.data as Color;
                return Container(
                  height: 75,
                  width: 75,
                  color: myColor,
                );
              },
            ),
            ElevatedButton(
              onPressed: () => _bloc.inputEventSink.add(ColorEvent.green),
              child: const Text('Green'),
            ),
            ElevatedButton(
              onPressed: () => _bloc.inputEventSink.add(ColorEvent.yellow),
              child: const Text('Yellow'),
            ),
          ],
        ),
      ),
    );
  }
}
