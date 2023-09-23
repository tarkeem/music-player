import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:musicoo/controll/musicController.dart';
import 'package:musicoo/main.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class favouriteCard extends StatefulWidget {
  favouriteCard({required SongModel this.song, this.preimage,super.key});
  SongModel song;
  Uint8List? preimage;
  @override
  State<favouriteCard> createState() => _favouriteCardState();
}

class _favouriteCardState extends State<favouriteCard> {
  @override
  void initState() {
    if(widget.preimage==null)
    {
      print("ok............................");
    Provider.of<musicController>(context, listen: false)
        .fetchSongArtWork(widget.song.id)
        .then((value) {
      setState(() {
        image = value;
      });
    });
    }
    else
    {
      image=widget.preimage;
    }
    
    super.initState();
  }

  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         int songsIndex = musicController.songs.indexOf(widget.song);
                            print(songsIndex);
                            print('clicked');
                        
                            myHandler.skipToQueueItem(songsIndex);
                            myHandler.play();
      },
      child: Container(
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
                    ? Image.memory(image!,fit: BoxFit.fill,)
                    : Icon(Icons.music_note,size: 30,)),
            Expanded(flex: 1, child: Text(widget.song.title,style: TextStyle(color: Colors.white),)),
            
          ],
        ),
      ).asGlass(clipBorderRadius:BorderRadius.circular(20)),
    );
  }
}
