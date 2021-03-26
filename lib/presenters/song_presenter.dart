import 'package:play_audio/models/song.dart';
import 'package:play_audio/presenters/base_presenter.dart';
import 'package:play_audio/views/base_view.dart';

class SongPresenter extends BasePresenter {
  Song song;
  BaseView view;
  @override
  void fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    song = Song(name: 'Waka waka');
    view.updateName(song);
  }
}
