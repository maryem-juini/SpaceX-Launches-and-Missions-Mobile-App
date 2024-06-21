import 'package:flutter/material.dart';
import 'package:project/Screens/ExploreScreen/CardLaunchScreen.dart';

class ItemLaunch extends StatelessWidget {
  final int idLaunch;
  final String title;
  final String imageLink;

  const ItemLaunch({
    Key? key,
    required this.idLaunch,
    required this.title,
    required this.imageLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardLaunchScreen(idLaunch: idLaunch),
          ),
        );
      },
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
              SizedBox(height: 20),
              Image.network(imageLink),
            ],
          ),
        ),
      ),
    );
  }
}
