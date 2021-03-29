import 'dart:io';

import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  final List<String> images;
  ImagePage({Key key, @required this.images}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ảnh'),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: List<Widget>.generate(
            widget.images.length, (index) => _buildImage(widget.images[index])),
      ),
    );
  }

  Widget _buildImage(String path) {
    return Image.file(
      File(path),
      fit: BoxFit.cover,
    );
  }
}
