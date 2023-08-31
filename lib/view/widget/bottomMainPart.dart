import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:musicoo/main.dart';
import 'package:musicoo/service/audioServices.dart';
import 'package:musicoo/view/widget/customButton.dart';
import 'package:rxdart/rxdart.dart';

class bottomBar extends StatefulWidget {
  const bottomBar({Key? key}) : super(key: key);

  @override
  State<bottomBar> createState() => _bottomBarState();
}

class _bottomBarState extends State<bottomBar> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder(
          stream: _mediaStateStream,
          
          builder:(context, snapshot) {
            String songTitle=snapshot.hasData?snapshot.data!.mediaItem!.title:"";
            return Text(songTitle);
          } , ),
        Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            customButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                size: 50,
                color: Colors.white,
              ),
              onPressed: () {
               myHandler.skipToPrevious();
              },
            ),
            StreamBuilder(
              stream: myHandler.playbackState
                  .map((state) => state.playing)
                  .distinct(),
              builder:(context, snapshot) {
                 return customButton(
                icon: snapshot.data??false
                    ? Icon(
                        Icons.pause,
                        size: 70,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.play_arrow,
                        size: 70,
                        color: Colors.white,
                      ),
                onPressed: () {
                  if (snapshot.data??false) {
                   
                    myHandler.pause();
                  } else {
                    
                        myHandler.play();
                  }
                },
              );}
            ),
            customButton(
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 50,
                color: Colors.white,
              ),
              onPressed: () {
              myHandler.skipToNext();
              },
            ),
          ],
        ),
        StreamBuilder(
            stream: _mediaStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final mediaState = snapshot.data;
                return ProgressBar(
                  total: mediaState?.mediaItem?.duration ?? Duration.zero,
                  progress: mediaState?.position ?? Duration.zero,
                  onSeek: (duration) {
                    myHandler.seek(duration);
                    print('User selected a new time: $duration');
                  },
                );
              } else {
                return Container();
              }
            }),
      ],
    );
  }

  Stream<MediaState> get _mediaStateStream =>
      Rx.combineLatest2<MediaItem?, Duration, MediaState>(
          myHandler.mediaItem,
          AudioService.position,
          (mediaItem, position) => MediaState(mediaItem, position));
}
