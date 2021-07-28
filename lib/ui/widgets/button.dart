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
    Color backgroundDisabledColor = Colors.grey;
    return Container(
      height: 56,
      width: totalWidth,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) return kColorPurple;
            if (states.contains(MaterialState.disabled)) {
              Color disabledColor = backgroundDisabledColor;
              if (backgroundDisabledColor == null) {
                disabledColor = kColorPurple.withOpacity(0.5);
              }

              return disabledColor;
            }

            return kColorPurple;
          }),
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
