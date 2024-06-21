import 'package:flutter/material.dart';
import 'package:project/Components/Bottom.dart';
import 'package:project/Components/ButtonStyles.dart';
import 'package:project/Components/Header.dart';
import 'package:project/Screens/ExploreScreen/ExplorePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: HeaderScreen(),
        bottomNavigationBar: BottomPage(selectedIndex: 0),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Welcome to SpaceX Reports !',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E232C),
                  ),
                ),
                SizedBox(height: 20),
                Image.asset(
                  'assets/home-pic.png',
                  width: size.width * 0.45,
                  height: size.height * 0.25,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20),
                Text(
                  '“Space Exploration Technologies“',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF06094C),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'SpaceX was the first private company to successfully launch and return a spacecraft from Earth orbit and the first to launch a crewed spacecraft and dock it with the International Space Station (ISS). Headquarters are in Hawthorne, California.',
                  style:
                      TextStyle(color: const Color.fromARGB(255, 99, 99, 99)),
                ),
                Text(
                  'In this Application, you can explore the latest launches and missions of SpaceX. You can also search for specific launches and missions.',
                  style:
                      TextStyle(color: const Color.fromARGB(255, 99, 99, 99)),
                ),
                SizedBox(height: 40),
                CustomButton(
                  text: 'Start Exploring',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExplorePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
