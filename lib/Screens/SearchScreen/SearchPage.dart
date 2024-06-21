import 'package:flutter/material.dart';
import 'package:project/Components/Bottom.dart';
import 'package:project/Components/ButtonStyles.dart';
import 'package:project/Components/Header.dart';
import 'package:project/Screens/SearchScreen/SearchAsLaunch.dart';
import 'package:project/Screens/SearchScreen/SearchAsMission.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController myController = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: HeaderScreen(),
        bottomNavigationBar: BottomPage(selectedIndex: 2),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    labelText: 'Type here to search...',
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      text: "Search as Launch",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchAsLaunch(missionName: myController.text),
                          ),
                        );
                      },
                    ),
                    CustomButton(
                      text: "Search as Mission",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchAsMission(missionName: myController.text),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
