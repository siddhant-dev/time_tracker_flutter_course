import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_form.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  final AuthBase auth;

  const EmailSignInPage({
    Key key,
    @required this.auth,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          child: EmailForm(
            auth: auth,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}