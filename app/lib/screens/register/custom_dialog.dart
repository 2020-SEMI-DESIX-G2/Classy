import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;
  final Function onPressed;
  final Color backgroundColor;
  final IconData icon;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
    this.onPressed,
    this.backgroundColor,
    this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    const double padding = 16.0;
    const double avatarRadius = 40.0;

    return Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.only(
            top: avatarRadius + padding,
            left: padding,
            right: padding,
          ),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                )
              ]),
          child:
              Column(mainAxisSize: MainAxisSize.min, // To make the card compact
                  children: <Widget>[
                Text(
                  this.title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
                SizedBox(height: 24.0),
                Align(
                    alignment: Alignment.center,
                    child: FlatButton(
                      onPressed: this.onPressed,
                      child: Text(buttonText),
                    ))
              ])),
      Positioned(
          left: padding,
          right: padding,
          child: CircleAvatar(
            backgroundColor: this.backgroundColor,
            radius: avatarRadius,
            child: Icon(this.icon, size: 40,),
          ))
    ]);
  }
}