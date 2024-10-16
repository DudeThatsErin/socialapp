import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routing/app_router.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter bindings are initialized
  final initialRoute = Uri.base.path;
  final queryParams = Uri.base.queryParameters;

  runApp(
    App(initialRoute: initialRoute, initialParams: queryParams),
  );
}

const ColorScheme flexSchemeLight = ColorScheme.light(
  brightness: Brightness.light,
  primary: Color(0xff004881),
  onPrimary: Color(0xff000000),
  primaryContainer: Color(0xffeaddff),
  onPrimaryContainer: Color(0xff131214),
  secondary: Color(0xff625b71),
  onSecondary: Color(0xff767676),
  secondaryContainer: Color(0xffe8def8),
  onSecondaryContainer: Color(0xff131214),
  tertiary: Color(0xffE7E3E3),
  onTertiary: Color(0xff818181),
  tertiaryContainer: Color(0xffffd8e4),
  onTertiaryContainer: Color(0xff141213),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff141212),
  background: Color(0xffFAF9F6),
  onBackground: Color(0xff090909),
  surface: Color(0xfffafafc),
  onSurface: Color(0xff090909),
  surfaceVariant: Color(0xffe6e5e9),
  onSurfaceVariant: Color(0xff121112),
  outline: Color(0xff7c7c7c),
  outlineVariant: Color(0xffc8c8c8),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff131215),
  onInverseSurface: Color(0xfff5f5f5),
  inversePrimary: Color(0xfff0e9ff),
  surfaceTint: Color(0xff6750a4),
);

const ColorScheme flexSchemeDark = ColorScheme.dark(
  brightness: Brightness.dark,
  primary: Color(0xff1c3579),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xff1c3579),
  onPrimaryContainer: Color(0xffece8f5),
  secondary: Color(0xff1a3a6e),
  onSecondary: Color(0xff9c9c9c),
  secondaryContainer: Color(0xff4a4458),
  onSecondaryContainer: Color(0xffebeaed),
  tertiary: Color(0xff818181),
  onTertiary: Color(0xff141213),
  tertiaryContainer: Color(0xff633b48),
  onTertiaryContainer: Color(0xffefe9eb),
  error: Color(0xffcf6679),
  onError: Color(0xff141211),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xfff6dfe1),
  background: Color(0xff1a191d),
  onBackground: Color(0xffedeced),
  surface: Color(0xff1a191d),
  onSurface: Color(0xffedeced),
  surfaceVariant: Color(0xff424046),
  onSurfaceVariant: Color(0xffe1e1e1),
  outline: Color(0xff7d767d),
  outlineVariant: Color(0xff2e2c2e),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xfffcfbff),
  onInverseSurface: Color(0xff131314),
  inversePrimary: Color(0xff685f77),
  surfaceTint: Color(
      0xff00060b), // pop up box colors; color works with the blue color of links
);

class App extends StatefulWidget {
  final String initialRoute;
  final Map<String, String> initialParams;
  const App(
      {required this.initialRoute, required this.initialParams, super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String? jwt; // Store the JWT token here
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = appRouter(context, _updateJwt, widget.initialParams);
  }

  // Function to update JWT token
  void _updateJwt(String jwt) {
    // Implement your logic to update JWT token here
    print('Updated JWT token: $jwt');
  }

  bool useMaterial3 = true;
  ThemeMode themeMode = ThemeMode.system;
  ColorScheme? imageColorScheme = const ColorScheme.light();

  bool get useLightMode => switch (themeMode) {
        ThemeMode.system =>
          View.of(context).platformDispatcher.platformBrightness ==
              Brightness.light,
        ThemeMode.light => true,
        ThemeMode.dark => false
      };

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: true,
      title: 'Company',
      themeMode: themeMode,
      theme: ThemeData.from(
          colorScheme: flexSchemeLight,
          textTheme: TextTheme(
              displayLarge: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                fontFamily: 'oswaldstencil',
                color: Colors.black,
              ),
              displayMedium: TextStyle(
                fontFamily: 'fashionista',
                fontSize: 50,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
              displaySmall: TextStyle(
                fontFamily: 'lato',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              bodyLarge: TextStyle(fontFamily: 'lato'),
              bodyMedium: TextStyle(fontFamily: 'lato'),
              bodySmall: TextStyle(fontFamily: 'lato'),
              headlineLarge: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'oswaldstencil'),
              headlineMedium: TextStyle(
                fontFamily: 'fashionista',
                fontSize: 50,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
              headlineSmall: TextStyle(
                fontFamily: 'lato',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ))),
      darkTheme: ThemeData.from(
          colorScheme: flexSchemeDark,
          textTheme: TextTheme(
              displayLarge: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'oswaldstencil'),
              displayMedium: TextStyle(
                fontFamily: 'fashionista',
                fontSize: 50,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
              displaySmall: TextStyle(
                fontFamily: 'lato',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              bodyLarge: TextStyle(fontFamily: 'lato'),
              bodyMedium: TextStyle(fontFamily: 'lato'),
              bodySmall: TextStyle(fontFamily: 'lato'),
              headlineLarge: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                fontFamily: 'oswaldstencil',
                color: Colors.white,
              ),
              headlineMedium: TextStyle(
                fontFamily: 'fashionista',
                fontSize: 50,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
              headlineSmall: TextStyle(
                fontFamily: 'lato',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ))),
    );
  }
}
