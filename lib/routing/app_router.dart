import 'package:buildexpousa/components/contact.dart';
import 'package:buildexpousa/components/ehome.dart';
import 'package:buildexpousa/components/forgot_pw.dart';
import 'package:buildexpousa/components/reg_form.dart';
import 'package:buildexpousa/universal/api_client.dart';
import 'package:buildexpousa/universal/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../components/dev_home.dart';
import '../components/login.dart';

typedef UpdateJwtFunction = void Function(String jwt);

BuildContext? _currentContext;

GoRouter appRouter(BuildContext context, UpdateJwtFunction updateJwt,
    Map<String, String> initialParams) {
  _currentContext = context;

  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => LoginForm(updateJwt: updateJwt),
      ),
      GoRoute(
        name: 'devHome/:accesstoken',
        path: '/devHome',
        builder: (context, state) {
          return DevHome(
            title: 'Dev Home',
            accesstoken: state.uri.queryParameters['token'] ?? '',
          );
        },
      ),
      GoRoute(
        name: 'register',
        path: '/register',
        builder: (context, state) => RegisterForm(),
      ),
      GoRoute(
        name: 'eHome',
        path: '/ehome',
        builder: (context, state) => ExhibitorsHome(title: 'Exhibitors Home'),
      ),
      GoRoute(
        name: 'forgotpwap',
        path: '/wpforgotpw',
        builder: (context, state) => ResetPassForm(),
      ),
      GoRoute(
        name: 'contact',
        path: '/contact',
        builder: (context, state) => ContactForm(),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      child: Scaffold(
        appBar: Bar(title: 'Page Not Found'),
        body: Center(
          child: Text('Page Not Found'),
        ),
      ),
    ),
  );
}

void navigateBasedOnTokenValidity(String jwt) async {
  BuildContext? context = _currentContext;

  if (context != null) {
    bool isValidToken = await ApiClient().validateToken(jwt);
    if (!context.mounted) return;
    if (isValidToken) {
      context.goNamed('/devHome', pathParameters: {'accesstoken': jwt});
    } else {
      context.go('/login');
    }
  }
}
