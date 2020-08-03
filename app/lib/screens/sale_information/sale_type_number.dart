import 'package:classy/bloc/sale_information/sale_information_bloc.dart';
import 'package:classy/screens/sale_information/sale_info.dart';
import 'package:classy/utils/constant.dart';
import 'package:classy/utils/size_config.dart';
import 'package:flutter/material.dart';

class SaleTypeNumber extends StatefulWidget {

  final String number;
  final SaleInformationBloc bloc;
  final SaleInformation element;

  SaleTypeNumber({
    this.number, 
    this.bloc, 
    this.element});

  @override
  State<StatefulWidget> createState() {
    return SaleTypeNumberState();
  }
}

class SaleTypeNumberState extends State<SaleTypeNumber> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Center(
            child: GestureDetector(
              onTap: () {
                this.widget.bloc.minSaleCar(this.widget.element);
              },
              child: Container(
                width: SizeConfig.screenWidth * 6.6666666667 / 100,
                height: SizeConfig.screenWidth * 6.6666666667 / 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(width: 1)
                ),
                child: Center(child: Text('-', style: TextStyle(fontSize: 14, color: Colors.black),))
              ),
            )
          ),
        ),
        SizedBox(
          width: SizeConfig.screenWidth * 3.3333333333 / 100,
        ),
        Text(
          this.widget.number,
          style: TextStyle(
            fontFamily: CLASSY_FONT,
            fontSize: 24
          ),
        ),
        SizedBox(
          width: SizeConfig.screenWidth * 3.3333333333 / 100,
        ),
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Center(
            child: GestureDetector(
              onTap: () {
                this.widget.bloc.sumSaleCar(this.widget.element);
              },
              child: Container(
                width: SizeConfig.screenWidth * 6.6666666667 / 100,
                height: SizeConfig.screenWidth * 6.6666666667 / 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(width: 1)
                ),
                child: Center(child: Text('+', style: TextStyle(fontSize: 14, color: Colors.black),))
              ),
            )
          ),
        ),
      ],
    );
  }
}