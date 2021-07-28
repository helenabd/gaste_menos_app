import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gaste_menos_app/services/services.dart';

class LoginBloc {
  final AuthBase auth;

  LoginBloc({
    @required this.auth,
  });

  final StreamController<bool> _isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose() {
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<User> _signIn(Future<User> Function() signInMathod) async {
    try {
      _setIsLoading(true);
      return await signInMathod();
    } catch (e) {
      _setIsLoading(false);
      rethrow;
    }
  }
}
