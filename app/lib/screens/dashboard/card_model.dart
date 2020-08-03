import 'package:classy/bloc/dashboard/dashboard_bloc.dart';
import 'package:classy/screens/post_information/post_information_screen.dart';
import 'package:classy/utils/constant.dart';
import 'package:flutter/material.dart';

class CardModel extends StatelessWidget {

  final int cardNum;
  final Map<String, dynamic> product;
  final DashboardBloc bloc;

  CardModel(this.cardNum, this.product, this.bloc);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return PostInformationScreen(product, bloc);
          }));
      },
      child: Hero(
        tag: 'post_info' + product['_id'],
        child: Card(
          child: Stack(
            children: <Widget>[
              SizedBox.expand(
                child: Container( 
                  child: Image.network(CLOUDFRONT + product['_id'] + '.jpg', fit: BoxFit.cover,),
                ),
              ),
              SizedBox.expand(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black54],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter)),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(product['titulo'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700)),
                        Padding(padding: EdgeInsets.only(bottom: 8.0)),
                        Text(product['descripcion'],
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white)),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
