import 'package:android_content_provider/android_content_provider.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:musicoo/controll/musicController.dart';
import 'package:musicoo/main.dart';
import 'package:musicoo/view/screens/favouriteScreen.dart';
import 'package:musicoo/view/screens/searchScreen.dart';
import 'package:musicoo/view/screens/songsScreen.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:musicoo/view/widget/favouriteCard.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class mainScreen extends StatefulWidget {
  mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  final randsong = musicController.randSong;

  bool isloading = true;

  @override
  void initState() {
    List<SongModel> songs = musicController.songs;
    if (!musicController.loadedSongQue) {
      myHandler.addQueueItems(songs.map((e) {
        return MediaItem(
          id: e.uri!,
          title: e.title,
          duration: Duration(milliseconds: e.duration!),
          artUri: Uri.parse(
              "content://media/external/audio/media/${e.id}/albumart"),
          
        );
      }).toList());

      musicController.loadedSongQue = true;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    double itemRatio = (((deviceSize.height / 3) * 2) - 20) / 2;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: GridView(
                    padding: EdgeInsets.only(top: 12, left: 10, right: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        mainAxisExtent: itemRatio),
                    children: [
                      itemContainer(
                        color: Colors.pink,
                        icon: Icon(
                          Icons.music_note,
                          color: Colors.purple,
                        ),
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      SlideTransition(
                                          child: songsScreen(),
                                          position: Tween<Offset>(
                                                  begin: Offset(1, 0),
                                                  end: Offset(0, 0))
                                              .animate(animation))));
                        },
                        text: "All Songs",
                      ),
                      itemContainer(
                        color: Colors.blue,
                        icon: Icon(
                          Icons.search,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      SlideTransition(
                                          child: searchScreen(),
                                          position: Tween<Offset>(
                                                  begin: Offset(1, 0),
                                                  end: Offset(0, 0))
                                              .animate(animation))));
                        },
                        text: 'Search',
                      ),
                      itemContainer(
                        color: Colors.black,
                        icon: Icon(Icons.queue_music),
                        onTap: () {},
                        text: 'Play List',
                      ),
                      itemContainer(
                        color: Colors.purple,
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      SlideTransition(
                                          child: favouriteScreen(),
                                          position: Tween<Offset>(
                                                  begin: Offset(1, 0),
                                                  end: Offset(0, 0))
                                              .animate(animation))));
                        },
                        text: 'Favorite',
                      )
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: FutureBuilder(
                    future: musicController().fetchArtList(),
                    builder: (context, snapshot) => !snapshot.hasData
                        ? Center(child: CircularProgressIndicator())
                        : Swiper.list(
                            itemHeight: (deviceSize.height * 0.3),
                            itemWidth: deviceSize.width * 0.60,
                            layout: SwiperLayout.STACK,
                            list: randsong,
                            builder: (context, data, index) => favouriteCard(
                                song: data, preimage: snapshot.data![index]),
                          ),
                  ))
            ],
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/a.jpg'), fit: BoxFit.cover)),
      ),
    );
  }
}

class itemContainer extends StatelessWidget {
  itemContainer(
      {required String this.text,
      required Icon this.icon,
      required Color this.color,
      required void Function()? this.onTap,
      super.key});
  String text;
  Icon icon;
  void Function()? onTap;
  Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(0.4), color.withOpacity(0.0)]),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [icon, Text(text)],
        ),
      ).asGlass(tintColor: color, clipBorderRadius: BorderRadius.circular(15),blurX: 5,blurY: 5),
    );
  }
}
