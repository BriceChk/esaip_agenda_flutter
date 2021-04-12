import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 200,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(height: 30,),
              Text(
                'Chargement en cours',
                style: TextStyle(
                    color: COLOR_GREY,
                    fontSize: 30,
                    fontFamily: 'Nunito'
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
