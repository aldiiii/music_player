import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:music_player/data/models/itunes_model.dart';

class MusicList extends StatefulWidget {
  const MusicList({Key key, this.player, this.itunes}) : super(key: key);

  final AssetsAudioPlayer player;
  final ItunesModel itunes;

  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  int currentPlaying;
  @override
  void initState() {
    super.initState();

    widget.player.current.listen((event) {
      setState(() {
        if (event != null) currentPlaying = event.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.itunes.resultCount,
      itemBuilder: (context, index) {
        return ListTile(
          isThreeLine: true,
          contentPadding: const EdgeInsets.all(0),
          leading: Image.network(
            widget.itunes.results[index].artworkUrl100,
            width: 60.0,
            height: 60.0,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return CupertinoActivityIndicator();
            },
          ),
          title: Text(
            widget.itunes.results[index].trackName,
            maxLines: 1,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.itunes.results[index].artistName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
              const SizedBox(height: 3),
              Text(
                widget.itunes.results[index].collectionName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ],
          ),
          trailing: currentPlaying == index ? Icon(Icons.graphic_eq) : null,
          onTap: () {
            widget.player.playlistPlayAtIndex(index);
          },
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
