import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/data/cubits/itunes/itunes_cubit.dart';
import 'package:music_player/widgets/music_list.dart';
import 'package:music_player/widgets/player_widget.dart';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  final AssetsAudioPlayer _player = AssetsAudioPlayer.newPlayer();
  TextEditingController searchController = TextEditingController();
  Timer _debounce;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // build search field
    Widget _buildSearchField() {
      return TextFormField(
        // controller: searchController,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
            hintStyle: TextStyle(color: Colors.white),
            hintText: 'Search artist'),
        style: TextStyle(color: Colors.white),
        onChanged: (value) {
          if (_debounce?.isActive ?? false) _debounce.cancel();
          if (value.length == 0) return;

          _debounce = Timer(const Duration(milliseconds: 800), () {
            // add action
            final itunesCubit = BlocProvider.of<ItunesCubit>(context);
            itunesCubit.getItunes(artist: value.trim());
            // }
          });
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[700],
          toolbarHeight: 80,
          title: _buildSearchField(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocBuilder<ItunesCubit, ItunesState>(
            builder: (context, state) {
              if (state is InitialState) {
                return Center(
                  child: Text('find your favorite music'),
                );
              } else if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is EmptyState) {
                return Center(
                  child: Text('data is Empty'),
                );
              } else if (state is FailureState) {
                return Center(
                  child: Icon(Icons.close),
                );
              } else if (state is LoadedState) {
                final itunes = state.itunes;

                Playlist playlist = Playlist(audios: []);

                // add preview url to playlist
                itunes.results.forEach((element) {
                  playlist.audios.add(
                    Audio.network(
                      element.previewUrl,
                      metas: Metas(
                        title: element.trackName,
                        artist: element.artistName,
                      ),
                    ),
                  );
                });

                // add to music control
                _player.open(
                  playlist,
                  autoStart: false,
                  showNotification: true,
                );

                return MusicList(player: _player, itunes: itunes);
              } else {
                return Container();
              }
            },
          ),
        ),
        bottomSheet: PlayerWidget(player: _player));
  }
}
