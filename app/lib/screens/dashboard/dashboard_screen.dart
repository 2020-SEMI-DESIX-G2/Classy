import 'package:classy/bloc/authorization/authorization_bloc.dart';
import 'package:classy/bloc/dashboard/dashboard_bloc.dart';
import 'package:classy/screens/dashboard/card_model.dart';
import 'package:classy/screens/dashboard/card_slider_section.dart';
import 'package:classy/screens/sale_car/sale_car.dart';
import 'package:classy/screens/sale_information/make_payment.dart';
import 'package:classy/utils/constant.dart';
import 'package:classy/utils/size_config.dart';
import 'package:classy/utils/slider_right_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DashboardScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    DashboardBloc bloc = DashboardBloc();
    bloc.loadPosts();
    return DashBoard(bloc);
  }
}

class DashBoard extends StatefulWidget {

  final DashboardBloc bloc;

  DashBoard(this.bloc);

  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<DashBoard> {

  GlobalKey<CardSliderSectionState> _cardSliderState;

  bool showAlignmentCards = false;

  @override
  void initState() {
    super.initState();
    _cardSliderState = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<bool>(
        stream: this.widget.bloc.data,
        builder: (context, snapshot) {

          if (snapshot.data != null && snapshot.data) {
            return Column(
              children: <Widget>[
                headerSection(),
                CardSliderSection(context, this.widget.bloc, _cardSliderState),
                buttonsRow()
              ],
            );
          } else {
            return Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 50),
              child: SpinKitDoubleBounce(color: CLASSY_COLOR)
            );
          }
        },
      ),
    );
  }

  headerSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      padding: EdgeInsets.only(top: SizeConfig.paddingTop + SizeConfig.screenHeight * 4.3103448276 / 100, left: SizeConfig.screenWidth * 5.8666666667 / 100,right: SizeConfig.screenWidth * 5.8666666667 / 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Classy',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 25
            ),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: CLASSY_COLOR, size: 27,),
            onPressed: () {
              Navigator.push(context, SlideRightRouteUtils(page: SaleCarScreen()));
            },
          )
        ],
      ),
    );
  }

  Widget buttonsRow() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            mini: true,
            onPressed: (){
              
            },
            heroTag: null,            
            backgroundColor: Colors.white,
            child: Icon(Icons.replay, color: Colors.blueAccent),
          ),
          Padding(padding: EdgeInsets.only(right: 8.0)),
          FloatingActionButton(
            onPressed: () {
              
              _cardSliderState.currentState.animateCards();
            },
            heroTag: null,

            backgroundColor: Colors.white,
            child: Icon(Icons.close, color: Colors.red),
          ),
          Padding(padding: EdgeInsets.only(right: 8.0)),
          FloatingActionButton(
            onPressed: () {
              _cardSliderState.currentState.animateCards();

              if ( _cardSliderState.currentState.cards[0] is CardModel) {
                CardModel cardModel= _cardSliderState.currentState.cards[0];
                this.widget.bloc.saveToCar(cardModel.product);
              }
              //_cardSliderState.currentState.cards[0].product;
              //this.widget.bloc.saveToCar(_cardSliderState.currentState.cards[0]);
            },
            heroTag: null,            
            backgroundColor: Colors.white,
            child: Icon(Icons.favorite, color: Colors.green),
          ),
          Padding(padding: EdgeInsets.only(right: 8.0)),
          FloatingActionButton(
            mini: true,
            onPressed: (){
              authBloc.closeSession();
            },
            heroTag: null,            
            backgroundColor: Colors.white,
            child: Icon(Icons.exit_to_app, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
