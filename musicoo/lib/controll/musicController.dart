import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:musicoo/controll/sqfliteHelper.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
class musicController extends ChangeNotifier
{
  static List<SongModel> songs=[];
  late SongModel currentSong;

 static bool loadedSongQue=false;

  setSong(SongModel song)
  {
    currentSong=song;
    notifyListeners();
  }
final OnAudioQuery _audioQuery = OnAudioQuery();
  fetchSongs()async
  {
    
    List<SongModel> audios=await _audioQuery.querySongs(sortType: SongSortType.DATE_ADDED,orderType: OrderType.DESC_OR_GREATER);

      songs=audios.where((element) {
        return element.fileExtension=='mp3';
      }).toList();
      
     randomSong();
  }
  
Future <List<Uint8List?>> fetchArtList()async
{
  print("start list.........................");
  print(randSong.length);
  List<Uint8List?>res=[];
  
  var p0=await fetchSongArtWork(randSong[0].id);
  res.add(p0);
  var p1=await fetchSongArtWork(randSong[1].id);
  res.add(p1);
  var p2=await fetchSongArtWork(randSong[2].id);
  res.add(p2);
  var p3=await fetchSongArtWork(randSong[3].id);
  res.add(p3);
  var p4=await fetchSongArtWork(randSong[4].id);
  res.add(p4);

       
   
  print("size is.......... ");
  print(res.length);
  return res;
}
static List<SongModel> randSong=[];
randomSong()
{
  
  var rand=Random();
  for(int i=0;i<5;i++)
  {
    randSong.add(songs[rand.nextInt(songs.length)]);
  }
 

}



  Future<Uint8List?> fetchSongArtWork(int songId)async
  {
    
  Uint8List? res= await  _audioQuery.queryArtwork(songId, ArtworkType.AUDIO);
  return res;

  }

  requestPermission()async
  {
    var storagePermission=Permission.storage;
    bool isGranted=await storagePermission.isGranted;
    bool isGranted2=await Permission.accessMediaLocation.isGranted;
    print(isGranted2);
    print(isGranted);
    if(isGranted)
      {
return;
      }
    else
      {
        await Permission.storage.request();
        await Permission.accessMediaLocation.request();
        Permission.audio.request();

      }

  }

  List<SongModel>searchSong(String ch)
  {
    
    var searchedSong= songs.where((element) => element.title.toUpperCase().contains(ch.toUpperCase())).toList();
  
  if(searchedSong.length>10)
  {
    return searchedSong.sublist(0,10);
  }
  else
  {
    return searchedSong;
  }
  
  }



  

 static List<SongModel> favouritrIdSong=[];
  

Future<void>insertSong(SongModel song)async
{
var res = await sqlHelper().insertDb("INSERT INTO favouritesongs VALUES (${song.id});");
favouritrIdSong.add(song);
print(res);
notifyListeners();
}
Future<void>deleteSong(SongModel song)async
{
sqlHelper().deleteDb("DELETE FROM favouritesongs WHERE songid=${song.id};");
favouritrIdSong.remove(song);
notifyListeners();
}
Future fetchFavourite()async
{
 List<Map> res=await sqlHelper().selectDb("SELECT * FROM favouritesongs; ");

  res.forEach((element) {
    SongModel favsong= songs.firstWhere((so) =>so.id==int.parse(element['songid']) );
    favouritrIdSong.add(favsong);
  });
//print(favouritrIdSong.toString());
 
}
bool isFavourite(SongModel song)
{
  return favouritrIdSong.contains(song);
}


  //--------------------------------------------------------------
 /* var audioPlayer=AudioPlayer();
  
  
  loadSongs()
  {
    var allSongs=ConcatenatingAudioSource(children: []);
  }
  
  playSong()
  {
    audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(currentSong.uri!),));
    audioPlayer.play();
    //audioHundler!.play();
    notifyListeners();

  }
  pauseSong()
  {
    audioPlayer.pause();
    notifyListeners();
  }
  contiueSong()
  {
    audioPlayer.play();
    notifyListeners();
  }
  bool isPlaying()
  {
   return audioPlayer.playing;
  }
  nextSong()
  {
    
int currSongIndex=songs.indexOf(currentSong);
print(currSongIndex);
currSongIndex+=1;
currentSong=songs[currSongIndex];
playSong();
notifyListeners();

  }
  previousSong()
  {
int currSongIndex=songs.indexOf(currentSong);
print(currSongIndex);
currSongIndex-=1;
currentSong=songs[currSongIndex];
playSong();
notifyListeners();
  }

  seekSong(Duration pos)
  {
    audioPlayer.seek(pos);
  }*/

}