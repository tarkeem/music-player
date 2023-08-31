import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:musicoo/controll/musicController.dart';
import 'package:musicoo/view/widget/customButton.dart';
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

    Provider.of<musicController>(context, listen: false)
        .fetchFavourite()
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  bool isLoading = true;
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
        child: isLoading
            ? CircularProgressIndicator(
                color: Colors.white.withOpacity(0.7),
              )
            : Container(
                height: deviceSize.height * 0.6,
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: 3,
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
