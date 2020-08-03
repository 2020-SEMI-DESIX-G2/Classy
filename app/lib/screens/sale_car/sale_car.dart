
import 'package:classy/bloc/sale_car/sale_car_bloc.dart';
import 'package:classy/screens/sale_car/sale_car_content.dart';
import 'package:classy/utils/constant.dart';
import 'package:classy/utils/size_config.dart';
import 'package:flutter/material.dart';

class SaleCarScreen extends StatelessWidget {

  final SaleCarBloc bloc = SaleCarBloc();

  @override
  Widget build(BuildContext context) {

    bloc.loadCar();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF909090),),
        ),
        title: Row(
          children: <Widget>[
            Icon(Icons.shopping_cart, color: CLASSY_COLOR, size: 27,),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 3,
            ),
            Text(
              'Carrito',
              style: TextStyle(
                fontFamily: CLASSY_FONT,
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
              )
          ],
        ),
      ),
      body: SaleCarContent(bloc),
    );
  }
}

