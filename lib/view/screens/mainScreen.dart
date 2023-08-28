import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:musicoo/view/screens/favouriteScreen.dart';
import 'package:musicoo/view/screens/searchScreen.dart';
import 'package:musicoo/view/screens/songsScreen.dart';

class mainScreen extends StatelessWidget {
  const mainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    double itemRatio = (((deviceSize.height / 3) * 2) - 10) / 2;
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
                        icon: Icon(Icons.music_note),
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
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
                        icon: Icon(Icons.search),
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
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
                        icon: Icon(Icons.search),
                        onTap: () {},
                        text: 'Search',
                      ),
                      itemContainer(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        icon: Icon(Icons.favorite,color: Colors.red,),
                        onTap: () {},
                        text: 'Favourite',
                      )
                    ],
                  )),
              Expanded(flex: 1, child: Placeholder())
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
      ).asGlass(tintColor: color, clipBorderRadius: BorderRadius.circular(15)),
    );
  }
}
