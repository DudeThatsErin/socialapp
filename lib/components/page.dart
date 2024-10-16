// basic custom page that I can duplicate to create new pages.
import 'package:buildexpousa/universal/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar(title: title),
      drawer: MyDrawer(),
      body: Center(
        child: TextButton(
          onPressed: () => context.go('/'),
          child: const Text('Back'),
        ),
      ),
    );
  }
}
