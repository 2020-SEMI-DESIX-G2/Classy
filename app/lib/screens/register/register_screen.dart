
import 'package:classy/bloc/register/register_bloc.dart';
import 'package:classy/screens/register/register_form.dart';
import 'package:classy/utils/constant.dart';
import 'package:classy/utils/size_config.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    RegisterBloc bloc = RegisterBloc();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      body: ListView(
        children: <Widget>[
          _widgetsContainer(),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          RegisterForm(bloc: bloc)
        ],
      ),
    );
  }

  _widgetsContainer() {

    return Container(
      margin: EdgeInsets.only(left: SizeConfig.screenWidth * 14.9333333333 / 100, top: (SizeConfig.screenHeight * 7.1428571429 / 100 + SizeConfig.paddingTop)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Registro',
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
            'Tus outfit nuevos esperan en Classy',
            style: TextStyle(
              color: Color(0xFF909090),
              fontFamily: CLASSY_FONT,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
          
        ],
      ),
    );
  }
}