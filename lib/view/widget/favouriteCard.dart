import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:musicoo/controll/musicController.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class favouriteCard extends StatefulWidget {
  favouriteCard({required SongModel this.song, super.key});
  SongModel song;

  @override
  State<favouriteCard> createState() => _favouriteCardState();
}

class _favouriteCardState extends State<favouriteCard> {
  @override
  void initState() {
    Provider.of<musicController>(context, listen: false)
        .fetchSongArtWork(widget.song.id)
        .then((value) {
      setState(() {
        image = value;
      });
    });
    super.initState();
  }

  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Expanded(
              flex: 3,
              child: image != null
                  ? Image.memory(image!)
                  : Icon(Icons.music_note,size: 30,)),
          Expanded(flex: 1, child: Text(widget.song.title)),
          Expanded(flex: 1, child: Placeholder()),
        ],
      ),
    );
  }
}
