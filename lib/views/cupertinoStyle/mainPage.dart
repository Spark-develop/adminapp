import 'package:adminproto1/styles/theme/textStyle.dart';
import 'package:flutter/cupertino.dart';

class MainPager extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPager> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
            backgroundColor: Color(0xFF5165E0),
            activeColor: CupertinoColors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.ellipsis), title: Text("Home")),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.collections_solid),
                  title: Text("Services")),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.loop_thick),
                  title: Text("Call History")),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.gear_big), title: Text("Profile")),
            ]),
        tabBuilder: (BuildContext context, int index) {
          if (index == 0) {
            // return CupertinoTabView(builder: (BuildContext context) {
            return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  border: Border(bottom: BorderSide.none),
                  backgroundColor: Color(0xFF64B3EC),
                  trailing: Icon(
                    CupertinoIcons.info,
                    color: CupertinoColors.white,
                    size: 20,
                  ),
                  middle: Center(
                    child: Text(
                      "Home",
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navTitleTextStyle
                          .copyWith(
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF64B3EC), Color(0xFF5165E0)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  child: homeUserIntro(context),
                ));
          } else if (index == 1) {
            return Container(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF64B3EC), Color(0xFF5165E0)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ));
          } else if (index == 2) {
            return Container(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF64B3EC), Color(0xFF5165E0)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ));
          } else {
            return Container(
                child: homeUserIntro(context),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF64B3EC), Color(0xFF5165E0)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ));
          }
        });
  }

  Widget homeUserIntro(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0),
      child: Column(
        children: <Widget>[
          Container(
            child: Icon(
              CupertinoIcons.check_mark,
              size: 70,
              color: CupertinoColors.white,
            ),
            alignment: Alignment.centerLeft,
          ),
          Container(
            child: Text(
              'Hello, User',
              style: userIntroName,
            ),
            alignment: Alignment.centerLeft,
          ),
          Container(
            child: Text(
              'This is a user description area..',
              style: userIntroDes,
            ),
            alignment: Alignment.centerLeft,
          ),
          Container(
            child: Text(
              'TIME :' ,
              // DateTime.now().toLocal().timeZoneOffset.toString(),
              style: homePageTime,
            ),
            padding: EdgeInsets.only(top: 28),
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
    );
  }
}
