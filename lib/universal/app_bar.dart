import 'package:buildexpousa/universal/api_client.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './responsive.dart';

class _FontSize extends StatelessWidget {
  const _FontSize(
      {required this.text, required this.textColor, required this.family});
  final String text;
  final Color textColor;
  final String family;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: textColor,
          fontFamily: family,
          fontSize: Responsive.isWeb(context)
              ? 20
              : Responsive.isTablet(context)
                  ? 15
                  : 10,
        ));
  }
}

class Bar extends StatelessWidget implements PreferredSizeWidget {
  const Bar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness:
              isDarkMode ? Brightness.dark : Brightness.light,
          statusBarColor: Theme.of(context).primaryColorDark),
      toolbarHeight: 1000,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      automaticallyImplyLeading: true,
      title: Text(
        title,
        style: TextStyle(fontFamily: 'oswaldstencil', color: Colors.white),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
      actions: [
        _ProfileDropDown(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MyDrawer extends StatelessWidget {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      elevation: 3,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: Platform.isAndroid
                        ? 100
                        : Platform.isIOS
                            ? 130
                            : 100,
                    width: 20,
                    child: buildHeader(context),
                  ),
                  buildProfile(context),
                  _DrawerTile(
                    leading: const Icon(Icons.star),
                    title: _Page(
                      name: 'Favorites',
                      url: 'favorites',
                    ),
                  ),
                  _DrawerTile(
                    // TODO: Show number of notifications & Go to a notifications page that just lists all notifications read or unread for the last 7 days.
                    leading: const Icon(Icons.mail),
                    title: _Page(
                      name: 'Notifications',
                      url: 'notifs',
                    ),
                  ),
                  _Divider(text: 'Show Guide'),
                  _DrawerTile(
                    leading: const Icon(Icons.home),
                    title: _Page(
                      name: 'Home',
                      url: '/',
                    ),
                  ),
                  _DrawerTile(
                    leading: const Icon(Icons.calendar_month),
                    title: _Page(
                      name: 'Schedule',
                      url: '/schedule',
                    ),
                  ),
                  _DrawerTile(
                    leading: const Icon(Icons.people_alt),
                    title: _Page(
                      name: 'Exhibitors',
                      url: '/exhibitors',
                    ),
                  ),
                  _DrawerTile(
                    leading: const Icon(Icons.school),
                    title: _Page(
                      name: 'Education',
                      url: 'education',
                    ),
                  ),
                  _DrawerTile(
                    leading: const Icon(Icons.people),
                    title: _Page(
                      name: 'Attendees',
                      url: 'attendees',
                    ),
                  ),
                  _DrawerTile(
                    leading: const Icon(Icons.location_pin),
                    title: _Page(
                      name: 'Maps',
                      url: 'maps',
                    ),
                  ),
                  _DrawerTile(
                    leading: const Icon(Icons.info),
                    title: _Page(name: 'Show Info', url: 'info'),
                  ),
                  _DrawerTile(
                    leading: const Icon(Icons.checklist),
                    title: _Page(
                      name: 'Safety & Security',
                      url: 'safety-security',
                    ),
                  ),
                  _DrawerTile(
                    leading: const Icon(Icons.car_rental),
                    title: _Page(
                      name: 'Transportation',
                      url: 'transport',
                    ),
                  ),
                  AboutListTile(
                    icon: Icon(Icons.info),
                    applicationIcon: Icon(Icons.handyman),
                    applicationName: 'Company',
                    applicationVersion: '1.0.0',
                    applicationLegalese:
                        '© 2024 Company Inc',
                    // aboutBoxChildren: [
                    //   Text(
                    //     'Child Text or about the app here, good for debugging stuff.',
                    //   ),
                    // ],
                    child: Text('About Company',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  _Divider(text: 'Development'),
                ]),
          ),
        ),
      ),
    );
  }

  DrawerHeader buildHeader(BuildContext context) {
    return DrawerHeader(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              './assets/images/BuildExpo_Icon_White.png',
              height: 25,
              fit: BoxFit.scaleDown,
            ),
          ),
          _FontSize(
            text: 'Build Expo USA',
            family: 'oswaldstencil',
            textColor: Colors.white,
          ),
        ]));
  }

  ListTile buildProfile(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.account_circle,
      ),
      title: Text(
        'Erin Skidds',
        // TODO: GET USER INFO (NAME) FROM API WITH MINIORANGE PLUGIN.
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: () => context.go('/profile'),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;

  const _DrawerTile({this.leading, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading ?? const SizedBox(width: 28, height: 28),
      title: title,
      onTap: () => context.go('$title'),
    );
  }
}

// drop down for profile in appbar
class _ProfileDropDown extends StatelessWidget {
  final storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future:
          storage.read(key: 'access_token'), // Get the JWT token asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the future to complete, show a loading indicator
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If there's an error while fetching the JWT token, show an error message
          return Text('Error: ${snapshot.error}');
        } else {
          // If the future has completed successfully, show the PopupMenuButton
          String? jwt = snapshot.data;
          return PopupMenuButton<int>(
            offset: Offset(50.0, 40.0),
            tooltip: 'Your Profile',
            onSelected: (value) async {
              switch (value) {
                case 1:
                  context.go('/profile');
                case 2:
                  context.go('/forgotpw');
                case 3:
                  // Logout action
                  await ApiClient().logout(jwt);
                  if (!context.mounted) return;
                  context.go('/login');
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 1,
                  child: Text('Erin Skidds'),
                ),
                PopupMenuDivider(),
                PopupMenuItem<int>(
                  value: 2,
                  child: Text('Update Password'),
                ),
                PopupMenuItem<int>(
                  value: 3,
                  child: Text('Logout'),
                ),
              ];
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: const Icon(Icons.account_circle),
            ),
          );
        }
      },
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff004881),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}

class _Page extends StatelessWidget {
  const _Page({required this.name, required this.url});
  final String name;
  final String url;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go(url),
      child: Text(
        name,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
