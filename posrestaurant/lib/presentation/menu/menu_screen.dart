import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  late ThemeData theme;
  late Size size;
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;
    return Container(

      width: size.width,
      height: size.height,

    );
  }
}
