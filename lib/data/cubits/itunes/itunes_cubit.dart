import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:music_player/data/models/itunes_model.dart';
import 'package:music_player/data/repositories/itunes_repository.dart';

part 'itunes_state.dart';

class ItunesCubit extends Cubit<ItunesState> {
  ItunesCubit({this.repository}) : super(InitialState());

  final ItunesRepository repository;

  void getItunes({@required String artist}) async {
    try {
      emit(LoadingState());
      final itunesData = await repository.fetchItunes(artist: artist);

      if (itunesData.resultCount == 0) {
        emit(EmptyState());
      } else {
        emit(LoadedState(itunesData));
      }
    } catch (e) {
      emit(FailureState(e));
    }
  }
}
