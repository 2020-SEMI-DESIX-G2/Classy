
import 'package:classy/bloc/dashboard/dashboard_bloc.dart';
import 'package:classy/utils/constant.dart';
import 'package:classy/utils/size_config.dart';
import 'package:flutter/material.dart';

class PostInformationScreen extends StatelessWidget {

  final Map<String, dynamic> product;
  final DashboardBloc bloc;

  PostInformationScreen(this.product, this.bloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                _cardModel(context),
                _productDescription(),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 12,
                )
              ],
            ),
            Positioned(
              bottom: 0,
              child: _buyButton(context),
            )
          ],
        )
    );
  }

  _productDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Text(
            'Detalles',
            style: TextStyle(
              fontFamily: HELVETICA_FONT,
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Panamá - Panamá',
                style: TextStyle(
                  fontFamily: CLASSY_FONT,
                  fontSize: 15,
                ),
              ),
              Text(
                '19 JUL 2020',
                style: TextStyle(
                  fontFamily: CLASSY_FONT,
                  fontSize: 15,
                ),
              ),        
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Text(
            'Descripción',
            style: TextStyle(
              fontFamily: HELVETICA_FONT,
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Text(
            product['descripcion'],
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: CLASSY_FONT,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
          ),
          Container(
            height: 1,
            width: SizeConfig.screenWidth,
            color: Color(0xFF707070),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: SizeConfig.blockSizeHorizontal * 8,
                  child: Icon(Icons.person_outline, color: Colors.black, size: 33,),
                ),
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 3,
              ),
              Text(
                product['dueno'],
                style: TextStyle(
                  fontFamily: CLASSY_FONT,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buyButton(context) {

  return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: Colors.transparent,
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
            color: Colors.transparent,
            height: 44,
            width: SizeConfig.screenWidth * 73.333 / 100,
            margin: EdgeInsets.only(bottom: 10, top: 13),
            child: RaisedButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                bloc.saveToCar(product); // To close the dialog
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
        color:  CLASSY_COLOR,
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(
          width: 1,
          color: Colors.white
        )
      ),
      child: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('AÑADIR AL CARRITO', style: TextStyle(color: Colors.white, fontFamily: CLASSY_FONT, fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 2,
              ),
              Icon(Icons.shopping_cart, color: Colors.white, size: 23,)
            ],
          )
      )
    );
  }

  _cardModel(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Hero(
        tag: 'post_info' + product['_id'],
        child: Card(
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: SizeConfig.blockSizeVertical * 80,
                child: Container( 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  ),
                  child: Image.network(CLOUDFRONT + product['_id'] + '.jpg', fit: BoxFit.fill,),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: SizeConfig.blockSizeVertical * 80,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                    gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black54],
                        begin: Alignment.center,
                        end: Alignment.bottomCenter)),
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(bottom: 8.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 60,
                              child: Text(product['titulo'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: CLASSY_FONT,
                                    fontWeight: FontWeight.w700)),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
                              child: Text("\$ " + product['precio'],
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: CLASSY_FONT,
                                fontSize: 20
                                )
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}