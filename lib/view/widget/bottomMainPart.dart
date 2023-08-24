import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicoo/controll/musicController.dart';
import 'package:musicoo/view/widget/customButton.dart';
import 'package:provider/provider.dart';

class bottomBar extends StatefulWidget {
  const bottomBar({Key? key}) : super(key: key);

  @override
  State<bottomBar> createState() => _bottomBarState();
}

class _bottomBarState extends State<bottomBar> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    bool isplaying = Provider.of<musicController>(context).isPlaying();
    AudioPlayer audioPlayer = Provider.of<musicController>(context).audioPlayer;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
                Provider.of<musicController>(context, listen: false)
                    .previousSong();
              },
            ),
            customButton(
              icon: isplaying
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
                if (isplaying) {
                  Provider.of<musicController>(context, listen: false)
                      .pauseSong();
                } else {
                  Provider.of<musicController>(context, listen: false)
                      .contiueSong();
                }
              },
            ),
            customButton(
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 50,
                color: Colors.white,
              ),
              onPressed: () {
                Provider.of<musicController>(context, listen: false).nextSong();
              },
            ),
          ],
        ),
        StreamBuilder(
            stream: audioPlayer.positionStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ProgressBar(
                  progress: Duration(
                      milliseconds: snapshot.data?.inMilliseconds ?? 0),
                  total: Duration(
                      milliseconds: audioPlayer.duration?.inMilliseconds ?? 0),
                  onSeek: (duration) {
                    audioPlayer.seek(duration);
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
}
