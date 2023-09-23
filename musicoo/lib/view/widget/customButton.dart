import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
class customButton extends StatelessWidget {
  customButton(
      {required Icon this.icon,
      required void Function()? this.onPressed,
      super.key});
  Icon icon;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 20,
        child: Container(
          padding: EdgeInsets.all(20),
          child: icon,
        ).asGlass(clipBorderRadius: BorderRadius.circular(30),blurX: 3,blurY: 3),
      ),
    );
  }
}