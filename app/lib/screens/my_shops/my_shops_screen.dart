
import 'package:classy/bloc/my_shops/my_shops_bloc.dart';
import 'package:classy/screens/my_shops/my_shops_content.dart';
import 'package:flutter/material.dart';

class MyShopsScreen extends StatelessWidget {

  final MyShopsBloc bloc = MyShopsBloc();

  @override
  Widget build(BuildContext context) {

    bloc.loadShops();

    return Scaffold(body: MyShopsContent(bloc));
  }
}