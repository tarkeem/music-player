import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:musicoo/view/widget/customButton.dart';

class favouriteScreen extends StatelessWidget {
  const favouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Card(
            elevation: 50,
            color: Colors.transparent,
            child: Container(
              child: Icon(Icons.favorite,size: 100,),
            ).asGlass(),
          ),
           Container(
            child: Icon(Icons.abc,size: 100,),
          ).asGlass(),
          customButton(icon: Icon(Icons.favorite,size: 100,), onPressed: (){})
        ],
      )
    );
  }
}
