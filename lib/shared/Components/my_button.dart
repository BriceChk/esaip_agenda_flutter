import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color colorBorder;
  final Color colorButton;
  final Color colorText;
  final Color colorOverlay;
  final double borderWidth;
  final GestureTapCallback? onPressed;
  final Color colorShadow;

  MyButton({required this.text, required this.colorBorder, required this.colorButton, required this.colorText,
    required this.colorOverlay, required this.onPressed, this.borderWidth = 2, required this.colorShadow});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          overlayColor: MaterialStateProperty.all<Color>(colorOverlay),
          backgroundColor: MaterialStateProperty.all<Color>(colorButton),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(
                color: colorBorder,
                width: borderWidth,
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: FittedBox(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontFamily: FONT_NUNITO,
                color: colorText,
                letterSpacing: 0.25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
