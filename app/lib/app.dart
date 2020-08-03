import 'package:classy/bloc/authorization/authorization_bloc.dart';
import 'package:classy/screens/dashboard/dashboard_screen.dart';
import 'package:classy/screens/home/home_screen.dart';
import 'package:classy/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';


class App extends StatelessWidget  {

  @override
  Widget build(BuildContext context) {

    authBloc.restoreSession();
    return createContent();
  }

  createContent() {
    return StreamBuilder<String> (
    stream: authBloc.isSessionValid,
    builder: (context, AsyncSnapshot<String> snapshot){
      if (snapshot.hasData && snapshot.data == 'HOME') {
        return HomeScreen();
      }

      return OnboardingScreen();
    });
  }
}

