
import 'package:classy/bloc/my_shops/my_shops_bloc.dart';
import 'package:classy/screens/my_shops/item.dart';
import 'package:classy/utils/constant.dart';
import 'package:classy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyShopsContent extends StatefulWidget{

  final MyShopsBloc bloc;

  MyShopsContent(this.bloc);

  @override
  State<StatefulWidget> createState() {
    return MyShopsContentState();
  }
}

class MyShopsContentState extends State<MyShopsContent> {

  List<Item> itemList = List();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              height: SizeConfig.blockSizeVertical * 8
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 8),
              child: Text(
                'Compras',
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
                'Estas son tus compras realizadas por Classy.',
                style: TextStyle(
                  fontFamily: HELVETICA_FONT,
                  fontSize: 15,
                  color: Color(0xFF909090),
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          _expandeableListContent()
        ],
      );
  }

  _expandeableListContent() {
    return StreamBuilder<bool>(
      stream: this.widget.bloc.loading,
      builder: (context, snap) {

         if (snap.data != null && !snap.data && this.widget.bloc.posts != null) {

          List temp = Item.generateItems(this.widget.bloc.posts);

          if (temp.length > 0) {

            if (itemList.length < temp.length) {
              itemList = temp;
            }

            return Expanded(
              child: ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      
                      setState(() {

                        itemList[index].isExpanded = !isExpanded;
                      });
                    },
                    children: itemList.map<ExpansionPanel>((Item item) {
                      return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: item.headerValue,
                          );
                        },
                        body: ListTile(
                          title: item.expandedValue,
                        ),
                        isExpanded: item.isExpanded,
                      );
                    }).toList(),
                  );
                }
              ),
            );
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
    );
  }
}