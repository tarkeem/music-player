import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:musicoo/controll/musicController.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class songCard extends StatelessWidget {
  SongModel song;
  songCard(this.song);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            QueryArtworkWidget(
              id: song.id,
              type: ArtworkType.AUDIO,
            ),
            Expanded(
                child: Text(
              song.title,
              style: TextStyle(color: Colors.purple),
            )),
            Consumer<musicController>(
              builder: (context, value, child) => IconButton(
                  onPressed: () {
                    if (value.isFavourite(song)) {
                      value.deleteSong(song);
                    } else {
                      value.insertSong(song);
                    }
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: Provider.of<musicController>(context, listen: true)
                            .isFavourite(song)
                        ? Colors.red
                        : Colors.white,
                  )),
            )
          ],
        )).asGlass();
  }
}
