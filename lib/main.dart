import 'package:esaip_agenda_flutter/screens/home_page/home_page.dart';
import 'package:esaip_agenda_flutter/screens/loading_page.dart';
import 'package:esaip_agenda_flutter/screens/login_page/login_page.dart';
import 'package:esaip_agenda_flutter/screens/menu/grade_page.dart';
import 'package:esaip_agenda_flutter/services/api.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:time_machine/time_machine.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await TimeMachine.initialize({'rootBundle': rootBundle});
  Culture.current = (await Cultures.getCulture('fr'))!;
  await initializeDateFormatting('fr_FR', null);

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: COLOR_WHITE
    ));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agenda ESAIP',
        theme: ThemeData(
          accentColor: COLOR_GREY.withOpacity(0.5),
          //highlightColor: COLOR_GREY.withOpacity(0.25),
          highlightColor: Colors.transparent,
          primarySwatch: Colors.grey,
          dividerColor: Colors.transparent
        ),
        home: FutureBuilder(
          future: getStatus(),
          builder: (context, snapshot) {
            Widget child;
            if (snapshot.connectionState == ConnectionState.waiting) {
              child = LoadingPage();
            } else {
              if (snapshot.hasData && snapshot.data as bool) {
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
          '/notes': (BuildContext context) => GradePage(),
        }
    );
  }
}
