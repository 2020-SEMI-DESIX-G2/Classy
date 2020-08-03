
import 'dart:async';

import 'package:classy/bloc/authorization/authorization_bloc.dart';
import 'package:classy/models/requests/login.dart';
import 'package:classy/models/responses/base_response.dart';
import 'package:classy/provider/provider_client.dart';
import 'package:classy/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc {

  final LoginRequest request = LoginRequest();
  final ProviderClient client = ProviderClient();

  final BehaviorSubject _usernameController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  final BehaviorSubject _errorLabel = BehaviorSubject<bool>();
  final PublishSubject _loadingData = PublishSubject<bool>();

  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get username => _usernameController.stream.transform(validateUsername);

  Stream<String> get password => _passwordController.stream.transform(validatePassword);

  Stream<bool> get loading => _loadingData.stream;

  ValueStream<bool> get errorLabel => _errorLabel.stream;

  final validateUsername = StreamTransformer<String, String>.fromHandlers(
    handleData: (String username, sink) {
      if (RegExp(USERNAME_REGEX).hasMatch(username)) {
        sink.add(username);
      } else {
        sink.addError('Contraseña no admitida');
      }
    }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (String password, sink) {
      //if (RegExp(PASSWORD_CREATION_EXPRESSION).hasMatch(password)) {
        sink.add(password);
      //} else {
      //  sink.addError(INVALID_PASSWORD);
      //}
    }
  );

  Stream<bool> get submitValid => CombineLatestStream.combine2<String, String, bool>(username, password,
    (_username, _password) {
    if (_username == _usernameController.value && _password == _passwordController.value) {
      _errorLabel.add(true);
      return true;
    } else
      return false;
    }
  );

  Future<bool> submit(context) async {

    request.usuario = _usernameController.stream.value;
    request.contrasena = _passwordController.stream.value;
    _loadingData.sink.add(true);

    BaseResponse response = await client.post(request, 'login/');

    _loadingData.sink.add(false);
    if (response.statusCode == 200) {

      Navigator.popUntil(context, ModalRoute.withName('/'));
      authBloc.openSession(" ", response.payload);

      return true;
    } else {
      return false;
    }
  }
  
  void dispose() {
    _usernameController.close();
    _passwordController.close();
    _loadingData.close();
    _errorLabel.close();
  }
}