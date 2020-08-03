
import 'package:classy/bloc/sale_information/sale_information_bloc.dart';
import 'package:classy/screens/register/custom_dialog.dart';
import 'package:classy/screens/sale_information/expandeable_container.dart';
import 'package:classy/screens/sale_information/pay_information.dart';
import 'package:classy/screens/sale_information/sale_info.dart';
import 'package:classy/screens/voucher/voucher_screen.dart';
import 'package:classy/utils/constant.dart';
import 'package:classy/utils/size_config.dart';
import 'package:classy/utils/slider_right_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BuyTicketInfo extends StatefulWidget {

  final SaleInformationBloc bloc;
  final List sale;

  BuyTicketInfo({this.sale, this.bloc});

  @override
  State<StatefulWidget> createState() {
    return BuyTicketInfoState(sale: sale);
  }
}

class BuyTicketInfoState extends State<BuyTicketInfo> {

  final List sale;
  bool expandFlag = false;

  BuyTicketInfoState({this.sale});

  @override
  void initState() {
    super.initState();
    _payInfoInit();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: _stackBody()
    );
  }

  _stackBody() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        SingleChildScrollView(child: _scaffoldBody(),),
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                expandFlag = !expandFlag;
              });
            },
            child: ExpandableContainer(
              expanded: expandFlag,
              collapsedHeight: SizeConfig.screenHeight * 26.875 / 100,
              expandedHeight: SizeConfig.screenHeight * 40.3125 / 100,
              child: _modalContain()),
          ),
        )
      ],
    );
  }

  _modalContain() {

    return StreamBuilder<List>(
      stream: this.widget.bloc.infoCar,
      builder: (context, snapshot) {

        if (snapshot.hasData) {

          var elementList = snapshot.data.where((element) {
            return element.number > 0;
          }).toList();

          if (elementList.length > 0) {

            double subTotalAmount = elementList.fold(0, (previous, current) => previous + (double.parse(current.amount)* current.number));
            double itbms = subTotalAmount * 0.07;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                expandFlag ? Expanded(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(Icons.arrow_drop_down),
                          Text(
                            'Desglose',
                            style: TextStyle(
                              fontFamily: CLASSY_FONT,
                              fontSize: 12,
                              color: Color(0xFFAC8EFB)
                            ),
                          )
                        ],
                      ),
                      _infoAmount(elementList, subTotalAmount, itbms),
                    ],
                  ),
                ) : Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Icon(Icons.arrow_drop_up),
                        Text(
                          'Ver desglose',
                          style: TextStyle(
                            fontFamily: CLASSY_FONT,
                            fontSize: 12,
                            color: Color(0xFFAC8EFB)
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                !expandFlag ? _payMethodContainer() : Container(),
                Column(
                  children: <Widget>[
                    _totalAmount(subTotalAmount + itbms),
                    _buyButton()
                  ],
                ),
              ],
            );
          }
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            expandFlag ? Column(
              children: <Widget>[
                Icon(Icons.arrow_drop_down),
                Text(
                  'Desglose',
                  style: TextStyle(
                    fontFamily: CLASSY_FONT,
                    fontSize: 12,
                    color: Color(0xFFAC8EFB)
                  ),
                ),
              ],
            ) : Column(
              children: <Widget>[
                Icon(Icons.arrow_drop_up),
                Text(
                  'Ver desglose',
                  style: TextStyle(
                    fontFamily: CLASSY_FONT,
                    fontSize: 12,
                    color: Color(0xFFAC8EFB)
                  ),
                ),
              ],
            ),
            _payMethodContainer(),
            Column(
              children: <Widget>[
                _totalAmount(0),
                _buyButton()
              ],
            )
          ],
        );
      },
    );
  }

  _payMethodContainer() {

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: SizeConfig.screenWidth * 3.8888888889 / 100,
                  height: SizeConfig.screenWidth * 3.8888888889 / 100,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(25.0))
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFC124F7), Color(0xFF96FFFF)]
                      )
                    ),            
                  ),
                ),
                SizedBox(width: SizeConfig.screenWidth * 2.5 / 100,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Visa **** 5491',
                      style: TextStyle(
                        fontFamily: CLASSY_FONT,
                        fontSize: 10
                      ),
                    ),
                    Text(
                      'Jhoel Ramos',
                      style: TextStyle(
                        fontFamily: CLASSY_FONT,
                        fontSize: 10,
                        color: Colors.black.withOpacity(0.6)
                      ),
                    )
                  ],
                )
              ],
            ),
            Container(
              width: SizeConfig.screenWidth * 15 / 100,
              height: SizeConfig.screenHeight * 3.4375 / 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                boxShadow:[BoxShadow(offset: const Offset(1,2), blurRadius: 2,color: const Color(0xFF000000).withOpacity(0.2),)],   
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '+',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 2.2222222222 / 100,
                  )
                ],
              )
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: SizeConfig.screenHeight * 1.796875 / 100),
          width: SizeConfig.screenWidth * 72.2222222222 / 100,
          height: 0.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF9F2CF0), Color(0xFFA767F4), Color(0xFFB5C4FB), Color(0xFFBEFFFF)]
            )
          ),
        )
      ],
    );
  }

  _infoAmount(elementList, subTotalAmount, itbms) {

    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(right: SizeConfig.screenWidth * 5.5555555556 / 100, left: SizeConfig.screenWidth * 5.5555555556 / 100),
        children: <Widget>[
          SizedBox(
            height: SizeConfig.screenHeight * 1.328125 / 100,
          ),
          _calculateSaleCarInfo(elementList),
          Container(
            height: 0.5,
            width: SizeConfig.screenWidth,
            color: Color(0xFFD1D1D1),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 1.328125 / 100,
          ),
          _calculateTaxColumn(subTotalAmount, itbms)
        ],
      ),
    );
  }

  _calculateSaleCarInfo(List elementList) {
    
    return Column(
      children: elementList.map<Widget>((element) {

        var amount = double.parse(element.amount);
        return _saleCarInfo(element.name, element.number, amount * element.number);
      }).toList()
    );
  }

  _saleCarInfo(name, number, amount) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              number.toString() + ' x ' + name,
              style: TextStyle(
                fontFamily: CLASSY_FONT,
                fontSize: 10,
                color: Color(0xFF646464)
              ),
            ),
            Text(
              "\$ " + amount.toStringAsFixed(2),
              style: TextStyle(
                fontFamily: CLASSY_FONT,
                fontSize: 10,
                color: Color(0xFF646464)
              ),
            ),     
          ],
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 1.25 / 100,
        ),
      ],
    );
  }

  _calculateTaxColumn(subTotalAmount, itbms) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Subtotal',
              style: TextStyle(
                fontFamily: CLASSY_FONT,
                fontSize: 10,
                color: Color(0xFF646464)
              ),
            ),
            Text(
              "\$ " + subTotalAmount.toDouble().toStringAsFixed(2),
              style: TextStyle(
                fontFamily: CLASSY_FONT,
                fontSize: 10,
                color: Color(0xFF646464)
              ),
            ),     
          ],
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 1.25 / 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'ITBMS',
              style: TextStyle(
                fontFamily: CLASSY_FONT,
                fontSize: 10,
                color: Color(0xFF646464)
              ),
            ),
            Text(
              "\$ " + itbms.toDouble().toStringAsFixed(2),
              style: TextStyle(
                fontFamily: CLASSY_FONT,
                fontSize: 10,
                color: Color(0xFF646464)
              ),
            ),     
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: SizeConfig.screenHeight * 1.328125 / 100),
          height: 0.5,
          width: SizeConfig.screenWidth,
          color: Color(0xFFD1D1D1),
        )
      ],
    );
  }

  _totalAmount(amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          'Total',
          style: TextStyle(
            fontFamily: CLASSY_FONT,
            fontSize: 14,
          ),
        ),
        Text(
          'USD ' + "\$" + amount.toDouble().toStringAsFixed(2),
          style: TextStyle(
            fontFamily: CLASSY_FONT,
            fontSize: 14,
          ),
        ),
      ],
    );
  }


  _buyButton() {

    return Container(
        width: MediaQuery.of(context).size.width,
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
              width: MediaQuery.of(context).size.width * 73.333 / 100,
              margin: EdgeInsets.only(bottom: 10, top: 13),
              child: RaisedButton(
                padding: EdgeInsets.all(0),
                onPressed: () async {
                  if (await this.widget.bloc.executePayment(sale)) {
                    Navigator.push(context, SlideRightRouteUtils(page: VoucherScreen()));
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                        title: "Algo salió mal.",
                        description: "Hubo un problema de conexión, por favor intente nuevamente.",
                        buttonText: "Ok",
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icons.close,
                        backgroundColor: CLASSY_COLOR,
                      ),
                    );
                  }
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
          color: CLASSY_COLOR,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            width: 1,
            color: Colors.white
          )
      ),
      child: StreamBuilder<bool>(
        stream: this.widget.bloc.loading,
        builder: (context, snapshot) {
          
          if (null != snapshot.data && snapshot.data) {
            return SpinKitDoubleBounce(color: Colors.white, size: 25.0,);
          } else {

            return Container(
                alignment: Alignment.center,
                child: Text('COMPRAR', style: TextStyle(color: Colors.white, fontFamily: CLASSY_FONT, fontSize: 14, fontWeight: FontWeight.bold))
            );
          }
        },
      )
    );
  }

  _scaffoldBody() {

    return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 8),
              child: Text(
                'Carrito',
                style: TextStyle(
                  fontFamily: HELVETICA_FONT,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 1.71875 / 100,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 8),
              child: Text(
                'Elige la cantidad de productos que desees comprar',
                style: TextStyle(
                  fontFamily: HELVETICA_FONT,
                  fontSize: 15,
                  color: Color(0xFF909090),
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            _saleInformation(),
            SizedBox(
              height: SizeConfig.screenHeight * 40.3125 / 100,
            )
          ],
      ),
    );
  }

  _saleInformation() {

    return Column(
      children: <Widget>[
        _payInformationButtonList(),
      ],
    );
  }

  _payInformationButtonList() {
    
    return StreamBuilder<List>(
      stream: this.widget.bloc.saleCar,
      builder: (context, snapshot) {
        
        if (snapshot.hasData && snapshot.data != null) {
          return Column(children: snapshot.data.map((information) {
            return PayInformation(name: information.name, description: information.description, number: information.number, amount: information.amount, element: information, bloc: this.widget.bloc,);
          }).toList(),);
        }

        return Container();
      },
    ); 
  }

  _payInfoInit() {
    return this.widget.bloc.changeSaleCar(sale.map((element) {
        
        return SaleInformation(id: element['idProducto'], name: element['titulo'], description: element['descripcion'], amount: element['precio'], number: 0,);
      }).toList(),);
  }
}