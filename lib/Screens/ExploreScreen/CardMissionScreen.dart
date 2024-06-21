import 'package:flutter/material.dart';
import 'package:project/Components/Bottom.dart';
import 'package:project/Components/Header.dart';
import 'package:project/Components/LinkCard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CardMissionScreen extends StatefulWidget {
  final String idMission;
  const CardMissionScreen({super.key, required this.idMission});

  @override
  State<CardMissionScreen> createState() => _CardMissionScreenState();
}

class _CardMissionScreenState extends State<CardMissionScreen> {
  Future<Map<String, dynamic>> getMission() async {
    var response = await http.get(Uri.parse('https://api.spacexdata.com/v3/missions/${widget.idMission}'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderScreen(),
      bottomNavigationBar: BottomPage(selectedIndex: 1),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getMission(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data found'));
          } else {
            var mission = snapshot.data!;
            String title = mission['mission_name'] ?? '';
            String description = mission['description'] ?? '';
            String wikipedia = mission['wikipedia'] ?? '';
            String website = mission['website'] ?? '';
            String twitter = mission['twitter'] ?? '';

            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Description :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: const Color.fromARGB(255, 1, 61, 111),
                            decoration: TextDecoration.none),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Useful Links :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: const Color.fromARGB(255, 1, 61, 111),
                            decoration: TextDecoration.none),
                      ),
                      LinkCard(link: wikipedia),
                      LinkCard(link: website),
                      LinkCard(link: twitter),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
