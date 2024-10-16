import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:buildexpousa/universal/app_bar.dart';
import 'package:flutter/foundation.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 730;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1190 &&
      MediaQuery.of(context).size.width >= 730;

  static bool isWeb(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1190;
}

class DevHome extends StatelessWidget {
  const DevHome({super.key, required this.title, required this.accesstoken});
  final String title, accesstoken;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Bar(title: title),
        drawer: MyDrawer(),
        body: Column(
          children: [
            if (kDebugMode)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: ElevatedButton(
                      onPressed: () => context.push('/register'),
                      child: Text('Register Page'),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: ElevatedButton(
                    onPressed: () => context.push('/contact'),
                    child: Text('Contact Us Page'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: ElevatedButton(
                    onPressed: () => context.push('/attendees'),
                    child: Text('Attendees'),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
