
import 'package:classy/bloc/sale_information/sale_information_bloc.dart';
import 'package:classy/screens/sale_information/sale_info.dart';
import 'package:classy/screens/sale_information/sale_type_number.dart';
import 'package:classy/utils/constant.dart';
import 'package:classy/utils/size_config.dart';
import 'package:flutter/material.dart';

class PayInformation extends StatefulWidget {

  final SaleInformationBloc bloc;
  final String name;
  final String description;
  final String amount;
  final int number;
  final SaleInformation element;

  PayInformation({
    this.bloc,
    this.name,
    this.description,
    this.amount,
    this.number,
    this.element
  });

  @override
  State<StatefulWidget> createState() {
    return PayInformationState();
  }
}

class PayInformationState extends State<PayInformation> {

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight * 15 / 100,
        margin: EdgeInsets.only(top: SizeConfig.screenHeight * 1.875 / 100, left: SizeConfig.blockSizeHorizontal * 8, right: SizeConfig.blockSizeHorizontal * 8),
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(23),
          boxShadow:[BoxShadow(offset: const Offset(3,3), blurRadius: 6,color: const Color(0xFF000000).withOpacity(0.2),)],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 22, right: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
              SizedBox(
                height: 9.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    this.widget.name,
                    style: TextStyle(
                      fontFamily: CLASSY_FONT,
                      fontSize: 12,
                      color: Color(0xff000000),
                    ),
                  ),
                  Text(
                    "\$ " + this.widget.amount,
                    style: TextStyle(
                      fontFamily: CLASSY_FONT,
                      fontSize: 12.0
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
              this.widget.description,
              style: TextStyle(
                fontFamily: CLASSY_FONT,
                fontSize: 10,
                color: Color(0xFF646464),
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              SaleTypeNumber(number: this.widget.number.toString(), element: this.widget.element, bloc: this.widget.bloc,)
          ],
      ),
        ),
    );
  }
}