import 'package:esaip_agenda_flutter/screens/login_page/login_page.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda ESAIP',
      theme: ThemeData(
        accentColor: COLOR_GREY,
        highlightColor: COLOR_GREY.withOpacity(0.25),
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(body: LoginPage()),
    );
  }
}
