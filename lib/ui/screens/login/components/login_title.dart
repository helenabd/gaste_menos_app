import 'package:flutter/material.dart';

import '../../../ui.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Gaste Menos',
        style: TextStyle(
          color: kColorPurple,
          fontSize: kFontSizeXL,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
