import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ColorsManager {
  static const Color green =Color(0xff00795D);
  static const Color lightgray =Color(0xff1E1E1E);
  static const Color white =Color(0xffFFFFFF);
  static const Color lightgreen =Color(0xff00DFAB);
  static const Color red =Color(0xffF90505);
  static const Color gray =Color(0xff939393);
  static const Color darkGray =Color(0xff727272);
  static const Color exlightgray =Color(0xffE0E0E0);
  static const Color lightwhite =Color(0xffF6F6F6);
  static const Color lightBlack =Color(0xff2D2D2D);
  static const Color darkWhite =Color(0xffe0e0e0c2);
  static const Color col =Color(0xff00000040);
  static const Color darkgreen =Color(0xFF1a6b50);
  static const Color darkwhite =Color(0xFFF0F0F0);

  static Color background(BuildContext context) =>
      Theme.of(context).scaffoldBackgroundColor;

  static Color textPrimary(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  static Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.surface;
}