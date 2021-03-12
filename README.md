# Music Player
## Features

- Cubit State Management
- Music Playlist
- Simple Player Control
- Searching music Uses the [iTunes affiliate API](https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/)

## Plugins

Music Player uses a number of open source projects to work properly:

- [flutter_bloc] - The Cubit is a subset of the famous implementation of BLoC Pattern: [Bloc Library](bloclibrary.dev), it abandons the concept of Events and simplifies the way of emitting states.
- [equatable] - A Dart package that helps to implement value based equality without needing to explicitly override == and hashCode.
- [dio] - A powerful Http client for Dart, which supports Interceptors, Global configuration, FormData, Request Cancellation, File downloading, Timeout etc.
- [assets_audio_player] - Play music/audio stored in assets files (simultaneously) directly from Flutter (android / ios / web / macos).

## Installation

Works with flutter: ">=1.22.6 <2.0.0", **be sure to upgrade your sdk.**

run development

```sh
cd music_player
flutter pub get
flutter run
```

For build production

```sh
flutter build apk --release
```

## Supported

Only supported Device Android
