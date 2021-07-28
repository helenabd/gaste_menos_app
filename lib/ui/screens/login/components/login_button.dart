import 'package:flutter/material.dart';
import 'package:gaste_menos_app/domain/domain.dart';

import '../../../ui.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const LoginButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalWidth = Utils.totalWidth(context: context);

    return Container(
        child: Button(
      totalWidth: totalWidth,
      buttonText: text,
      onPressed: onPressed,
    ));
  }
}
