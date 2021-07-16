//@dart=2.9

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color mainColor;
  final Color borderColor;
  final Function onpress;

  CustomButton({this.text, this.mainColor, this.borderColor, this.onpress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          color: mainColor,
          borderRadius: BorderRadius.circular(16),
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: TextStyle(fontFamily: 'Dancing', color: borderColor),
          ),
        ),
      ),
    );
  }
}
