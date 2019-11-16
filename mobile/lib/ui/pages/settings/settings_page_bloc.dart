import 'package:mobile/models/settings.dart';
import 'package:rxdart/rxdart.dart';

class SettingsPageBloc {

  final settings = Settings();
  final changed = BehaviorSubject<bool>();

  void notify() {
    changed.sink.add(true);
  }


}