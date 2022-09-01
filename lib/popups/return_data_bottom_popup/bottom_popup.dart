import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DeleteWidget();
  }
}

class DeleteWidget extends StatefulWidget {
  @override
  _DeleteWidgetState createState() => _DeleteWidgetState();
}

class _DeleteWidgetState extends State<DeleteWidget> {
  bool userValue = false; //This is the variable that I am trying to change.

  /// Main UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(userValue.toString()),
          ElevatedButton(
            child: const Text("Open bottom popup"),
            onPressed: _callModalBottomSheet,
          ),
        ],
      ),
    );
  }

  /// Popup
  void _callModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            Container(
              child: MyStatefulWidget(userValue: userValue),
            ),
          ],
        );
      },
    ).then(
          (value) {
        setState(
              () {
            userValue = value;
          },
        );
      },
    );

    print("Testing Value: $userValue");
  }
}

class MyStatefulWidget extends StatefulWidget {
  final bool userValue;

   const MyStatefulWidget({Key? key, required this.userValue}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// Popup
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late bool index;

  @override
  void initState() {
    super.initState();
    index = widget.userValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(index.toString()),
        ElevatedButton(
          child: const Text("change counter value"),
          onPressed: () {
            setState(
              () {
                index = !index;
              },
            );
          },
        ),
        ElevatedButton(
          child: const Text("close sheet"),
          onPressed: () {
            /// Loot at index in pop()
            Navigator.pop(context, index);
          },
        )
      ],
    );
  }
}
