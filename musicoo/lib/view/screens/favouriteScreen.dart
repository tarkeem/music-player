import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:musicoo/controll/musicController.dart';
import 'package:musicoo/view/widget/customButton.dart';
import 'package:musicoo/view/widget/favouriteCard.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class favouriteScreen extends StatefulWidget {
  favouriteScreen({super.key});

  @override
  State<favouriteScreen> createState() => _favouriteScreenState();
}

class _favouriteScreenState extends State<favouriteScreen> {
  PageController _pageController = PageController(viewportFraction: 0.65);

  double page = 0;
  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        page = _pageController.page!;
      });
    });

   
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    List<SongModel> songs = musicController.favouritrIdSong;
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/a.jpg'), fit: BoxFit.cover)),
      child: Center(
        child: Container(
                height: deviceSize.height * 0.6,
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: musicController.favouritrIdSong.length,
                    itemBuilder: (context, index) {
                      
                      double perc = (page - index).abs();
                      double factor = 1 - perc;

                      return Transform.scale(
                        scale: factor.clamp(0.8, 1),
                        child: Opacity(
                            opacity: factor.clamp(0.6, 1),
                            child: favouriteCard(
                              song: songs[index],
                            )),
                      );
                    })),
      ),
    ));
  }
}

