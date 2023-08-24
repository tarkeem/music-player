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
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 20,
      child: Container(
        child: IconButton(onPressed: onPressed, icon: icon),
      ).asGlass(clipBorderRadius: BorderRadius.circular(30)),
    );
  }
}