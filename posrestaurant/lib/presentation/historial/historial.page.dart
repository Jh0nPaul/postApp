import 'package:flutter/material.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({super.key});

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  late ThemeData theme;
  late Size size;
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;
    return Container(
      color: Colors.red,
      width: size.width,
      height: size.height,

    );
  }
}
