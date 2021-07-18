import 'package:flutter/material.dart';

import '../../../ui.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
    @required this.totalWidth,
  }) : super(key: key);

  final double totalWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Button(
      totalWidth: totalWidth,
      buttonText: 'Entrar',
      onPressed: () {},
    ));
  }
}
