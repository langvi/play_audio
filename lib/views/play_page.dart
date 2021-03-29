import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:play_audio/models/song.dart';
import 'package:play_audio/presenters/song_presenter.dart';
import 'package:play_audio/utils/convert_value.dart';
import 'package:play_audio/utils/navigator.dart';
import 'package:play_audio/views/base_view.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:play_audio/views/components/custom_drawer.dart';
import 'package:seekbar/seekbar.dart';

class PlayPage extends StatefulWidget {
  PlayPage({Key key}) : super(key: key);

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage>
    with TickerProviderStateMixin
    implements BaseView {
  SongPresenter _presenter;
  Song _song;
  Timer _timerProgress;
  Timer _timer;
  double _currentValueSeekBar = 0.0;
  int _timeCount = 0; //ms
  int _timeCountSecond = 0; //s
  int _maxTimeSecond = 100; //s
  int _maxTime = 100000; //ms
  AnimationController animationController;
  AnimationController _seekController;
  Animation<Color> colorTween;
  final _advancedPlayer = AudioPlayer();
  final audioCache = AudioCache();
  final _key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _presenter = SongPresenter();
    _song = Song();
    _presenter.view = this;
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _seekController = AnimationController(vsync: this);
    animationController.forward();
    colorTween = _seekController
        .drive(ColorTween(begin: Colors.blueAccent, end: Colors.grey));
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
      key: _key,
      drawer: SafeArea(
        child: buildDrawer(List<Song>.generate(10, (index) {
          return Song(
              fileUrl: '',
              nameSinger: 'Singer: Alibooo',
              nameSong: 'My song $index');
        })),
      ),
      backgroundColor: Colors.white,
      appBar: PreferredSize(child: Container(), preferredSize: Size.zero),
      body: Container(
        color: Colors.black54,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    _key.currentState.openDrawer();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Entypo.list,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {},
                )
              ],
            ),
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
              height: 50,
            ),
            Expanded(child: _buildControl())
          ],
        ),
      ),
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
    return SeekBar(
      value: _currentValueSeekBar,
      progressColor: Colors.blueAccent,
      barColor: Colors.grey,
    );
  }

  Widget _buildTimeRun() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(convertTimeToString(_timeCountSecond),
              style: TextStyle(color: Colors.white)),
          Text(
            convertTimeToString(_maxTimeSecond),
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
            icon: Icon(
              AntDesign.stepbackward,
              size: 34,
            ),
            onPressed: () async {
              await _presenter.getFileFromDivice();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white)),
                child: InkWell(
                  onTap: () async {
                    if (animationController.status ==
                        AnimationStatus.completed) {
                      // var status = await Permission.storage.status;
                      // if (!status.isGranted) {
                      //   await Permission.storage.request();
                      //   await _advancedPlayer.play(
                      //       '/storage/emulated/0/Download/music.mp3',
                      //       isLocal: true);
                      // }
                      setState(() {
                        animationController.reverse();
                      });
                    } else {
                      // await _advancedPlayer.pause();
                      setState(() {
                        animationController.forward();
                      });
                    }
                  },
                  child: AnimatedIcon(
                      size: 34,
                      color: Colors.white,
                      icon: AnimatedIcons.play_pause,
                      progress: animationController),
                )),
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(
              AntDesign.stepforward,
              size: 34,
            ),
            onPressed: () async {
              var result = await _presenter.getFilePicker();
              result.forEach((element) {
                print(element.path);
              });
            },
          ),
        ],
      ),
    );
  }

  void setTimer() {
    _timerProgress = Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (_timeCount == _maxTime) {
        _timerProgress.cancel();
        _timer.cancel();
      } else {
        setState(() {
          _timeCount += 10;
          _currentValueSeekBar = _timeCount / _maxTime;
        });
      }
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeCountSecond++;
      });
    });
  }

  @override
  void updateName(Song song) {
    setState(() {
      _song = song;
    });
  }
}
