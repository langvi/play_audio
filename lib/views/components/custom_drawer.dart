import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:play_audio/base/base_style.dart';
import 'package:play_audio/models/song.dart';

Widget buildDrawer(List<Song> songs) {
  return Drawer(
    child: Container(
      color: Colors.black54,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'All songs',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: CircleAvatar(
                    child: Icon(Entypo.music),
                  ),
                  title: Text(
                    songs[index].nameSong,
                    style: AppStyles.textStyleBig,
                  ),
                  subtitle: Text(
                    songs[index].nameSinger,
                    style: AppStyles.textStyleSub,
                  ),
                );
              },
            ),
          )
        ],
      ),
    ),
  );
}
