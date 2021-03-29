import 'dart:io';

import 'package:play_audio/models/song.dart';

abstract class BasePresenter {
  void fetchData();
  Future<void> getFileFromDivice();
  Future<List<String>> getFileImageFromDevice();
  Future<List<File>> getFilePicker();
}
