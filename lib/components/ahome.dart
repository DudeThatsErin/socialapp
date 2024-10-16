import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:buildexpousa/universal/app_bar.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 730;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1190 &&
      MediaQuery.of(context).size.width >= 730;

  static bool isWeb(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1190;
}

class AttendeesHome extends StatelessWidget {
  const AttendeesHome({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar(title: title),
      drawer: MyDrawer(),
      body: Responsive.isWeb(context)
          ? _Desktop()
          : Responsive.isTablet(context)
              ? _Tablet()
              : _Mobile(),
    );
  }
}

class _Desktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    return SafeArea(
        child: Center(
      child: SizedBox(
        height: 500,
        width: 500,
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: InkWell(
                      onTap: () => context.go('/schedule'),
                      highlightColor: theme.highlightColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.calendar_month,
                                  size: 80.0,
                                  color: color.primary,
                                ),
                              ),
                            ),
                            Text(
                              'View Your Schedule',
                              style: theme.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(color: color.tertiary),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: InkWell(
                      onTap: () => context.go('/schedule'),
                      highlightColor: theme.highlightColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.school,
                                  size: 80.0,
                                  color: color.primary,
                                ),
                              ),
                            ),
                            Text(
                              'Sign up for Classes',
                              style: theme.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(color: color.tertiary),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: InkWell(
                      onTap: () => context.go('/schedule'),
                      highlightColor: theme.highlightColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.people,
                                  size: 80.0,
                                  color: color.primary,
                                ),
                              ),
                            ),
                            Text(
                              '+ More Attendees',
                              style: theme.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(color: color.tertiary),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: InkWell(
                      onTap: () => context.go('/schedule'),
                      highlightColor: theme.highlightColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.badge,
                                  size: 80.0,
                                  color: color.primary,
                                ),
                              ),
                            ),
                            Text(
                              'View Your Badge',
                              style: theme.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class _Tablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: SizedBox(
        height: 500,
        width: 500,
        child: Column(
          children: [
            Text('Attendees Tablet Homepage - This text will be removed',
                style: Theme.of(context).textTheme.displaySmall),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: InkWell(
                      onTap: () => context.go('/schedule'),
                      highlightColor: Theme.of(context).highlightColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.calendar_month,
                                  size: 80.0,
                                ),
                              ),
                            ),
                            Text(
                              'View Your Schedule',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(color: Colors.white),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: InkWell(
                      onTap: () => context.go('/schedule'),
                      highlightColor: Theme.of(context).highlightColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.calendar_month,
                                  size: 80.0,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                            Text(
                              'View Your Schedule',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(color: Colors.white),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: InkWell(
                      onTap: () => context.go('/schedule'),
                      highlightColor: Theme.of(context).highlightColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.calendar_month,
                                  size: 80.0,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                            Text(
                              'View Your Schedule',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(color: Colors.white),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: InkWell(
                      onTap: () => context.go('/schedule'),
                      highlightColor: Theme.of(context).highlightColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.calendar_month,
                                  size: 80.0,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                            Text(
                              'View Your Schedule',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class _Mobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
        child: Center(
      child: Center(
        child: SizedBox(
          width: 275,
          height: 675,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () => context.go('/schedule'),
                  highlightColor: Theme.of(context).highlightColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.calendar_month,
                            size: 60.0,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          'Schedule',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: theme.colorScheme.tertiary,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () => context.go('/schedule'),
                  highlightColor: Theme.of(context).highlightColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.school,
                            size: 60.0,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          'Education',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: theme.colorScheme.tertiary,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () => context.go('/schedule'),
                  highlightColor: Theme.of(context).highlightColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.people,
                            size: 60.0,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          'Team',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: theme.colorScheme.tertiary,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () => context.go('/schedule'),
                  highlightColor: Theme.of(context).highlightColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.badge,
                            size: 60.0,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          'Badge',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
