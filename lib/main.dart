import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/data/cubits/itunes/itunes_cubit.dart';
import 'package:music_player/data/cubits/music_control/music_control_cubit.dart';
import 'package:music_player/data/repositories/itunes_repository.dart';
import 'package:music_player/screen/music_screen.dart';
import 'package:music_player/services/http_client.dart';

void main() {
  runApp(MaterialApp(
    home: MultiBlocProvider(
      providers: [
        // itunes provicer
        BlocProvider<ItunesCubit>(
          create: (context) =>
              ItunesCubit(repository: ItunesRepository(HttpClientImpl(Dio()))),
        ),
        // music controller provicer
        BlocProvider<MusicControlCubit>(
          create: (context) => MusicControlCubit(),
        ),
      ],
      child: MusicScreen(),
    ),
  ));
}
