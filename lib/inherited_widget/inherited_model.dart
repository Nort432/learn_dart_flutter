import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DataOwnerStateful(),
    );
  }
}

class DataOwnerStateful extends StatefulWidget {
  const DataOwnerStateful({Key? key}) : super(key: key);

  @override
  State<DataOwnerStateful> createState() => _DataOwnerStatefulState();
}

class _DataOwnerStatefulState extends State<DataOwnerStateful> {
  int _valueOne = 0;
  int _valueTwo = 0;

  void _incrementOne() {
    _valueOne += 1;
    setState(() {});
  }

  void _incrementTwo() {
    _valueTwo += 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: _incrementOne, child: const Text('Press 1')),
            ElevatedButton(
                onPressed: _incrementTwo, child: const Text('Press 2')),
            DataProviderInherited(
              valueOne: _valueOne,
              valueTwo: _valueTwo,
              child: const DataConsumerStateless(),
            ),
          ],
        ),
      ),
    );
  }
}

class DataProviderInherited extends InheritedModel<String> {
  final int valueOne;
  final int valueTwo;

  const DataProviderInherited({
    Key? key,
    required this.valueOne,
    required this.valueTwo,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(DataProviderInherited oldWidget) {
    return valueOne != oldWidget.valueOne || valueTwo != oldWidget.valueTwo;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant DataProviderInherited oldWidget,
    Set<String> dependencies,
  ) {
    final bool isOne =
        valueOne != oldWidget.valueOne && dependencies.contains('one');
    final bool isTwo =
        valueTwo != oldWidget.valueTwo && dependencies.contains('two');
    return isOne || isTwo;
  }
}

class DataConsumerStateless extends StatelessWidget {
  const DataConsumerStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int? valueOne = context
            .dependOnInheritedWidgetOfExactType<DataProviderInherited>(
                aspect: 'one')
            ?.valueOne ??
        0;

    return Column(
      children: [
        Text('Data Consumer Stateless [valueOne]: $valueOne'),
        const DataConsumerStateful(),
      ],
    );
  }
}

class DataConsumerStateful extends StatefulWidget {
  const DataConsumerStateful({Key? key}) : super(key: key);

  @override
  State<DataConsumerStateful> createState() => _DataConsumerStatefulState();
}

class _DataConsumerStatefulState extends State<DataConsumerStateful> {
  @override
  Widget build(BuildContext context) {
    final int? valueTwo = context
            .dependOnInheritedWidgetOfExactType<DataProviderInherited>(
                aspect: 'two')
            ?.valueTwo ??
        0;

    return Text('Data Consumer Stateful [valueTwo]: $valueTwo');
  }
}

@immutable
class Student {
  final int rollNum; // not final
  final String name;

  const Student(this.rollNum, this.name);
}
