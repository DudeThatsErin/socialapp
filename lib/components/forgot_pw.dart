import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../universal/api_client.dart';

class ResetPassForm extends StatefulWidget {
  @override
  State<ResetPassForm> createState() => _ResetPassFormState();
}

class _ResetPassFormState extends State<ResetPassForm> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  Future<void> reset() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Processing Data'),
          backgroundColor: Theme.of(context).colorScheme.onBackground,
        ),
      );

      try {
        Response res = await ApiClient().resetPwEmail(_emailController.text);
        dynamic responseData = res.data;
        print('Email Response data: $responseData');

        if (responseData != null && responseData['error'] != null) {
          // Handle expected error response from the server
          print('Error: ${responseData['error']}');
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: ${responseData['error']}'),
            backgroundColor: Colors.red.shade300,
          ));
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Reset Password Email Sent'),
            backgroundColor: Colors.green.shade300,
          ));
          await Future.delayed(Duration(seconds: 5));
          if (!mounted) return;
          GoRouter.of(context).pushNamed('login');
        }
      } catch (e) {
        // Handle exception
        print('Error: $e');
        if (e is DioException && e.response != null) {
          // Handle DioError with response (i.e., non-network error)
          print('Error response: ${e.response!.data}');
        } else {
          // Handle network error
          print('Network error: $e');
        }
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red.shade300,
        ));
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
              'Reset Password',
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
              SizedBox(height: 40.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(color.primary),
                ),
                onPressed: reset,
                child: Text(
                  'Reset Password',
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
    super.dispose();
  }
}
