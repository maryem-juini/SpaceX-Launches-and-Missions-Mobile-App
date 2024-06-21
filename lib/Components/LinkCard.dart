import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkCard extends StatelessWidget {
  final String link;
  const LinkCard({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launch(link),
      child: Text(
        link,
        style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none),
      ),
    );
  }
}
