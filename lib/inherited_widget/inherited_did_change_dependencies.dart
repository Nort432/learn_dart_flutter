import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SimpleCalcWidget(),
    );
  }
}

class SimpleCalcWidget extends StatefulWidget {
  const SimpleCalcWidget({Key? key}) : super(key: key);

  @override
  State<SimpleCalcWidget> createState() => _SimpleCalcWidgetState();
}

class _SimpleCalcWidgetState extends State<SimpleCalcWidget> {
  final _model = SimpleCalcWidgetModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: SimpleCalcWidgetProvider(
        model: _model,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            LineOne(),
            LineTwo(),
            TextResult(),
            ButtonDone(),
          ],
        ),
      ),
    );
  }
}

class LineOne extends StatelessWidget {
  const LineOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
            hintText: 'Enter valid email id as abc@gmail.com'),
        onChanged: (newValue) =>
            SimpleCalcWidgetProvider.of(context).model.firstNumber = newValue,
      ),
    );
  }
}

class LineTwo extends StatelessWidget {
  const LineTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 20),
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
          hintText: 'Enter secure password',
        ),
        onChanged: (newValue) =>
            SimpleCalcWidgetProvider.of(context).model.secondNumber = newValue,
      ),
    );
  }
}

class TextResult extends StatefulWidget {
  const TextResult({Key? key}) : super(key: key);

  @override
  State<TextResult> createState() => _TextResultState();
}

class _TextResultState extends State<TextResult> {
  String _value = '-1';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final SimpleCalcWidgetModel model =
        SimpleCalcWidgetProvider.of(context).model;

    model.addListener(() {
      _value = '${model.sumResult}';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('Result ' + fetchResult(context));
  }

  String fetchResult(BuildContext context) {
    final int result =
        SimpleCalcWidgetProvider.of(context).model.sumResult ?? -1;
    return result.toString();
  }
}

class ButtonDone extends StatelessWidget {
  const ButtonDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => SimpleCalcWidgetProvider.of(context).model.sum(),
      child: const Text(
        'Sum',
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}

class SimpleCalcWidgetModel extends ChangeNotifier {
  int? _firstNumber;
  int? _secondNumber;
  int? sumResult;

  set firstNumber(String value) => _firstNumber = int.tryParse(value);

  set secondNumber(String value) => _secondNumber = int.tryParse(value);

  void sum() {
    int? _sumResult;
    if (_firstNumber != null && _secondNumber != null) {
      _sumResult = _firstNumber! + _secondNumber!;
    } else {
      _sumResult = null;
    }
    if (sumResult != _sumResult) {
      sumResult = _sumResult;
      notifyListeners();
    }
  }
}

class SimpleCalcWidgetProvider extends InheritedWidget {
  final SimpleCalcWidgetModel model;

  const SimpleCalcWidgetProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(key: key, child: child);

  static SimpleCalcWidgetProvider of(BuildContext context) {
    final SimpleCalcWidgetProvider? result =
        context.dependOnInheritedWidgetOfExactType<SimpleCalcWidgetProvider>();
    assert(result != null, 'No SimpleCalcWidgetProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SimpleCalcWidgetProvider oldWidget) {
    return model != oldWidget.model;
  }
}
