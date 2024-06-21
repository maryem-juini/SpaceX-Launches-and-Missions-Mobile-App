import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/Components/Bottom.dart';
import 'package:project/Components/CardLaunch.dart';
import 'package:project/Components/CardMission.dart';
import 'package:project/Components/Header.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  Future<List<dynamic>> getLaunchesAndMissions(String category) async {
    var box = await Hive.openBox('myBox');
    var response = await http.get(Uri.parse('https://api.spacexdata.com/v3/$category'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      await box.put(category, jsonData);
      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: HeaderScreen(),
        bottomNavigationBar: BottomPage(selectedIndex: 1),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Launches',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 27, 78),
                ),
              ),
              Expanded(
                child: Container(
                  height: size.height * 0.3,
                  child: FutureBuilder<List<dynamic>>(
                    future: getLaunchesAndMissions('launches'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No data found'));
                      } else {
                        var categoryDetails = snapshot.data!;
                        return ListView.builder(
                          itemCount: categoryDetails.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var idLaunch = categoryDetails[index]['flight_number'];
                            var title = categoryDetails[index]['mission_name'];
                            var imageLink = categoryDetails[index]['links']['mission_patch'];
                            return ItemLaunch(
                              idLaunch: idLaunch,
                              title: title,
                              imageLink: imageLink,
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Missions',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 27, 78),
                ),
              ),
              Expanded(
                child: Container(
                  height: size.height * 0.3,
                  child: FutureBuilder<List<dynamic>>(
                    future: getLaunchesAndMissions('missions'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No data found'));
                      } else {
                        var categoryDetails = snapshot.data!;
                        return ListView.builder(
                          itemCount: categoryDetails.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var idMission = categoryDetails[index]['mission_id'];
                            var title = categoryDetails[index]['mission_name'];
                            var description = categoryDetails[index]['description'];
                            return ItemMission(
                              idMission: idMission,
                              title: title,
                              description: description,
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
