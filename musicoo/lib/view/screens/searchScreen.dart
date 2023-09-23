import 'package:flutter/material.dart';
import 'package:musicoo/controll/musicController.dart';
import 'package:musicoo/main.dart';
import 'package:musicoo/view/widget/soundCard.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class searchScreen extends StatefulWidget {
  const searchScreen({super.key});

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  
  List<SongModel> searchSongs=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/a.jpg'), fit: BoxFit.cover)), 
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kToolbarHeight,horizontal: 8.0),
            child: TextField(
              
              decoration: InputDecoration(hintText: "Search",suffixIcon: Icon(Icons.search),border:OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
              onChanged: (value) {
              setState(() {
                searchSongs=Provider.of<musicController>(context,listen: false).searchSong(value);
              });
            },),
          ),
          Expanded(child: ListView.builder(
            itemCount: searchSongs.length,
            itemBuilder:(context, index) => Padding(
              padding: EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  int indexso=musicController.songs.indexOf(searchSongs[index]);
                  myHandler.skipToQueueItem(indexso);
                },
                child: songCard(searchSongs[index]))) ,
          ))
        ],),
      ),
    );
  }
}