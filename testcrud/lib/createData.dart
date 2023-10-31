import 'package:flutter/material.dart';

class createData extends StatelessWidget {
  const createData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          Icon(Icons.home),
        ]),
        body: Text("Welcome"));
  }
}
