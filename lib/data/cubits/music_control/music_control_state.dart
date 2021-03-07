part of 'music_control_cubit.dart';

abstract class MusicControlState extends Equatable {
  const MusicControlState();

  @override
  List<Object> get props => [];
}

class MusicControlInitial extends MusicControlState {}

class MusicControlEmpty extends MusicControlState {}

class SelectedState extends MusicControlState {
  SelectedState(this.data);
  final List<Result> data;

  @override
  List<Object> get props => [data];
}
