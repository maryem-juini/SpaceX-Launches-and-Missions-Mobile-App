import 'package:flutter/material.dart';
import 'package:project/Screens/ExploreScreen/CardMissionScreen.dart';

class ItemMission extends StatelessWidget {
  final String idMission;
  final String title;
  final String description;

  const ItemMission({
    Key? key,
    required this.idMission,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CardMissionScreen(idMission: idMission),
        ),
      ),
      child: Card(
        color: Color.fromARGB(255, 198, 212, 250),
        child: Container(
          width: 150,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 65, 96),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
