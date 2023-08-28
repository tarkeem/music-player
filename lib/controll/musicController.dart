import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicoo/main.dart';
import 'package:musicoo/service/audioServices.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
class musicController extends ChangeNotifier
{
  static List<SongModel> songs=[];
  late SongModel currentSong;

  setSong(SongModel song)
  {
    currentSong=song;
    notifyListeners();
  }


  fetchSongs()async
  {
    final OnAudioQuery _audioQuery = OnAudioQuery();
    List<SongModel> audios=await _audioQuery.querySongs();

      songs=audios.where((element) {
        return element.fileExtension=='mp3';
      }).toList();
      print(songs.length);

      setSong(songs[2]);
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
    
    var searchedSong= songs.where((element) => element.title.toUpperCase().startsWith(ch.toUpperCase())).toList();
  
  if(searchedSong.length>10)
  {
    return searchedSong.sublist(0,10);
  }
  else
  {
    return searchedSong;
  }
  
  }
  //--------------------------------------------------------------
  var audioPlayer=AudioPlayer();
  
  
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
  }

}