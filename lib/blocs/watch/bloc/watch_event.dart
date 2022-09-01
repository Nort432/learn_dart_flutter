part of 'watch_bloc.dart';

@immutable
abstract class WatchEvent {
  const WatchEvent();
}

class WatchInitialEvent extends WatchEvent {
   const WatchInitialEvent();

  @override
  List<Object?> get props => [];
}

class WatchTestEvent extends WatchEvent {
  const WatchTestEvent();

  @override
  List<Object?> get props => [];
}