import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../universal/api_client.dart';
import 'package:go_router/go_router.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Processing Data'),
          backgroundColor: Theme.of(context).colorScheme.onBackground,
        ),
      );

      try {
        Response res = await ApiClient().registerUser(
          _emailController.text,
          _passwordController.text,
          'mizzen-clone-bourse-YAM-squeegee-zest',
        );

        dynamic responseData = res.data;

        print('Register Response data: $responseData');

        if (responseData != null &&
            responseData is Map &&
            responseData.containsKey('success')) {
          // Check if login was successful
          if (responseData['success'] == true) {
            // Login was successful
            if (!mounted) return;
            context.goNamed('eHome');
          } else {
            // Login was not successful
            print(
                'Error: Login unsuccessful. Message: ${responseData['message']}');
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Error: Login unsuccessful. Message: ${responseData['message']}'),
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
        backgroundColor: color.primary,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
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
              'Register',
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
                    'This will be your BuildExpoUSA.com email and password!',
                    style: TextStyle(
                      fontFamily: 'lato',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: _emailController,
                enableSuggestions: true,
                cursorHeight: 25,
                strutStyle: StrutStyle(height: 2),
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  icon: Icon(Icons.email),
                  labelStyle: TextStyle(
                    color: color.onPrimary,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
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
                    register;
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
                onPressed: register,
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'oswaldstencil',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
