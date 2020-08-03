
import 'dart:async';

import 'package:classy/models/requests/register.dart';
import 'package:classy/models/responses/base_response.dart';
import 'package:classy/provider/provider_client.dart';
import 'package:classy/screens/register/choice.dart';
import 'package:classy/utils/constant.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class RegisterBloc {

  final RegisterRequest request = RegisterRequest();
  final ProviderClient client = ProviderClient();
  final BehaviorSubject _usernameController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  final BehaviorSubject _emailController = BehaviorSubject<String>();
  final BehaviorSubject _confirmPasswordController = BehaviorSubject<String>();
  final BehaviorSubject _passwordValidations = BehaviorSubject<int>();
  final PublishSubject _loadingData = PublishSubject<bool>();
  final BehaviorSubject _preferencesController = BehaviorSubject<List<Choice>>();

  Function(void) get addPreferences => _preferencesController.sink.add;

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeConfirmPassword => _confirmPasswordController.sink.add;

  void changePreferences(int index, bool selected) {

    //for (Choice place in _preferencesController.value) {
    //  place.selected = false;
    //}
    _preferencesController.value[index].selected = selected;
    addPreferences(_preferencesController.value);
  }

  Stream<String> get username => _usernameController.stream.transform(validateUserName);
  ValueStream<int> get passwordValidation => _passwordValidations.stream;
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<List<Choice>> get preferences => _preferencesController.stream.transform(validateChoices).doOnData(getActiveChoices);
  Stream<bool> get loading => _loadingData.stream;

  final validateChoices = StreamTransformer<List<Choice>, List<Choice>>.fromHandlers(
      handleData: (List<Choice> choices, sink) {
        sink.add(choices);
      }
  );

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (String email, sink) {
        if (RegExp(EMAIL_EXPRESSION).hasMatch(email)) {

          sink.add(email);
        } else if(email == '') {
          sink.addError(REQUIRED_FIELD);
        } else {
          sink.addError('Correo inválido');
        }
      }
  );

  void getActiveChoices(List<Choice> choices) {

    for (Choice choice in choices) {

      if (choice.selected) {

        if (!request.preferencias.contains(choice.value)) {
          request.preferencias.add(choice.value);
        }
      } else {

        if (request.preferencias.contains(choice.value)) {
          request.preferencias.remove(choice.value);
        }
      }
    }
  }
  
  final validateUserName = StreamTransformer<String, String>.fromHandlers(
      handleData: (String name, sink) {
        if (RegExp(USERNAME_REGEX).hasMatch(name) && name.length > 3) {
          sink.add(name);
        } else if(name == '') {
          sink.addError(REQUIRED_FIELD);

        } else {
          sink.addError('No válido');
        }
      }
  );

  Stream<String> get password => _passwordController.stream.transform(validatePassword).doOnEach((notification) {

    if (notification.isOnData || notification.isOnError) {

      if (notification.value != null) {
        if (notification.value.length > 7) {
          if (RegExp(PASSWORD_CREATION_EXPRESSION).hasMatch(notification.value)) {

            //registerUserRequest.user.password = notification.value;
            _passwordValidations.sink.add(3);
          } else {
            _passwordValidations.sink.add(1);
          }
        } else if (RegExp(PASSWORD_CREATION_EXPRESSION).hasMatch(notification.value) && notification.value.isNotEmpty) {
          _passwordValidations.sink.add(2);
        }
      } else {
        _passwordValidations.sink.add(0);
      }
    }
  });

    Stream<String> get confirmPassword =>
      _confirmPasswordController.stream.transform(validatePassword)
          .doOnData((String password){
        if (0 != _passwordController.value.compareTo(password)){
          _confirmPasswordController.addError("Contraseñas no coinciden.");
        }
      });

  Stream<bool> get nextButton => CombineLatestStream([username, password, confirmPassword],
        (values) {

      if ((_passwordValidations.value == 3 && values[1] == values[2])) {
        return true;
      }

      return false;
    });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (String name, sink) {
        sink.add(name);
    }
  );

  submit() async {

    _loadingData.sink.add(true);
    request.usuario = _usernameController.stream.value;
    request.contrasena = _passwordController.stream.value;
    request.email = _emailController.stream.value;

    BaseResponse response = await client.post(request, 'register/');
    _loadingData.sink.add(false);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  
  void dispose() {
    _emailController.close();
    _preferencesController.close();
    _usernameController.close();
    _passwordController.close();
    _confirmPasswordController.close();
    _passwordValidations.close();
    _loadingData.close();
  }
}
