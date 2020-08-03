
import 'package:classy/utils/constant.dart';
import 'package:classy/utils/size_config.dart';
import 'package:flutter/material.dart';

class RectanguleTextField extends StatefulWidget {

  final String label;
  final Function onChanged;

  RectanguleTextField({this.label, this.onChanged});
  
  @override
  State<StatefulWidget> createState() {
    return RectanguleTextFieldState();
  }
}

class RectanguleTextFieldState extends State<RectanguleTextField> {

  @override
  Widget build(BuildContext context) {

    return Container(
      height: SizeConfig.screenHeight * 4.9261083744 / 100,
      width: SizeConfig.screenWidth * 70.1333333333 / 100,
      child: TextField(
        onChanged: this.widget.onChanged,
        style: TextStyle(
          fontSize: 12,
          fontFamily: CLASSY_FONT
        ),
        decoration: InputDecoration(
          labelStyle: TextStyle(
            fontFamily: CLASSY_FONT,
            color: Color(0xFF909090),
            fontSize: 12
          ),
          labelText: this.widget.label,
          contentPadding: EdgeInsets.only(left: SizeConfig.screenWidth * 5.3333333333 / 100),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFD6535A),
              width: 1.0
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF909090),
              width: 1.0
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF909090),
              width: 1.0
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))
          )
        ),
      ),
    );
  }}