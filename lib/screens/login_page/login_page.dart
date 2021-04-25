import 'package:esaip_agenda_flutter/services/api.dart';
import 'package:esaip_agenda_flutter/shared/Components/my_button.dart';
import 'package:esaip_agenda_flutter/shared/Components/my_text_field.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = "", _password = "", _errorText = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  "Agenda ESAIP",
                  style: TextStyle(
                      fontFamily: FONT_NUNITO,
                      fontSize: 26,
                      color: COLOR_GREY,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      "Connexion avec Alcuin",
                      style: TextStyle(
                        fontFamily: FONT_NUNITO,
                        fontSize: 22,
                        color: COLOR_GREY,
                      ),
                    ),
                    SizedBox(height: 30),
                    MyTextField(
                        icon: Icon(FontAwesomeIcons.user),
                        hint: "pnom.ing2025",
                        validator:  (String? value) {},
                        onSaved: (inputEmail) => _username = inputEmail!
                    ),
                    SizedBox(height: 15),
                    MyTextField(
                        obsecure: true,
                        icon: Icon(FontAwesomeIcons.lock),
                        hint: "mot de passe",
                        validator:  (String? value) {},
                        onSaved: (inputPassword) => _password = inputPassword!
                    ),
                    SizedBox(height: 15),
                    Text(_errorText, style: TextStyle(color: Colors.red))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: MyButton(
                  text: 'Se connecter',
                  colorBorder: COLOR_GREY,
                  colorButton: COLOR_WHITE,
                  colorText: COLOR_GREY,
                  colorOverlay: COLOR_GREY.withOpacity(0.25),
                  onPressed: (){
                    setState(() {
                      _errorText = "";
                    });
                    _showMyDialog(context);
                  },
                  colorShadow: Colors.transparent,
                ),
              ),
              Container(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext ctx) {
        login(_username, _password).then((value) {
          Navigator.pop(ctx);
          if (value) {
            Navigator.of(context).popAndPushNamed('/home');
          } else {
            setState(() {
              _errorText = "Utilisateur ou mot de passe incorrect";
            });
          }
        });
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentTextStyle: TextStyle(
            fontFamily: FONT_NUNITO,
            color: COLOR_GREY,
            fontSize: 18,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Patiente pendant le premier chargement de ton agenda.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FONT_NUNITO,
                  ),
                ),
                JumpingDotsProgressIndicator(
                  fontSize: 40,
                  milliseconds: 400,
                  dotSpacing: 3,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
