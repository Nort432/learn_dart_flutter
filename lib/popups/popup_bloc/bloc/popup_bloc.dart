import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'popup_event.dart';
part 'popup_state.dart';

class PopupBloc extends Bloc<PopupEvent, PopupState> {
  PopupBloc() : super(PopupInitial()) {
    on<PopupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
