import 'package:flutter/material.dart';
import 'package:buildexpousa/universal/app_bar.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar(title: title),
      drawer: MyDrawer(),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Text(
            'Schedule Map will go here.',
          ),
        ),
      ),
    );
  }
}
