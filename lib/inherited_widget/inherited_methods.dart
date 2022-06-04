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
  int _value = 0;

  void _increment() {
    _value += 1;
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
            ElevatedButton(onPressed: _increment, child: const Text('Press')),
            DataProviderInherited(
              value: _value,
              child: const DataConsumerStateless(),
            ),
          ],
        ),
      ),
    );
  }
}

class DataProviderInherited extends InheritedWidget {
  final int value;

  const DataProviderInherited({
    Key? key,
    required this.value,
    required Widget child,
  }) : super(key: key, child: child);

  // static DataProviderInherited? of(BuildContext context) {
  //   return context.dependOnInheritedWidgetOfExactType<DataProviderInherited>();
  // }

  @override
  bool updateShouldNotify(DataProviderInherited oldWidget) {
    return value != oldWidget.value;
  }
}

class DataConsumerStateless extends StatelessWidget {
  const DataConsumerStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DataProviderInherited? inherited =
        context.dependOnInheritedWidgetOfExactType<DataProviderInherited>();
    final int value = inherited?.value ?? 0;
    // .findAncestorStateOfType
    //   <_DataOwnerStatefulState>()
    //     ?._value ?? 0;
    return Column(
      children: [
        Text('Data Consumer Stateless: $value'),
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

    final InheritedElement? element = context
        .getElementForInheritedWidgetOfExactType<DataProviderInherited>();

    if(element != null){
      context.dependOnInheritedElement(element);
    }

    final DataProviderInherited dataProvider =
        element?.widget as DataProviderInherited;

    final int value = dataProvider.value;

    // .findAncestorStateOfType<_DataOwnerStatefulState>()?._value ?? 0;

    return Text('Data Consumer Stateful: $value');
  }
}
