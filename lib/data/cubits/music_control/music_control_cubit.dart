import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:music_player/data/models/itunes_model.dart';
import 'package:music_player/data/models/music_control_model.dart';

part 'music_control_state.dart';

class MusicControlCubit extends Cubit<MusicControlState> {
  MusicControlCubit() : super(MusicControlInitial());

  void playMusic({@required List<Result> itunes}) async {
    emit(SelectedState(itunes));
  }
}
