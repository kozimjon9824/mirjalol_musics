import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'core/themes/app_theme.dart';
import 'presentation/music_app/music_app.dart';

void main() {
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music app',
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      home: const MusicApp(),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}
