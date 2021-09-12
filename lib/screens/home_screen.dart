import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unionvibe/constants.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {
  final UserRepository _userRepository;
  const HomeScreen({required userRepository})
      : _userRepository = userRepository;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomSelectedIndex = 0;

  List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: new Icon(Icons.search),
      label: 'Записаться',
    ),
    BottomNavigationBarItem(
      icon: new Icon(Icons.add),
      label: 'Организовать',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.today),
      label: 'Записи',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Профиль',
    ),
  ];

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        AllEventsScreen(userRepository: widget._userRepository),
        CreateEventScreen(userRepository: widget._userRepository),
        MyBookingsScreen(userRepository: widget._userRepository),
        ProfileScreen(userRepository: widget._userRepository),
      ],
    );
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildPageView(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kMainColor,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.white,
        items: bottomNavBarItems,
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
