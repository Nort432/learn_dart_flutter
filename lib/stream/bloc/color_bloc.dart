import 'dart:async';

import 'package:flutter/material.dart';

enum ColorEvent { green, yellow }

@immutable
class ColorBloc {
  ColorBloc() {
    _inputEventController.stream.listen(_mapEventToState);
  }

  final _inputEventController = StreamController<ColorEvent>();

  StreamSink<ColorEvent> get inputEventSink => _inputEventController.sink;

  final _outputStateController = StreamController<Color>();

  Stream<Color> get outputStateStream => _outputStateController.stream;

  void _mapEventToState(ColorEvent event) {
    Color _color;

    if (event == ColorEvent.green) {
      _color = Colors.greenAccent;
    }
    else if (event == ColorEvent.yellow) {
      _color = Colors.yellowAccent;
    }
    else {
      throw Exception('Invalid event');
    }

    _outputStateController.sink.add(_color);
  }

  void dispose() {
    _inputEventController.close();
    _outputStateController.close();
  }
}
