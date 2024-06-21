import 'package:flutter/material.dart';

class HeaderScreen extends StatelessWidget implements PreferredSizeWidget{
  const HeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppBar(
      title: Image.asset('assets/logo.png', width: size.width * 0.3, height: size.height * 0.25),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 255, 217, 0),
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); 
}