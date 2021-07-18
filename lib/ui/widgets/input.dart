import 'package:flutter/material.dart';

import '../ui.dart';

class Input extends StatelessWidget {
  const Input({
    Key key,
    @required this.hintText,
    @required this.textInputType,
    @required this.onChanged,
  }) : super(key: key);

  final String hintText;
  final TextInputType textInputType;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        cursorColor: kColorPurple,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kColorGrey, width: 2.0),
          ),
        ),
        keyboardType: textInputType,
        onChanged: onChanged,
      ),
    );
  }
}
