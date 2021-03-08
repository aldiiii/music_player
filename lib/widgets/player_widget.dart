import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/data/cubits/itunes/itunes_cubit.dart';
import 'package:music_player/widgets/player_control.dart';
import 'package:music_player/widgets/positionSeek_widget.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({Key key, this.player}) : super(key: key);

  final AssetsAudioPlayer player;

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItunesCubit, ItunesState>(builder: (context, state) {
      if (state is LoadedState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder(
              stream: widget.player.loopMode,
              initialData: LoopMode.none,
              builder: (context, snapshotLooping) {
                final LoopMode loopMode = snapshotLooping.data;
                return StreamBuilder(
                    stream: widget.player.isPlaying,
                    initialData: false,
                    builder: (context, snapshotPlaying) {
                      final isPlaying = snapshotPlaying.data;
                      return PlayingControls(
                        loopMode: loopMode,
                        isPlaying: isPlaying,
                        isPlaylist: widget.player.playlist.audios.length > 1,
                        onPlay: () {
                          widget.player.playOrPause();
                        },
                        onNext: () {
                          //_assetsAudioPlayer.forward(Duration(seconds: 10));
                          widget.player.next();
                        },
                        onPrevious: () {
                          widget.player.previous();
                        },
                      );
                    });
              },
            ),
            StreamBuilder(
                stream: widget.player.realtimePlayingInfos,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox();
                  }

                  final RealtimePlayingInfos infos = snapshot.data;
                  return PositionSeekWidget(
                    currentPosition: infos.currentPosition,
                    duration: infos.duration,
                    seekTo: (to) {
                      widget.player.seek(to);
                    },
                  );
                }),
          ],
        );
      } else {
        return SizedBox();
      }
    });
  }
}
