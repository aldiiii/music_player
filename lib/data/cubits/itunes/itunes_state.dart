part of 'itunes_cubit.dart';

abstract class ItunesState extends Equatable {
  const ItunesState();

  @override
  List<Object> get props => [];
}

class InitialState extends ItunesState {}

class LoadingState extends ItunesState {}

class EmptyState extends ItunesState {}

class LoadedState extends ItunesState {
  LoadedState(this.itunes);
  final ItunesModel itunes;

  @override
  List<Object> get props => [itunes];
}

class FailureState extends ItunesState {
  final String errorMessage;

  FailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureState{errorMessage: $errorMessage}';
  }
}
