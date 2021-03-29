import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:play_audio/models/song.dart';
import 'package:play_audio/presenters/base_presenter.dart';
import 'package:play_audio/utils/permission.dart';
import 'package:play_audio/views/base_view.dart';

class SongPresenter extends BasePresenter {
  Song song;
  BaseView view;
  @override
  void fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    song = Song(nameSong: 'Waka waka');
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
    var files = await FileManager(root: directory).walk().toList();
    files.forEach((element) {
      if (element.path.split('.').last == 'jpg') {
        print(element.path);
      }
    });
  }

  @override
  Future<List<String>> getFileImageFromDevice() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    var path = await ExtStorage.getExternalStorageDirectory();
    Directory directory = Directory(path);
    var files = await FileManager(root: directory).walk().toList();
    List<String> paths = [];
    files.forEach((element) {
      if (element.path.split('.').last == 'jpg') {
        paths.add(element.path);
      }
    });
    return paths;
  }

  @override
  Future<List<File>> getFilePicker() async {
    await handlePermisson();
    FilePickerResult result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        allowedExtensions: ['mp3', 'm4a', 'wav'],
        type: FileType.custom);
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
      return files;
    } else {
      return [];
    }
  }
}
