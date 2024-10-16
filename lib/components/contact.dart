import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _emailController,
      _subjectController,
      _bodyController,
      _nameController;
  String email = "info@buildexpousa.com";

  final smtpServer = SmtpServer('smtp.hostinger.com',
      port: 465, ssl: true, name: 'Build Expo USA');

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _subjectController = TextEditingController();
    _bodyController = TextEditingController();
  }

  Future<void> sendEmail() async {
    final theme = Theme.of(context);
    final loading = theme.colorScheme.onBackground;
    var connection = PersistentConnection(smtpServer);

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Sending Email...'),
        backgroundColor: loading,
      ));
    }

    final message = Message()
      ..from = Address(_emailController.text, _nameController.text)
      ..recipients.add(email)
      ..subject = _subjectController.text
      ..text = _bodyController.text;

    try {
      final sendReport = await connection.send(message);
      print('Message Sent: $sendReport');
    } on MailerException catch (e) {
      print('Message not sent.');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Message not sent.'),
        backgroundColor: Colors.red.shade300,
      ));
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

    await connection.close();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
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
              'Contact Us',
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
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    enableSuggestions: true,
                    cursorHeight: 25,
                    strutStyle: StrutStyle(height: 2),
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      icon: Icon(Icons.person),
                      labelStyle: TextStyle(
                        color: color.onPrimary,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first and last name.';
                      }
                      return null;
                    },
                    autofocus: true,
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
                        return 'Please enter your email address.';
                      }
                      return null;
                    },
                    autofocus: true,
                  ),
                  TextFormField(
                    controller: _subjectController,
                    enableSuggestions: true,
                    cursorHeight: 25,
                    strutStyle: StrutStyle(height: 2),
                    decoration: InputDecoration(
                      labelText: 'Subject',
                      icon: Icon(Icons.title),
                      labelStyle: TextStyle(
                        color: color.onPrimary,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the subject line of the email.';
                      }
                      return null;
                    },
                    autofocus: true,
                  ),
                  TextFormField(
                    controller: _bodyController,
                    enableSuggestions: true,
                    maxLines: 4,
                    cursorHeight: 25,
                    strutStyle: StrutStyle(height: 2),
                    decoration: InputDecoration(
                      labelText: 'Body',
                      icon: Icon(Icons.subject),
                      labelStyle: TextStyle(
                        color: color.onPrimary,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the subject line of the email.';
                      }
                      return null;
                    },
                    autofocus: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(color.primary),
                    ),
                    onPressed: sendEmail,
                    child: Text(
                      'Send',
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
        ),
      ),
    );
  }
}
