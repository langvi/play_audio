import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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

  @override
  Future<void> getFileFromDivice() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    var path = await ExtStorage.getExternalStorageDirectory();
    Directory directory = Directory(path);
    // var root = await getExternalStorageDirectories();
    // print(root);
    var files = FileManager(root: directory).filter;
    print(files);
    // files.forEach((element) {
    //   if (element.path.split('.').last == 'jpeg') {
    //     print(element.path);
    //   }
    // });
  }
}
