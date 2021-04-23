class ImageConstants {
  static ImageConstants? _instance;
  static ImageConstants get instance => _instance ??= ImageConstants._init();

  ImageConstants._init();

  String get avatarLenin => toJpg('lenin');
  String get avatarMKA => toJpg('mka');
  String get avatarMarx => toJpg('marx');
  String get avatarGandhi => toJpg('gandhi');
  String get avatarStalin => toJpg('jstalin');
  String get avatarMandela => toJpg('mandela');

  String toJpg(String name) => 'assets/images/$name.jpg';
}
