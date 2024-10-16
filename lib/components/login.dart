import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import '../universal/api_client.dart';
import '../universal/responsive.dart';

class LoginForm extends StatefulWidget {
  final void Function(String) updateJwt;
  const LoginForm({super.key, required this.updateJwt});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Future<void> loginUsers() async {
    final theme = Theme.of(context);
    final loading = theme.colorScheme.onBackground;
    if (_formKey.currentState!.validate()) {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: loading,
      ));

      // Attempt login
      try {
        Response res = await ApiClient().login(
          _usernameController.text,
          _passwordController.text,
        );

        // Extract data from the response
        dynamic responseData = res.data;
        print('res: $res');

        // Debug: print type of response data
        print('Response data: $responseData');

        // Check if response data is not null and is a Map
        if (responseData != null && responseData is Map) {
          // Check if login was successful
          if (responseData.containsKey('jwt_token')) {
            // Access the JWT token
            final storage = FlutterSecureStorage();
            await storage.write(
                key: 'access_token', value: responseData['jwt_token']);
            await storage.write(
                key: 'username', value: _usernameController.text);
            await storage.read(key: 'access_token');
            if (!mounted) return;
            context.goNamed('devHome/:accesstoken');
          } else {
            // Show error message if login was not successful or data is missing
            print('Error: Login unsuccessful or data is missing');
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              showCloseIcon: true,
              content: Text('You entered an incorrect username or password.'),
              backgroundColor: Colors.red.shade300,
            ));
          }
        } else {
          // Show error message if response format is unexpected
          print('Error: Unexpected response format');
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Unexpected response format'),
            backgroundColor: Colors.red.shade300,
          ));
        }
      } catch (e) {
        // Handle login error
        print('Login error: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red.shade300,
        ));
      } finally {
        // Hide loading indicator
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    // ignore: unused_local_variable
    String? pass;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness:
                isDarkMode ? Brightness.dark : Brightness.light,
            statusBarColor: theme.primaryColorDark),
        toolbarHeight: 60,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: color.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Image.asset(
                './assets/images/BuildExpo_Icon_White.png',
                height: 60.0,
                width: 60.0,
              ),
            ),
            Text(
              'Login',
              style: TextStyle(
                fontFamily: 'oswaldstencil',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Login with your WordPress username and password!',
                    style: TextStyle(
                      fontFamily: 'lato',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: _usernameController,
                enableSuggestions: true,
                cursorHeight: 25,
                strutStyle: StrutStyle(height: 2),
                decoration: InputDecoration(
                  labelText: 'Username',
                  icon: Icon(Icons.email),
                  labelStyle: TextStyle(
                    color: color.onPrimary,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                autofocus: true,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                cursorHeight: 25,
                strutStyle: StrutStyle(height: 2),
                decoration: InputDecoration(
                  icon: Icon(Icons.password),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: color.onPrimary,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    loginUsers;
                  }
                },
                onSaved: (input) => pass = input,
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(color.primary),
                ),
                onPressed: loginUsers,
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'oswaldstencil',
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Responsive.isWeb(context)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.pushNamed('forgotpwap');
                          },
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(
                              color: color.onPrimary,
                            ),
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            context.pushNamed('register');
                          },
                          child: Text(
                            'New User? Register now!',
                            style: TextStyle(
                              color: color.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Responsive.isTablet(context)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                context.pushNamed('forgotpwap');
                              },
                              child: Text(
                                'Forgot your password?',
                                style: TextStyle(
                                  color: color.onPrimary,
                                ),
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                context.pushNamed('register');
                              },
                              child: Text(
                                'New User? Register now!',
                                style: TextStyle(
                                  color: color.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                context.pushNamed('forgotpwap');
                              },
                              child: Text(
                                'Forgot your password?',
                                style: TextStyle(
                                  color: color.onPrimary,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            TextButton(
                              onPressed: () {
                                context.pushNamed('register');
                              },
                              child: Text(
                                'New User? Register now!',
                                style: TextStyle(
                                  color: color.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
