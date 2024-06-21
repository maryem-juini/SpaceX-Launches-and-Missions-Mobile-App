import 'package:flutter/material.dart';
import 'package:project/Components/Bottom.dart';
import 'package:project/Components/Header.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CardLaunchScreen extends StatefulWidget {
  final int idLaunch;
  const CardLaunchScreen({Key? key, required this.idLaunch}) : super(key: key);

  @override
  State<CardLaunchScreen> createState() => _CardLaunchScreenState();
}

class _CardLaunchScreenState extends State<CardLaunchScreen> {

  Future<Map<String, dynamic>> getLaunch() async {
    final response = await http.get(
      Uri.parse('https://api.spacexdata.com/v3/launches/${widget.idLaunch}'),
    );
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
        future: getLaunch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data found'));
          } else {
            var launch = snapshot.data!;
            String title = launch['mission_name'] ?? '';
            String launchDateUtc = launch['launch_date_utc']?.toString() ?? '';
            String imageLink = launch['links']['mission_patch'] ?? '';
            String details = launch['details'] ?? '';
            String youtubeId = launch['links']['youtube_id'] ?? '';

            YoutubePlayerController _controller = YoutubePlayerController(
              initialVideoId: youtubeId,
            );

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
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Launch date UTC : $launchDateUtc",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: const Color.fromARGB(255, 1, 61, 111),
                        ),
                      ),
                      SizedBox(height: 20),
                      Image.network(
                        imageLink,
                        height: 200,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Details :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: const Color.fromARGB(255, 1, 61, 111),
                        ),
                      ),
                      Text(
                        details,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 20),
                      YoutubePlayer(
                        controller: _controller,
                        liveUIColor: Colors.amber,
                      ),
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
