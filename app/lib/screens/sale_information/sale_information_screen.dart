

import 'package:classy/bloc/sale_information/sale_information_bloc.dart';
import 'package:classy/screens/sale_information/buy_ticker_info.dart';
import 'package:flutter/material.dart';

class SaleInformationScreen extends StatelessWidget {

  final SaleInformationBloc bloc = SaleInformationBloc();
  final List products;

  SaleInformationScreen({this.products});

  @override
  Widget build(BuildContext context) {
    return BuyTicketInfo(bloc: bloc, sale: products,);
  }
}

