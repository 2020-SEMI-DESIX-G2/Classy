
import 'package:classy/utils/constant.dart';
import 'package:classy/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  Widget expandedValue;
  Widget headerValue;
  bool isExpanded;

  static List<Item> generateItems(List list) {
    return List.generate(list.length, (int index) {

      DateTime date = new DateFormat('yyyy-MM-ddTHH:mm:sssZ').parse(list[index]['fecha']);
      return Item(
        headerValue: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              date.day.toString() + " " + getMonth(date.month) + " " + date.year.toString(),
              style: TextStyle(
                fontFamily: CLASSY_FONT,
                fontSize: 15,
              ),              
            ),
            Text(
              "\$ " + list[index]['total'],
              style: TextStyle(
                fontFamily: CLASSY_FONT,
                fontSize: 15,
              ),
            )
          ],
        ),
        expandedValue: Column(
          children: list[index]['productos'].map<Widget>((producto) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                   Expanded(child: Text(producto['cantidad'].toString() + " x " + producto['titulo'], overflow: TextOverflow.ellipsis,)),
                   Text("\$ " +producto['precio'])
                ],
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  static String getMonth(int month) {
    
    switch(month) {
      case DateTime.january: return "ENE";
      break;
      case DateTime.february: return "FEB";
      break; 
      case DateTime.march: return "MAR";
      break;  
      case DateTime.april: return "ABR";
      break;   
      case DateTime.may: return "MAY";
      break;
      case DateTime.june: return "JUN";
      break;
      case DateTime.july: return "JUL";
      break;
      case DateTime.august: return "AGO";
      break;
      case DateTime.september: return "SEP";
      break;
      case DateTime.october: return "OCT";
      break;
      case DateTime.november: return "NOV";
      break;
      case DateTime.december: return "DEC";
      break;
    }

    return "ENE";
  }
}