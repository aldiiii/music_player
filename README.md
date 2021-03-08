# Music Player
## Features

- Music Playlist
- Simple Player Control
- Searching music from [affiliate itunes apple](https://external-link.egnyte.com/?url=https%3A%2F%2Faffiliate.itunes.apple.com%2Fresources%2Fdocumentation%2Fitunes-store-web-service-search-api/)

## Plugins

Music Player uses a number of open source projects to work properly:

- [flutter_bloc] - Flutter Widgets that make it easy to implement the BLoC (Business Logic Component) design pattern. Built to be used with the bloc state management package.
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