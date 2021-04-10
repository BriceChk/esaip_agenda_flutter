import 'package:esaip_agenda_flutter/shared/Components/my_button.dart';
import 'package:esaip_agenda_flutter/shared/Components/my_text_field.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "", password = "";


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Agenda ESAIP",
                style: TextStyle(
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
                      fontSize: 22,
                      color: COLOR_GREY,
                    ),
                  ),
                  SizedBox(height: 30),
                  MyTextField(
                      icon: Icon(FontAwesomeIcons.user),
                      hint: "pnom.ing2025",
                      validator:  (String? value) {},
                      onSaved: (inputEmail) => email = inputEmail!
                  ),
                  SizedBox(height: 15),
                  MyTextField(
                      obsecure: true,
                      icon: Icon(FontAwesomeIcons.lock),
                      hint: "mot de passe",
                      validator:  (String? value) {},
                      onSaved: (inputPassword) => password = inputPassword!
                  ),
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
                onPressed: (){},
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
    );
  }
}
