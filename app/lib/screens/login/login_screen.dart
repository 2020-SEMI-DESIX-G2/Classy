
import 'package:classy/bloc/login/login_bloc.dart';
import 'package:classy/screens/login/login_form.dart';
import 'package:classy/utils/constant.dart';
import 'package:classy/utils/size_config.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  final LoginBloc bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
        body: Column(
        children: <Widget>[
          _welcomeTextContainer()
        ],
      ),
    );
  }

  _welcomeTextContainer() {

    return Container(
      margin: EdgeInsets.only(left: SizeConfig.screenWidth * 14.9333333333 / 100, top: (SizeConfig.screenHeight * 7.1428571429 / 100 + SizeConfig.paddingTop)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Bienvenido',
            style: TextStyle(
              color: Colors.black,
              fontFamily: CLASSY_FONT,
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.8620689655 / 100,
          ),
          Text(
            'Inicia sesión para continuar',
            style: TextStyle(
              color: Color(0xFF909090),
              fontFamily: CLASSY_FONT,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          LoginForm(
            bloc: this.bloc,
          )
        ],
      ),
    );
  }
}