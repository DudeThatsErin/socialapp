import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:buildexpousa/universal/app_bar.dart';

class ExhibitorsHome extends StatelessWidget {
  const ExhibitorsHome({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    return Scaffold(
      appBar: Bar(title: title),
      drawer: MyDrawer(),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: InkWell(
            onTap: () => context.go('/qr'),
            highlightColor: theme.highlightColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.qr_code_scanner,
                        size: 100.0,
                        color: color.primary,
                      ),
                    ),
                  ),
                  Text(
                    'Scan QR',
                    style: theme.textTheme.displaySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
