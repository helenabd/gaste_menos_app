import 'package:flutter/material.dart';

import '../../../ui.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {},
          child: Text(
            "Recuperar senha",
            style: TextStyle(
              color: kColorDarkPurple,
              fontSize: kFontSizeXXS,
            ),
          ),
        ),
      ),
    );
  }
}
