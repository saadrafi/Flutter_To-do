// @dart=2.9

import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String title;
  final String subTitle;

  AppBarTitle({this.subTitle, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: subTitle,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
