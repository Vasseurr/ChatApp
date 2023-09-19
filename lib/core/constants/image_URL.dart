// ignore_for_file: file_names

class ImageURL {
  static final ImageURL _instance = ImageURL._init();
  static ImageURL get instance => _instance;

  ImageURL._init();

  String get profilePhoto =>
      "https://wallpapers.com/images/featured/4co57dtwk64fb7lv.jpg";
}
