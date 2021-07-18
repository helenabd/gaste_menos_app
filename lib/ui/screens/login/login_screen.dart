import 'package:flutter/material.dart';
import 'package:gaste_menos_app/domain/domain.dart';

import 'components/components.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    final totalHeight = Utils.totalHeight(context: context);
    final totalWidth = Utils.totalWidth(context: context);
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: totalHeight,
        width: totalWidth,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 6),
            Logo(),
            SizedBox(
              height: 20,
            ),
            LoginTitle(),
            Spacer(flex: 3),
            UsernameField(),
            Spacer(flex: 2),
            PasswordField(),
            Spacer(flex: 2),
            LoginButton(totalWidth: totalWidth),
            Spacer(flex: 3),
            ForgotPassword(),
            Spacer(flex: 16),
          ],
        ),
      )),
    );
  }
}
