// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AssetURL {
  static final AssetURL _instance = AssetURL._init();
  static AssetURL get instance => _instance;

  AssetURL._init();

  String get background => pathImageValue("background.jpg");

  String pathIconValue(String name) => 'assets/icons/$name';
  String pathImageValue(String name) => 'assets/images/$name';
}

extension AssetWidget on String {
  toImageWidget({double? height, double? width, Color? color}) => Image.asset(
        this,
        width: width,
        height: height,
        color: color,
      );
  toIconWidget({double? height, double? width, Color? color}) =>
      Image.asset(this, width: width, height: height);
}
