import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ui/pages/main/main_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  App() {

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Food',
      home: MainPage(
        
      ),
    );
  }
}
