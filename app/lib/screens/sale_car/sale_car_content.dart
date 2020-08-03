
import 'package:classy/bloc/sale_car/sale_car_bloc.dart';
import 'package:classy/screens/sale_information/sale_information_screen.dart';
import 'package:classy/utils/constant.dart';
import 'package:classy/utils/size_config.dart';
import 'package:classy/utils/slider_right_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SaleCarContent extends StatefulWidget {

  final SaleCarBloc bloc;

  SaleCarContent(this.bloc);

  @override
  State<StatefulWidget> createState() {
    return _SaleCarContentState();
  }
}

class _SaleCarContentState extends State<SaleCarContent> {

  _childButton() {

    return Ink(
      height: SizeConfig.screenHeight * 6.875 / 100,
      decoration: BoxDecoration(
          color: CLASSY_COLOR,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            width: 1,
            color: Colors.white
          ),
      ),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'COMPRAR',
          style: TextStyle(
            fontSize: 14,
            fontFamily: CLASSY_FONT,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        )
      ],
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        StreamBuilder<bool>(
          stream: this.widget.bloc.loading,
          builder: (context, snapshot) {
            
            if (snapshot.data != null && !snapshot.data && this.widget.bloc.posts != null) {
              
              List posts = this.widget.bloc.posts;
              if (posts.length > 0) {
                return buildList();
              } else {
                return Container();
              }
            } else {

              return Container(
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 50),
                  child: SpinKitDoubleBounce(color: CLASSY_COLOR)
                );
            }
          },
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: SizeConfig.screenWidth * 73.3333333333 / 100,
            height: SizeConfig.screenHeight * 6.875 / 100,
            margin: EdgeInsets.only(bottom:SizeConfig.screenHeight * 2.65625 / 100),
            child: RaisedButton(
              padding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(33.0))),
              onPressed: () {
                Navigator.push(context, SlideRightRouteUtils(page: SaleInformationScreen(products: this.widget.bloc.posts,)));
              },
              child: _childButton()
            ),
          ),
        ),
      ],
    );
  }

  buildList() {
    return ListView.builder(
      itemCount: this.widget.bloc.posts.length,
      itemBuilder: (BuildContext context, int index) {
        
        var posts = this.widget.bloc.posts;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(offset: const Offset(3,3), blurRadius: 6,color: Colors.black12)]
          ),
          height: SizeConfig.blockSizeHorizontal * 21,
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.symmetric(horizontal:SizeConfig.blockSizeHorizontal * 3),
          margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 3, vertical: SizeConfig.blockSizeVertical * 1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: SizeConfig.blockSizeHorizontal * 20,
                height: SizeConfig.blockSizeHorizontal * 20,
                child: Image.network(CLOUDFRONT + posts[index]['idProducto'] + '.jpg', fit: BoxFit.fill,),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 40,
                    child: Text(
                      posts[index]['titulo'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: CLASSY_FONT,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(' '),
                      Text("\$ " + posts[index]['precio'],
                        style: TextStyle(
                          fontFamily: CLASSY_FONT,
                          fontWeight: FontWeight.bold,
                          fontSize: 17
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Center(
                child: Container(
                  child: IconButton(
                    onPressed: () {

                      this.widget.bloc.deleteItem(posts[index]);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              )
            ],
          ),
        );
    });
  }
}