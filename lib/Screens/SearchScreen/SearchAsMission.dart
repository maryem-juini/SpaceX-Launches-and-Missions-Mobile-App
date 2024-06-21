import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/Screens/ExploreScreen/CardMissionScreen.dart';

class SearchAsMission extends StatelessWidget {
  final String missionName;
  const SearchAsMission({Key? key, required this.missionName}) : super(key: key);

  Future<Map<String, dynamic>> getMissionByName(String missionName) async {
    var response = await http.get(Uri.parse('https://api.spacexdata.com/v3/missions'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var mission = jsonData.firstWhere(
          (mission) => mission['mission_name'] == missionName,
          orElse: () => {});
      return mission;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: getMissionByName(missionName),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No mission found with the provided name'));
          } else {
            var mission = snapshot.data!;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CardMissionScreen(idMission: mission['mission_id']),
                ),
              );
            });
            return Container(); 
          }
        },
      ),
    );
  }
}
