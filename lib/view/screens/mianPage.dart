import 'dart:async';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:glass/glass.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:musicoo/controll/musicController.dart';
import 'package:musicoo/main.dart';
import 'package:musicoo/services/audioServices.dart';
import 'package:musicoo/view/widget/bottomMainPart.dart';
import 'package:musicoo/view/widget/soundCard.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<SongModel> songs = musicController.songs;

  ValueNotifier<int> choicepic = ValueNotifier(0);
  List images = ['assets/a.jpg', 'assets/b.jpg'];
  void timerfun() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (choicepic.value == 0) {
        choicepic.value = 1;
      } else {
        choicepic.value = 0;
      }
    });
  }

  @override
  void initState() {
    timerfun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(songs.length);
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: ListenableBuilder(
            listenable: choicepic,
            builder: (context, child) {
              print(choicepic.value.toString());
              return AnimatedSwitcher(
                  duration: Duration(seconds: 2),
                  child: Container(
                      key: Key(choicepic.value.toString()),
                      height: double.infinity,
                      width: double.infinity,
                      child: Image.asset(
                        images[choicepic.value],
                        fit: BoxFit.cover,
                      )));
            },
          )),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: deviceSize.height * 0.5,
              width: deviceSize.width,
              child: AnimationLimiter(
                child: ListWheelScrollView(
                  // useMagnifier: true,
                  //diameterRatio: 20,
                  //offAxisFraction: 1,
                  //overAndUnderCenterOpacity: 0.5,
                  //perspective: 0.01,
                  //squeeze: 1.2,
                  //magnification: 5,

                  itemExtent: 70,

                  children: [
                    ...songs.map((element) {
                      SongModel song = element;
                      return GestureDetector(
                          onTap: () {
                           
                            audioHandler.play();
                            /*Provider.of<musicController>(context, listen: false)
                                .setSong(song);
                            Provider.of<musicController>(context, listen: false)
                                .playSong();*/
                          },
                          child: songCard(song));
                    })
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: bottomBar(),
          )
        ],
      ),
    );
  }
}

