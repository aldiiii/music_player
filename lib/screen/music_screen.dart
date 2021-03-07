import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/data/cubits/itunes/itunes_cubit.dart';
import 'package:music_player/data/cubits/music_control/music_control_cubit.dart';
import 'package:music_player/data/models/itunes_model.dart';
import 'package:music_player/data/models/music_control_model.dart';
import 'package:music_player/widgets/music_list.dart';
import 'package:music_player/widgets/player_widget.dart';

const kUrl1 =
    'https://audio-ssl.itunes.apple.com/itunes-assets/Music7/v4/c7/9d/47/c79d4764-061a-27ce-59b9-d2d5b5c6ce7e/mzaf_4644533900398680324.plus.aac.p.m4a';
const kUrl2 =
    'https://audio-ssl.itunes.apple.com/itunes-assets/Music/26/1f/2c/mzi.mtnfrsen.aac.p.m4a';
const kUrl3 =
    'https://audio-ssl.itunes.apple.com/itunes-assets/Music7/v4/39/9e/d8/399ed8bb-c90e-eb2c-1845-204906601e1a/mzaf_7162507682972082060.plus.aac.p.m4a';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  AudioPlayer advancedPlayer = AudioPlayer();
  TextEditingController searchController = TextEditingController();
  // ItunesCubit itunesCubit = ItunesCubit();
  Timer _debounce;

  String url;

  @override
  void initState() {
    super.initState();
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
            // do something with query
            // print(value.trim());
            // if (value.length > 0) {
            final itunesCubit = BlocProvider.of<ItunesCubit>(context);
            // weatherCubit.getWeather(cityName);
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
                child: Text('Searching some artist'),
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
              return MusicList(itunes: itunes);
            } else {
              return Container();
            }
          },
        ),
      ),
      bottomSheet: BlocListener<MusicControlCubit, MusicControlState>(
        listener: (context, state) {
          if (state is SelectedState) {
            state.data.forEach((element) {
              if (element.isSelected == true) {
                setState(() {
                  url = element.previewUrl;
                });
              }
            });
          }
        },
        child: url != null ? PlayerWidget(url: url) : SizedBox(),
      ),
    );
  }
}
