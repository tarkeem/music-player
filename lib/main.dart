
import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:musicoo/controll/musicController.dart';
import 'package:musicoo/controll/sqfliteHelper.dart';
import 'package:musicoo/service/audioServices.dart';
import 'package:musicoo/view/screens/favouriteScreen.dart';
import 'package:musicoo/view/screens/mainScreen.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';


/*

to solve the problem of path_provider_android
open thef ile  path_provider and build gradle and  make the
dependencies cosistent


*/

// You might want to provide this using dependency injection rather than a
// global variable.
late AudioHandler myHandler;
Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await musicController().requestPermission();
 await sqlHelper().initiateDb();
 await musicController().fetchSongs();
 
myHandler= await initAudioService();
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
create: (context) =>musicController() ,
      builder:(context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Audio Service Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home:mainScreen(),
      ),
    );
  }
}


