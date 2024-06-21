import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/Screens/ExploreScreen/CardLaunchScreen.dart';

class SearchAsLaunch extends StatelessWidget {
  final String missionName;
  const SearchAsLaunch({Key? key, required this.missionName}) : super(key: key);

  Future<Map<String, dynamic>?> getMissionByName(String missionName) async {
    try {
      var response = await http.get(Uri.parse('https://api.spacexdata.com/v3/launches'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body) as List;
        var launch = jsonData.firstWhere((launch) => launch['mission_name'].toString().toLowerCase() == missionName.toLowerCase(), orElse: () => null);
        return launch;
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Failed to load data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Launch'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getMissionByName(missionName),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No launch found with the provided name'));
          } else {
            var launch = snapshot.data!;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardLaunchScreen(idLaunch: launch['flight_number']),
                  ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
