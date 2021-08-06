import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gaste_menos_app/domain/domain.dart';
import 'package:gaste_menos_app/ui/ui.dart';
import 'package:gaste_menos_app/data/data.dart';
import 'package:gaste_menos_app/services/services.dart';

import 'components/components.dart';

class LoginBody extends StatefulWidget with EmailAndPasswordValidators {
  final EmailSignInBloc bloc;
  LoginBody({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => LoginBody(
          bloc: bloc,
        ),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    print('dispose close');
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await widget.bloc.submit();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );
    }
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = widget.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 6),
              Logo(),
              Spacer(flex: 3),
              UsernameField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                errorText: model.emailErrorText,
                onChanged: widget.bloc.updateEmail,
                onEditingComplete: () => _emailEditingComplete(model),
              ),
              Spacer(flex: 2),
              PasswordField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                errorText: model.passwordErrorText,
                onChanged: widget.bloc.updatePassword,
                onEditingComplete: _submit,
              ),
              Spacer(flex: 2),
              LoginButton(
                text: model.primaryButtonText,
                onPressed: model.canSubmit ? _submit : null,
              ),
              Spacer(flex: 3),
              TextButton(
                child: Text(
                  model.secundaryButtonText,
                  style: TextStyle(
                    color: kColorDarkPurple,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: !model.isLoading ? _toggleFormType : null,
              ),
              Spacer(flex: 16),
            ],
          );
        });
  }
}
