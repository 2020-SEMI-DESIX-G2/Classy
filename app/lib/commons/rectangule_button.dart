
import 'package:classy/utils/constant.dart';
import 'package:classy/utils/size_config.dart';
import 'package:flutter/material.dart';

class RectanguleButton extends StatelessWidget {

  final Color backgroundColor;
  final String text;
  final Widget child;
  final Color textColor;
  final Function onPressed;
  final double width;

  RectanguleButton({this.backgroundColor, this.onPressed, this.text, this.textColor, this.width, this.child});

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Container(
      height: SizeConfig.screenHeight * 4.9261083744 / 100,
      width: this.width == null ? SizeConfig.screenWidth * 73.3333333333 / 100 : this.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: child != null
          ? child
          : Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: CLASSY_FONT,
              color: textColor
            ),
          ),
      ),
    );
  }
}