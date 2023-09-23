import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:like_button/like_button.dart';
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
              builder:(context, value, child) => LikeButton(
                onTap: (isLiked) async{
                  if (value.isFavourite(song)) {
                        value.deleteSong(song);
                        return false;
                      } else {
                        value.insertSong(song);
                        return true;
                      }
                },
                likeBuilder: (isLiked) =>Icon(Icons.favorite,color: isLiked?Colors.red:Colors.white,) ,
                isLiked: value.isFavourite(song),
                bubblesSize: 100,
              ) ,
            )
          ],
        )).asGlass();
  }
}
