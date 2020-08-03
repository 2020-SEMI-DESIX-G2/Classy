
import 'package:classy/utils/constant.dart';
import 'package:classy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VoucherScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          _containerContent(),
          Positioned(
            bottom: 0,
            child: _buyButton(context),
          )
        ],
      )
    );
  }

  _containerContent() {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 7),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: (SizeConfig.blockSizeVertical * 5) + SizeConfig.paddingTop,
          ),
          Text(
            '¡Gracias por su compra!',
            style: TextStyle(
              fontFamily: HELVETICA_FONT,
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Text(
            'Su pedido será tramitado para hacerle llegar los productos. La orden la puede ver en la pestaña Compras.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: HELVETICA_FONT,
              fontSize: 16,
              color: Color(0xFF909090),
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
          Container(
            height: SizeConfig.blockSizeHorizontal * 50,
            width: SizeConfig.blockSizeHorizontal * 50,
            child: SvgPicture.asset('res/images/add_cart_image.svg'),
          ),
        ],
      ),
    );
  }

  _buyButton(context) {

  return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [0.87, 1],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.05)
          ]
        )
      ),
      child: Center(
        child: Container(
            height: 44,
            width: SizeConfig.screenWidth * 73.333 / 100,
            margin: EdgeInsets.only(bottom: 10, top: 13),
            child: RaisedButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/')); // To close the dialog
              },
              child: _childButton(),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
            )
        ),
      ),
    );
  }

 _childButton() {

    return Ink(
      decoration: BoxDecoration(
        color: Color(0xFF2F6A40),
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(
          width: 1,
          color: Colors.white
        )
      ),
      child: Container(
          alignment: Alignment.center,
          child: Text('FINALIZAR', style: TextStyle(color: Colors.white, fontFamily: CLASSY_FONT, fontSize: 14, fontWeight: FontWeight.bold))
      )
    );
  }
}