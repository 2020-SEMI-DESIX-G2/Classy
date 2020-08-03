
import 'package:classy/bloc/login/login_bloc.dart';
import 'package:classy/commons/rectangule_button.dart';
import 'package:classy/commons/text_field.dart';
import 'package:classy/screens/register/custom_dialog.dart';
import 'package:classy/utils/constant.dart';
import 'package:classy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginForm extends StatefulWidget {

  final LoginBloc bloc;

  LoginForm({this.bloc});

  @override
  State<StatefulWidget> createState() {
    return LofinFormState();
  }
}

class LofinFormState extends State<LoginForm> {

  @override
  Widget build(BuildContext context) {
    return _formColumn();
  }

  _formColumn() {

    return Column(
      children: <Widget>[
        StreamBuilder(
          stream: this.widget.bloc.username,
          builder: (context, snapshot) {
            return RectanguleTextField(
              label: 'Usuario',
              onChanged: this.widget.bloc.changeUsername,
            );
          },
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 2.5862068966 / 100,
        ),
        StreamBuilder(
          stream: this.widget.bloc.password,
          builder: (context, snapshot) {
            return RectanguleTextField(
              label: 'Contraseña',
              onChanged: this.widget.bloc.changePassword,
            );
          },
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 6.5270935961 / 100,
        ),
        StreamBuilder(
          stream: this.widget.bloc.submitValid,
          builder: (context, snapshot) {
            return RectanguleButton(
              backgroundColor: Color(0xFFD6535A),
              onPressed: () async {

                if (! await this.widget.bloc.submit(context)) {
                  
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog(
                      title: "Datos incorectos",
                      description: "Por favor, verifique los datos e intente nuevamente.",
                      buttonText: "Ok",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icons.close,
                      backgroundColor: CLASSY_COLOR,
                    ),
                  );
                }
              },
              child: buttonChild(),
              textColor: Colors.white,
              width: SizeConfig.screenWidth * 70.1333333333 / 100,
            );
          },
        )
      ],
    );
  }

  Widget buttonChild() {
    return StreamBuilder<bool>(
        stream: this.widget.bloc.loading,
        builder: (context, snap) {
          return Container(
            alignment: Alignment.center,
            child: null != snap.data && snap.data
            ? SpinKitDoubleBounce(color: Colors.white, size: 25.0,) 
            : Text(
                'Entrar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: CLASSY_FONT,
                  color: Colors.white
                ),
              ),
          );
        }
    );
  }
}