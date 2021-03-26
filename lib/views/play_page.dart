import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:play_audio/models/song.dart';
import 'package:play_audio/presenters/song_presenter.dart';
import 'package:play_audio/utils/convert_value.dart';
import 'package:play_audio/views/base_view.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayPage extends StatefulWidget {
  PlayPage({Key key}) : super(key: key);

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage>
    with SingleTickerProviderStateMixin
    implements BaseView {
  SongPresenter _presenter;
  Song _song;
  Timer _timer;
  double _currentValue = 0.0;
  int _maxTime = 100;
  int _time = 100;
  AnimationController animationController;
  final _advancedPlayer = AudioPlayer();
  final audioCache = AudioCache();
  @override
  void initState() {
    _presenter = SongPresenter();
    _song = Song();
    _presenter.view = this;
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animationController.forward();
    setTimer();

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(child: Container(), preferredSize: Size.zero),
      body: Container(
        color: Colors.black54,
        child: Column(
          children: [
             const SizedBox(
              height: 50,
            ),
            _buildAvatar(),
            const SizedBox(
              height: 40,
            ),
            Text(
              'My song',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'No name',
              style: TextStyle(color: Colors.grey),
            ),
            _buildSeekBar(),
            _buildTimeRun(),
            const SizedBox(
              height: 40,
            ),
            Expanded(child: _buildControl())
          ],
        ),
      ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Text(_song.name),
      //     RaisedButton(
      //       onPressed: () async {

      //         var status = await Permission.storage.status;
      //         if (!status.isGranted) {
      //           print('start');
      //           await Permission.storage.request();
      //           await _advancedPlayer.play(
      //               '/storage/emulated/0/Download/music.mp3',
      //               isLocal: true);
      //         }

      //       },
      //       child: Text('OK'),
      //     )
      //   ],
      // ),
    );
  }

  Widget _buildAvatar() {
    return SizedBox(
      width: 250,
      height: 250,
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        child: FlutterLogo(
          size: 100,
        ),
      ),
    );
  }

  Widget _buildSeekBar() {
    return Slider(
      value: _currentValue,
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
      onChanged: (value) {
        // setState(() {
        //   _currentValue = value;
        // });
      },
    );
  }

  Widget _buildTimeRun() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(convertTimeToString(_maxTime),
              style: TextStyle(color: Colors.white)),
          Text(
            convertTimeToString(_time),
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildControl() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
      color: Colors.black38,

          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            color: Colors.white,
            icon: Icon(AntDesign.stepbackward, size: 34,),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white)),
                child: InkWell(
                  onTap: () {
                    if (animationController.status == AnimationStatus.completed) {
                      setState(() {
                        animationController.reverse();
                      });
                    } else {
                      setState(() {
                        animationController.forward();
                      });
                    }
                  },
                  child: AnimatedIcon(size: 34,
                      color: Colors.white,
                      icon: AnimatedIcons.play_pause,
                      progress: animationController),
                )),
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(AntDesign.stepforward,size: 34,),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  void setTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_maxTime == 0) {
        _timer.cancel();
      } else {
        setState(() {
          _maxTime--;
          _currentValue = (100 - _maxTime) / _time;
        });
      }
    });
  }

  @override
  void updateName(Song song) {
    setState(() {
      _song = song;
    });
  }
}
