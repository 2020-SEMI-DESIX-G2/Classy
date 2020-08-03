
import 'package:classy/commons/rectangule_button.dart';
import 'package:classy/screens/login/login_screen.dart';
import 'package:classy/screens/register/register_screen.dart';
import 'package:classy/utils/size_config.dart';
import 'package:classy/utils/slider_right_page.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Stack(
      children: <Widget>[
        _backgroundImage(),
        _scaffoldContains(context)
      ],
    );
  }

  _backgroundImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("res/images/onboarding_background.png"), // <-- BACKGROUND IMAGE
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  _scaffoldContains(context) {

    return Scaffold(
      backgroundColor: Color(0xFFD6535A).withOpacity(0.90),
      body: Container(
        width: SizeConfig.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: SizeConfig.screenHeight * 40.6403940887 / 100, bottom: SizeConfig.screenHeight * 8.4975369458 / 100),
              height: SizeConfig.screenHeight * 18.842364532 / 100,
              width: SizeConfig.screenWidth * 67.7333333333 / 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('res/images/classy_white_logo.png'),
                  fit: BoxFit.fill
                )
              ),
            ),
            RectanguleButton(
              text: 'Registro',
              textColor: Colors.white,
              backgroundColor: Colors.transparent,
              onPressed: () {
                Navigator.push(context, SlideRightRouteUtils(page: RegisterScreen()));
              },
            ),
            SizedBox(height: SizeConfig.screenHeight * 4.9261083744 / 100,),
            RectanguleButton(
              text: 'Entrar',
              textColor: Color(0xFFD6535A),
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(context, SlideRightRouteUtils(page: LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}