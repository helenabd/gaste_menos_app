import 'package:flutter/material.dart';

import '../ui.dart';

class Button extends StatelessWidget {
  const Button({
    Key key,
    @required this.totalWidth,
    @required this.buttonText,
    @required this.onPressed,
  }) : super(key: key);

  final double totalWidth;
  final String buttonText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: totalWidth,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(kColorPurple),
          overlayColor: MaterialStateProperty.all<Color>(kColorDarkPurple),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: kFontSizeXS,
            fontWeight: kFontWeightBold,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
