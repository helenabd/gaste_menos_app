import 'package:flutter/material.dart';
import 'package:gaste_menos_app/data/data.dart';
import 'package:gaste_menos_app/domain/domain.dart';
import 'package:gaste_menos_app/services/services.dart';
import 'package:provider/provider.dart';

import '../../../services/services.dart';
import 'login_body.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  final LoginBloc bloc;

  const LoginScreen({@required this.bloc});

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<LoginBloc>(
      create: (_) => LoginBloc(auth: auth),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<LoginBloc>(
        builder: (_, bloc, __) => LoginScreen(bloc: bloc),
      ),
    );
  }

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
        child: LoginBody.create(context),
      )),
    );
  }
}
