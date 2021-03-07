import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/data/cubits/itunes/itunes_cubit.dart';
import 'package:music_player/data/cubits/music_control/music_control_cubit.dart';
import 'package:music_player/data/models/itunes_model.dart';
import 'package:music_player/data/models/music_control_model.dart';
import 'package:music_player/widgets/player_widget.dart';

const kUrl1 =
    'https://audio-ssl.itunes.apple.com/itunes-assets/Music7/v4/c7/9d/47/c79d4764-061a-27ce-59b9-d2d5b5c6ce7e/mzaf_4644533900398680324.plus.aac.p.m4a';
const kUrl2 =
    'https://audio-ssl.itunes.apple.com/itunes-assets/Music/26/1f/2c/mzi.mtnfrsen.aac.p.m4a';
const kUrl3 =
    'https://audio-ssl.itunes.apple.com/itunes-assets/Music7/v4/39/9e/d8/399ed8bb-c90e-eb2c-1845-204906601e1a/mzaf_7162507682972082060.plus.aac.p.m4a';

class MusicList extends StatefulWidget {
  const MusicList({Key key, this.itunes}) : super(key: key);

  final ItunesModel itunes;

  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
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
          trailing: widget.itunes.results[index].isSelected == true
              ? Icon(Icons.graphic_eq)
              : null,
          onTap: () {
            final musicCubit = BlocProvider.of<MusicControlCubit>(context);

            widget.itunes.results.forEach((element) {
              element.isSelected = false;
            });

            widget.itunes.results[index].isSelected = true;

            musicCubit.playMusic(itunes: widget.itunes.results);

            // rebuild
            setState(() {});
          },
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
