import 'package:flutter_bloc/pages/add_item.dart';
import 'package:flutter_bloc/pages/show_item.dart';
import 'package:flutter_bloc/widgets/log_out_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  Future<bool> _onWillPopScope() async {
    return false;
  }

  int _currentIndex = 0;

  List<Widget> _tabList = [
    new ShowItem(),
    new AddItem(),
  ];

  PageController _pageController;

  @override
  void initState() {
    _pageController = new PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._currentIndex = page;
    });
  }


  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: new IconThemeData(color: Color(0xFF18D191)),
            actions: <Widget>[
              LogOutButton(),
            ],
          ),
          body: PageView(
            children: _tabList,
            onPageChanged: onPageChanged,
            controller: _pageController,
          ),
          bottomNavigationBar: BottomNavigationBar(
            fixedColor: Color(0XFF29D091),
            currentIndex: _currentIndex,
            onTap: navigationTapped,
            items: [
              BottomNavigationBarItem(
                  title: Text('Listado'), icon: Icon(Icons.list)),
              BottomNavigationBarItem(
                  title: Text('Nuevo'), icon: Icon(Icons.add)),
            ],
          ),
        ),
      ),
    );
  }
}


