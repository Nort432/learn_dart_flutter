part of 'watch_bloc.dart';

@immutable
abstract class WatchState {}

class WatchLoading extends WatchState {
   WatchLoading();

  @override
  List<Object> get props => [];
}

class WatchLoaded extends WatchState {
   WatchLoaded({this.text = 'aaaaaaaaa'});

   String text;


  @override
  List<Object> get props => [];
}

class WatchError extends WatchState {
   WatchError(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

