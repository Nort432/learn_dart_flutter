import 'dart:async';
import 'dart:developer';
import 'dart:math' hide log;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'watch_event.dart';

part 'watch_state.dart';

class WatchBloc extends Bloc<WatchEvent, WatchState> {
  WatchBloc() : super(WatchLoaded()) {
    // add(WatchEvent(WatchTestEvent()));
    // on<WatchEvent>(_initial);
    on<WatchTestEvent>(_test);
  }

  bool timer = true;

  // FutureOr<void> _initial(
  //   WatchEvent event,
  //   Emitter<WatchState> emit,
  // ) async {
  //   emit(WatchLoaded());
  // }

  FutureOr<void> _test(
    WatchTestEvent event,
    Emitter<WatchState> emit,
  ) async {
   emit(WatchLoading());

   while(timer) {
     await Future.delayed(Duration(seconds: 3));
     emit(WatchLoaded(text: Random().nextInt(255).toString()));
   }
  }

  @override
  Future<void> close() {
    log('close ----------');
    timer = false;
    return super.close();
  }

  // Future test(emit) async {
  //   await test1();
  //   log(text1);
  //   emit(WatchLoaded(text: text1 + '21q1q1q'));
  // }
  //
  // Future test1() async {
  //   Stream.periodic(Duration(seconds: 3), (timer) {
  //     text1 = Random().nextInt(255).toString();
  //   });
  // }
}
