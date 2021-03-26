import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:play_audio/models/song.dart';
import 'package:play_audio/presenters/song_presenter.dart';
import 'package:play_audio/views/base_view.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:play_audio/utils/demo_api.dart';

class PlayPage extends StatefulWidget {
  PlayPage({Key key}) : super(key: key);

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> implements BaseView {
  SongPresenter _presenter;
  Song _song;
  final _advancedPlayer = AudioPlayer();
  final audioCache = AudioCache();
  @override
  void initState() {
    _presenter = SongPresenter();
    _song = Song();
    _presenter.view = this;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play song'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text('Demo'),
          Text(_song.name),
          RaisedButton(
            onPressed: () async {
              // Data data = Data.fromJson(res as Map);
              // print(data.name);
              // var status = await Permission.storage.status;
              // if (!status.isGranted) {
              //   print('start');
              //   await Permission.storage.request();
              //   await _advancedPlayer.play(
              //       '/storage/emulated/0/Download/music.mp3',
              //       isLocal: true);
              // }

              // _presenter.fetchData();
              // await audioCache.play('/storage/emulated/0/Download/music.mp3');
              // await _advancedPlayer
              //     .play('/storage/emulated/0/Download/music.mp3', isLocal: true);
              // Directory tempDir = await getApplicationDocumentsDirectory();
              // print(tempDir);
            },
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  void updateName(Song song) {
    setState(() {
      _song = song;
    });
  }
}
