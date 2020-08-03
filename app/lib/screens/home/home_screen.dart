
import 'package:classy/screens/dashboard/dashboard_screen.dart';
import 'package:classy/screens/my_shops/my_shops_screen.dart';
import 'package:classy/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}
class HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    DashboardScreen(),
    DashboardScreen(),
    MyShopsScreen()
  ];

  void _onTappedBar(int index) {

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: _navigationBar(context),
    );
  }


  Widget _navigationBar(context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white
      ),
      child: BottomNavigationBar(
        onTap: (index) {
          _onTappedBar(index);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title:
            Text('Inicio',
                style: TextStyle(
                    fontFamily: CLASSY_FONT,
                    fontSize: 10.0
                )),
            activeIcon: Icon(
                Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(const IconData(0xe900, fontFamily: 'FireIcon')),
            activeIcon: Icon(
                const IconData(0xe900, fontFamily: 'FireIcon')
            ),
            title: Text('Para ti', style: TextStyle(
                fontFamily: CLASSY_FONT,
                fontSize: 10.0
            )),
          ),
          BottomNavigationBarItem(
            icon: Icon(const IconData(0xe900, fontFamily: 'TagIcon')),
            activeIcon: Icon(const IconData(0xe900, fontFamily: 'TagIcon')),
            title: Text('Compras', style: TextStyle(
                fontFamily: CLASSY_FONT,
                fontSize: 10.0
            )),
          ),
        ],
        currentIndex: _currentIndex,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        unselectedItemColor: Colors.black,
        selectedItemColor: CLASSY_COLOR,
      ),
    );
  }
}


