import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class PlayingControls extends StatelessWidget {
  final bool isPlaying;
  final LoopMode loopMode;
  final bool isPlaylist;
  final Function() onPrevious;
  final Function() onPlay;
  final Function() onNext;
  final Function() onStop;

  PlayingControls({
    @required this.isPlaying,
    this.isPlaylist = false,
    this.loopMode,
    this.onPrevious,
    @required this.onPlay,
    this.onNext,
    this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        IconButton(
          onPressed: isPlaylist ? this.onPrevious : null,
          iconSize: 50.0,
          icon: Icon(Icons.skip_previous),
          color: Colors.grey[700],
        ),
        SizedBox(
          width: 12,
        ),
        IconButton(
          onPressed: this.onPlay,
          iconSize: 50.0,
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          color: Colors.grey[700],
        ),
        SizedBox(
          width: 12,
        ),
        IconButton(
          onPressed: isPlaylist ? this.onNext : null,
          iconSize: 50.0,
          icon: Icon(Icons.skip_next),
          color: Colors.grey[700],
        ),
      ],
    );
  }
}
