
import 'package:classy/bloc/register/register_bloc.dart';
import 'package:classy/commons/rectangule_button.dart';
import 'package:classy/commons/text_field.dart';
import 'package:classy/screens/register/choice.dart';
import 'package:classy/screens/register/custom_dialog.dart';
import 'package:classy/utils/constant.dart';
import 'package:classy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegisterForm extends StatefulWidget {

  final RegisterBloc bloc;

  RegisterForm({this.bloc});

  @override
  State<StatefulWidget> createState() {
    bloc.addPreferences(Choice.from(PREFERENCES));
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {

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
          height: SizeConfig.screenHeight * 2.5862068966 / 100,
        ),
        passwordValidations(),
        SizedBox(
          height: SizeConfig.screenHeight * 2.5862068966 / 100,
        ),
        StreamBuilder(
          stream: this.widget.bloc.confirmPassword,
          builder: (context, snapshot) {
            return RectanguleTextField(
              label: 'Confirmar contraseña',
              onChanged: this.widget.bloc.changeConfirmPassword,
            );
          },
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 2.5862068966 / 100,
        ),
        StreamBuilder(
          stream: this.widget.bloc.email,
          builder: (context, snapshot) {
            return RectanguleTextField(
              label: 'Correo electrónico',
              onChanged: this.widget.bloc.changeEmail,
            );
          },
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 2.5862068966 / 100,
        ),
        Text(
          'Elige tu preferencia de ropa:',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: CLASSY_FONT,
            fontSize: 12
          ),
        ),
        prefChips(),
        SizedBox(
          height: SizeConfig.screenHeight * 6.5270935961 / 100,
        ),
        StreamBuilder(
          stream: this.widget.bloc.nextButton,
          builder: (context, snapshot) {
            return RectanguleButton(
              backgroundColor: Color(0xFFD6535A),
              onPressed: () async {
                
                 if (await this.widget.bloc.submit()) {
                   showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog(
                      title: "Registro completo",
                      description: "Por favor, inicia sesión con tus credenciales.",
                      buttonText: "Ok",
                      backgroundColor: Color(0xFF2F6A40).withOpacity(0.9),
                      icon: Icons.check,
                      onPressed: () {
                        Navigator.popUntil(context, ModalRoute.withName('/')); // To close the dialog
                      },
                    ),
                  ); 
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog(
                      title: "Algo salió mal",
                      description: "Por favor, intentalo nuevamente.",
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
        ),
      ],
    );
  }

  Widget passwordValidations() {

    return StreamBuilder<int>(
      stream: this.widget.bloc.passwordValidation,
      builder: (context, snap) {
        return Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildWrap("Entre 8 a 16 carácteres.", snap.data != null ? validateLength(snap.data) : Icons.close),
                buildWrap("Debe contener números y letras.", snap.data != null ? validateNumberLetters(snap.data) : Icons.close),
              ],
            )
        );
      },
    );
  }

  IconData validateLength(int value) {

    switch(value) {
      case 1:
        return Icons.check;
        break;
      case 2:
        return Icons.close;
        break;
      case 3:
        return Icons.check;
        break;
      default:
        return Icons.close;
    }
  }

  IconData validateNumberLetters(int value) {

    switch(value) {
      case 1:
        return Icons.close;
        break;
      case 2:
        return Icons.check;
        break;
      case 3:
        return Icons.check;
        break;
      default:
        return Icons.close;
    }
  }

  Widget buildWrap(String text, IconData icon) {

    return Wrap(spacing: 5.0,children: <Widget>[
      Icon(icon, size: 18.0, color: Color.fromRGBO(0, 150, 136, 1),),
      Text(text, style: TextStyle(fontSize: 12.0, fontFamily: CLASSY_FONT),)
    ],);
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

  Widget prefChips() {

    return StreamBuilder<List<Choice>>(
      stream: this.widget.bloc.preferences,
      builder: (context, snap) {
        return Container(
          width: SizeConfig.screenWidth * 70.1333333333 / 100,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: List<Widget>.generate(null == snap.data ? PREFERENCES.length : snap.data.length,
                  (int index) {
                return ChoiceChip(
                  label: getText((null != snap.data ? snap.data[index].value : ''), FontWeight.normal, color: Colors.black),
                  selected: snap.data != null ? snap.data[index].selected : false,
                  backgroundColor: Colors.transparent,
                  selectedColor: Color(0xFFD6535A),
                  labelStyle: TextStyle(color: Color(0xFFD6535A)),
                  onSelected: (selected) {
                    this.widget.bloc.changePreferences(index, selected);
                  },
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }

  Text getText(String text, FontWeight fontWeight, {color}) {
    return Text(text,
        style: TextStyle(
            fontFamily: CLASSY_FONT,
            fontSize: 12.0,
            color: color != null ? color : Colors.white,
            fontWeight: fontWeight,
        )
    );
  }
}