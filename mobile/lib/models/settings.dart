class Settings {

  static final Settings _singleton = Settings._internal();
  
  Settings._internal();

  factory Settings() {
    return _singleton;
  }

  int age = 18;
  int weight = 75;
  int height = 175;

  Set<String> gender = Set();
  Set<String> restrictions = Set();

}