import 'package:adminproto1/styles/theme/colorStyle.dart';
import 'package:flutter/cupertino.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: CupertinoColors.white,
      // backgroundColor: CupertinoColors.systemGrey6,
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text("One"),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.time),
            title: Text("Call History"),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            title: Text("Profile"),
          )
        ],
      ),
      tabBuilder: (context, i) {
        if(true)
        return CupertinoPageScaffold(
          child: CupertinoFullscreenDialogTransition(animation: null, child: null),
          backgroundColor: bgColor,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.extraLightBackgroundGray,
            middle: Text("Middle"),),
          );
        // return Center(
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: CupertinoTextField(
        //       decoration: BoxDecoration(
        //         border: Border.all(
        //           color: CupertinoColors.systemGrey3,
        //           width: 1,
        //         ),
        //         borderRadius: BorderRadius.circular(18),
        //       ),
        //       placeholder: "Text",
        //       style: CupertinoTheme.of(context).textTheme.textStyle,
        //     ),
        //   ),
        // );
      },
    );
  }
}
