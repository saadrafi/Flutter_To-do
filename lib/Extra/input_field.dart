// @dart = 2.9
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final IconData leadIcon;
  final IconButton sufixIcon;
  final Function userTyped;
  final bool obsecure;
  final TextInputType keyboard;
  final TextEditingController textEditingController;

  InputField(
      {this.hintText,
      this.keyboard,
      this.leadIcon,
      this.sufixIcon,
      this.obsecure,
        @required this.textEditingController,
      this.userTyped});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width * 0.80,
      child: TextField(
        controller: textEditingController,
        onChanged: userTyped,
        keyboardType: keyboard,
        onSubmitted: (value) {},
        autofocus: false,
        obscureText: obsecure,
        decoration: InputDecoration(
          icon: Icon(
            leadIcon,
            color: Colors.deepPurple,
          ),
          border: InputBorder.none,
          hintText: hintText,
          suffixIcon: sufixIcon,
        ),
      ),
    );
  }
}
