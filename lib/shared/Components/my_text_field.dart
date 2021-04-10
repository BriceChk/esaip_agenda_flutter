import 'package:esaip_agenda_flutter/shared/constants.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  //constructor
  MyTextField(
      {required this.icon,
        required this.hint,
        this.obsecure = false,
        required this.validator,
        required this.onSaved,
        this.controller,
        this.focusNode,
      });

  //variables
  final FormFieldSetter<String> onSaved;
  final Icon icon;
  final String hint;
  final bool obsecure;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onSaved,
        autofocus: false,
        obscureText: obsecure,
        style: TextStyle(
            fontSize: 14,
            color: COLOR_GREY,
        ),
        decoration: InputDecoration(
            fillColor: COLOR_WHITE_GREY,
            filled: true,
            hintStyle: TextStyle(
                fontSize: 16,
                color: COLOR_GREY
            ),
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: COLOR_WHITE_GREY,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: COLOR_WHITE_GREY,
                width: 3,
              ),
            ),
            focusedBorder:OutlineInputBorder(
              borderSide: BorderSide(
                  color: COLOR_WHITE_GREY,
                  width: 2.0
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            prefixIcon: Padding(
              child: IconTheme(
                data: IconThemeData(color: COLOR_GREY),
                child: icon,
              ),
              padding: EdgeInsets.only(left: 30, right: 10),
            )),
      ),
    );
  }
}