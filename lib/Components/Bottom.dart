import 'package:flutter/material.dart';
import 'package:project/Screens/ExploreScreen/ExplorePage.dart';
import 'package:project/Screens/HomeScreen/HomePage.dart';
import 'package:project/Screens/SearchScreen/SearchPage.dart';

class BottomPage extends StatelessWidget {
  final int selectedIndex;

  const BottomPage({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 200, 200, 200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Icon(
                Icons.home_rounded,
                size: 35,
                color:
                    selectedIndex == 0 ? Color(0xFF06094C) : Color(0xffFBAA1B),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExplorePage()),
                );
              },
              child: Icon(
                Icons.explore_rounded,
                size: 35,
                color:
                    selectedIndex == 1 ? Color(0xFF06094C) : Color(0xffFBAA1B),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: Icon(Icons.search,
                  size: 35,
                  color: selectedIndex == 2
                      ? Color(0xFF06094C)
                      : Color(0xffFBAA1B)),
            ),
          ],
        ),
      ),
    );
  }
}
