import 'package:flutter/material.dart';
import 'package:instagram_clone/src/customIcons/custom_icons.dart';
import 'package:instagram_clone/src/screens/insta_favourite.dart';
import 'package:instagram_clone/src/screens/insta_gallery.dart';
import 'package:instagram_clone/src/screens/insta_profile.dart';
import 'package:instagram_clone/src/screens/insta_search.dart';
import 'package:instagram_clone/src/widgets/insta_activities.dart';

class InstaHome extends StatefulWidget {
  final Map<String, dynamic> response;
  InstaHome(this.response);
  @override
  _InstaHomeState createState() => _InstaHomeState();
}

class _InstaHomeState extends State<InstaHome> {
  //
  // Current active index of bottom navigation bar
  int currentIndex = 0;

  // Build function is responsible for rendering ui in home screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: [
        InstaActivities(
            widget.response), // insta_activities.dart inside widgets folder
        InstaSearch(),
        InstaGallery(),
        InstaFavourite(),
        InstaProfile(
          profileInfo: widget.response["AccountInfos"],
          profilePost: widget.response["ProfilePosts"],
        ),
      ][currentIndex],
      bottomNavigationBar: bottomNavBar(),
    );
  }

  // a == 1 ? true : false;

  Widget bottomNavBar() {
    final List<BottomNavigationBarItem> items = [
      // First item
      BottomNavigationBarItem(
        icon: Icon(currentIndex == 0
            ? CustomIcons.home_filled
            : CustomIcons.home_lineal), // I have used custom icon here
        title: Text(''),
      ),
      // Second item
      BottomNavigationBarItem(
        icon: Icon(
          currentIndex == 1
              ? CustomIcons.search_fill
              : CustomIcons.search_lineal,
        ),
        title: Text(''),
      ),
      // Third item
      BottomNavigationBarItem(
        icon: Icon(CustomIcons.add),
        title: Text(''),
      ),
      // Fourth item
      BottomNavigationBarItem(
        icon: Icon(currentIndex == 3
            ? CustomIcons.like_fill
            : CustomIcons.like_lineal),
        title: Text(''),
      ),
      // Fifth item
      BottomNavigationBarItem(
        icon: Icon(
          currentIndex == 4
              ? CustomIcons.people_fill
              : CustomIcons.profile_lineal,
        ),
        title: Text(''),
      ),
    ];

    return BottomNavigationBar(
      items: items,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      currentIndex: this.currentIndex, // to do
      iconSize: 24.0,
      // showSelectedLabels: false,
      // fixedColor: Colors.black,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedFontSize: 0.0,
      type: BottomNavigationBarType.fixed,
      elevation: 18.0,
      backgroundColor: Colors.white,
      // selectedIconTheme: IconThemeData(
      //   color: Colors.black,
      //   size: 20.0,
      // ),
      // unselectedIconTheme: IconThemeData(color: Colors.black),
    );
  }
}
