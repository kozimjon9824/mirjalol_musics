import 'package:another_xlider/another_xlider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirjalol_musics/core/themes/app_colors.dart';
import 'package:mirjalol_musics/data/data_source/data_source.dart';
import 'package:mirjalol_musics/data/model/song_data.dart';
import 'package:text_scroll/text_scroll.dart';
import 'widgets/music_control_button.dart';
import 'widgets/music_drawer.dart';
import 'widgets/single_music_item.dart';

class MusicApp extends StatefulWidget {
  const MusicApp({Key? key}) : super(key: key);

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  dynamic _distanceValue = 0.0;
  final _assetsAudioPlayer = AssetsAudioPlayer();
  int _currentSong = -1;

  final audios = songsList
      .map((song) => Audio(song.url,
          metas: Metas(
              title: song.title,
              artist: 'Mirjalol Nematov',
              album: 'Bir sher yozdim',
              image: const MetasImage.asset('assets/images/mirjalol.jpeg'))))
      .toList();

  @override
  void initState() {
    openPlayer();
    super.initState();
    _assetsAudioPlayer.current.listen((playingAudio) {
      final _index = playingAudio?.index ?? 0;
      _currentSong = _index;
      setState(() {});
    });
    _assetsAudioPlayer.playlistFinished.listen((finished) async {
      if (finished) {
        await _assetsAudioPlayer.open(
          Playlist(audios: audios, startIndex: 0),
          showNotification: true,
          autoStart: true,
          playInBackground: PlayInBackground.enabled,
          audioFocusStrategy: const AudioFocusStrategy.request(
              resumeAfterInterruption: true,
              resumeOthersPlayersAfterDone: true),
          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
        );
      }
    });
  }

  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      autoStart: false,
    );
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral,
      appBar: AppBar(
        backgroundColor: AppColors.neutral,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('My Playlist', style: TextStyle(color: Colors.white)),
      ),
      drawer: const MusicDrawer(),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        itemCount: songsList.length,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          SongDetailModel data = songsList[index];
          return SingleMusicItem(
            bgColor:
                (index == _currentSong) ? AppColors.purple : AppColors.neutral,
            onTap: () async {
              _currentSong = index;
              setState(() {});
              await _assetsAudioPlayer.open(
                Playlist(audios: audios, startIndex: index),
                showNotification: true,
                autoStart: true,
                playInBackground: PlayInBackground.enabled,
                audioFocusStrategy: const AudioFocusStrategy.request(
                    resumeAfterInterruption: true,
                    resumeOthersPlayersAfterDone: true),
                headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
              );
            },
            title: data.title,
            duration: data.duration,
          );
        },
        separatorBuilder: (_, __) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(height: 0, color: Colors.white),
        ),
      ),
      bottomNavigationBar: _currentSong < 0
          ? const SizedBox.shrink()
          : SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          flex: 2,
                          child: SizedBox(),
                        ),
                        Flexible(
                          flex: 2,
                          child: TextScroll(songsList[_currentSong].title,
                              velocity: const Velocity(
                                  pixelsPerSecond: Offset(50, 0)),
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.center,
                              selectable: true,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                        const Flexible(
                          flex: 2,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    StreamBuilder(
                      stream: _assetsAudioPlayer.currentPosition,
                      builder: (context, AsyncSnapshot? snapshot) {
                        final duration = snapshot?.data;
                        _distanceValue = duration?.inSeconds ?? 0;
                        return Row(
                          children: [
                            Text(
                              '${(duration?.inMinutes ?? 0)}:${(duration?.inSeconds ?? 0) % 60}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 13),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: FlutterSlider(
                                values: [_distanceValue.toDouble()],
                                rangeSlider: false,
                                max: _assetsAudioPlayer
                                        .current.value?.audio.duration.inSeconds
                                        .toDouble() ??
                                    1,
                                min: 0,
                                onDragging:
                                    (handlerIndex, lowerValue, upperValue) {
                                  _distanceValue = lowerValue;
                                  _assetsAudioPlayer.seek(
                                      Duration(seconds: lowerValue.toInt()));
                                  setState(() {});
                                },
                                trackBar: FlutterSliderTrackBar(
                                  inactiveTrackBar: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white70,
                                    // border: Border.all(width: 3, color: Colors.blue),
                                  ),
                                  activeTrackBar: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                handler: FlutterSliderHandler(
                                  opacity: 1,
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent),
                                  child: const Icon(
                                    CupertinoIcons.app_fill,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                handlerAnimation:
                                    const FlutterSliderHandlerAnimation(
                                        scale: 1,
                                        duration: Duration(milliseconds: 0)),
                                tooltip: FlutterSliderTooltip(
                                    alwaysShowTooltip: false,
                                    format: (time) {
                                      return '${double.parse(time) ~/ 60}:${double.parse(time).toInt() % 60}';
                                    }),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${(_assetsAudioPlayer.current.value?.audio.duration.inMinutes ?? 0)}:${(_assetsAudioPlayer.current.value?.audio.duration.inSeconds ?? 0) % 60}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      MusicControlButton(
                        size: 44,
                        iconData: 'ic_pre_l',
                        bgColor: AppColors.neutral600,
                        iconSize: 16,
                        onTap: () {
                          _assetsAudioPlayer.previous();
                          setState(() {});
                        },
                      ),
                      const SizedBox(width: 28),
                      StreamBuilder(
                        stream: _assetsAudioPlayer.isPlaying,
                        builder: (context, AsyncSnapshot? snapshot) {
                          final bool isPlaying = snapshot?.data ?? false;
                          return MusicControlButton(
                            size: 60,
                            iconData: isPlaying ? 'ic_pause' : 'ic_play',
                            bgColor: Colors.deepPurpleAccent,
                            iconSize: 20,
                            onTap: () {
                              _assetsAudioPlayer.playOrPause();
                              setState(() {});
                            },
                          );
                        },
                      ),
                      const SizedBox(width: 28),
                      MusicControlButton(
                        size: 44,
                        iconData: 'ic_next_r',
                        bgColor: AppColors.neutral600,
                        iconSize: 16,
                        onTap: () {
                          _assetsAudioPlayer.next(keepLoopMode: true);
                          setState(() {});
                        },
                      ),
                    ]),
                    const SizedBox(height: 12)
                  ],
                ),
              ),
            ),
    );
  }
}
