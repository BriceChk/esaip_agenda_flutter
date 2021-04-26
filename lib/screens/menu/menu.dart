import 'package:esaip_agenda_flutter/shared/Components/my_button.dart';
import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_WHITE,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: COLOR_WHITE,
        title: Text(
          'Menu',
          style: TextStyle(
            fontFamily: FONT_NUNITO,
            color: COLOR_GREY,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: MyButton(
                  borderWidth: 1,
                  text: "Notes",
                  colorBorder: COLOR_GREY,
                  colorButton: COLOR_WHITE,
                  colorText: COLOR_GREY,
                  colorOverlay: COLOR_WHITE_GREY,
                  onPressed: () {
                    Navigator.pushNamed(context, '/notes');
                  },
                  colorShadow: COLOR_WHITE),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: MyButton(
                  borderWidth: 1,
                  text: "Informations de licence",
                  colorBorder: COLOR_GREY,
                  colorButton: COLOR_WHITE,
                  colorText: COLOR_GREY,
                  colorOverlay: COLOR_WHITE_GREY,
                  onPressed: () {
                    showLicensePage(
                        context: context,
                      applicationName: 'Agenda ESAIP',
                      applicationIcon: Image.asset('assets/images/logo.png')
                    );
                  },
                  colorShadow: COLOR_WHITE),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: MyButton(
                  borderWidth: 1,
                  text: "Supprimer mes données",
                  colorBorder: COLOR_RED_CARD_BUTTON,
                  colorButton: COLOR_WHITE,
                  colorText: COLOR_RED_CARD_BUTTON,
                  colorOverlay: COLOR_RED_CARD.withOpacity(0.25),
                  onPressed: () {
                    _showMyDialog(context);
                  },
                  colorShadow: COLOR_WHITE),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: MyButton(
                  borderWidth: 1,
                  text: "Déconnexion",
                  colorBorder: COLOR_GREY,
                  colorButton: COLOR_WHITE,
                  colorText: COLOR_GREY,
                  colorOverlay: COLOR_WHITE_GREY,
                  onPressed: () {
                    Requests.clearStoredCookies('agenda-esaip.bricechk.fr:443');
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  colorShadow: COLOR_WHITE),
            ),
            Expanded(
              flex: 2,
              child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Proudly made by Mickaël Bénasse & Brice Chkir",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: FONT_NUNITO,
                      color: COLOR_GREY,
                    ),
                  )
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

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Tes cours et tes notes seront supprimés',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FONT_NUNITO,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                  'Annuler',
                style: TextStyle(
                  fontSize: 16,
                  color: COLOR_GREY.withOpacity(0.8),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                  'Je suis sûr',
                style: TextStyle(
                  fontSize: 16,
                  color: COLOR_RED_CARD_BUTTON,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                //TODO Call suppression compte
                Requests.clearStoredCookies('agenda-esaip.bricechk.fr:443');
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }
}
