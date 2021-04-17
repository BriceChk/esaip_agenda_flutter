//@dart=2.9

import 'package:esaip_agenda_flutter/screens/home_page/home_page.dart';
import 'package:esaip_agenda_flutter/screens/loading_page.dart';
import 'package:esaip_agenda_flutter/screens/login_page/login_page.dart';
import 'package:esaip_agenda_flutter/services/auth_service.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_machine/time_machine.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await TimeMachine.initialize({'rootBundle': rootBundle});

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget home = LoadingPage();

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
        home: FutureBuilder(
          future: getStatus(),
          builder: (context, snapshot) {
            Widget child;
            if (snapshot.connectionState == ConnectionState.waiting) {
              child = LoadingPage();
            } else {
              if (snapshot.data) {
                child = HomePage();
              } else {
                child = LoginPage();
              }
            }
            return child;
          },
        ),
        routes: <String, WidgetBuilder> {
          '/loading': (BuildContext context) => LoadingPage(),
          '/login': (BuildContext context) => LoginPage(),
          '/home': (BuildContext context) => HomePage(),
        }

    );
  }
}
