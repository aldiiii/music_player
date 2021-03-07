import 'dart:convert';

import 'package:music_player/data/models/itunes_model.dart';
import 'package:meta/meta.dart';
import 'package:music_player/services/http_client.dart';

class ItunesRepository {
  ItunesRepository(this._client);

  final HttpClient _client;

  Future<ItunesModel> fetchItunes(
      {@required String artist, Map<String, dynamic> params}) async {
    await Future.delayed(Duration(seconds: 1));

    final Map<String, dynamic> exampleParam = {"term": artist};

    final response =
        await _client.get('/search', queryParameters: exampleParam);

    final jsonResponse = jsonDecode(response);
    return ItunesModel.fromJson(jsonResponse);
  }
}
