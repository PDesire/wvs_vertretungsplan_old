import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:wvs_plan/pages/NextPage/NextPage.dart';
import 'package:wvs_plan/pages/TodayPage/TodayPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  BottomBarController _controller;
  PageController _pageController;

  int _visible = 0;

  @override
  void initState() {
    super.initState();
    _controller = BottomBarController(vsync: this, dragLength: 550, snap: true);
    _pageController = PageController();
    _pageController.addListener(_onPageChangedScroll);
  }

  void _onPageChangedScroll() {
    setState(() {
      _visible = _pageController.page.toInt();
    });
  }
  
  @override
  void dispose() {
    _pageController.removeListener(_onPageChangedScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            TodayPage(),
            NextPage()
          ],
        ),
        appBar: PreferredSize(
          preferredSize:
              Size(double.infinity, MediaQuery.of(context).size.height * 0.13),
          child: AppBar(
            centerTitle: true,
            title: Text("WVS Vertretungsplan"),
            backgroundColor: Theme.of(context).bottomAppBarColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(MediaQuery.of(context).size.width, 100.0),
              ),
            ),
          ),
        ),

        // Lets use docked FAB for handling state of sheet
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: GestureDetector(
          // Set onVerticalDrag event to drag handlers of controller for swipe effect
          onVerticalDragUpdate: _controller.onDrag,
          onVerticalDragEnd: _controller.onDragEnd,
          child: FloatingActionButton.extended(
            label: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.settings),
                SizedBox(
                  width: 2,
                ),
                Text("Einstellungen"),
              ],
            ),
            elevation: 2,
            backgroundColor: Theme.of(context).buttonColor,
            foregroundColor: Theme.of(context).textTheme.display1.color,

            //Set onPressed event to swap state of bottom bar
            onPressed: () => _controller.swap(),
          ),
        ),
        bottomNavigationBar: BottomExpandableAppBar(
          controller: _controller,
          appBarHeight: MediaQuery.of(context).size.height * 0.07,
          expandedHeight: MediaQuery.of(context).size.height * 0.70,
          horizontalMargin: 16,
          expandedBackColor: Theme.of(context).backgroundColor,
          shape: AutomaticNotchedShape(
              RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),
          expandedBody: Center(
            child: Text("Coming SoonTM"),
          ),
          // Your bottom app bar code here
          bottomAppBarBody: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOutCubic);
                      setState(() {
                        _visible = 0;
                      });
                    },
                    child: AnimatedOpacity(
                      opacity: _visible == 0 ? 1.0 : 0.5,
                      duration: Duration(milliseconds: 200),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.access_time),
                          Text(
                            "Heute",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.easeInOutCubic);
                      setState(() {
                        _visible = 1;
                      });
                    },
                    child: AnimatedOpacity(
                      opacity: _visible == 1 ? 1.0 : 0.5,
                      duration: Duration(milliseconds: 200),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.calendar_today),
                          Text(
                            "Demnächst",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
