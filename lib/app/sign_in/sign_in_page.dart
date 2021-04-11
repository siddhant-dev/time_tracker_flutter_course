import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(),
      ),
      body: _buidlContext(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buidlContext(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50.0,
            child: Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          CustomRaisedButton(
            label: 'Sign in with Google',
            asset: 'images/google.png',
            color: Colors.white,
            onPrimary: Colors.black87,
            height: 50.0,
            onPressed: () {},
          ),
          SizedBox(
            height: 16.0,
          ),
          CustomRaisedButton(
            label: 'Sign in with Facebook',
            asset: 'images/facebook-logo.png',
            color: Colors.blue[800],
            onPrimary: Colors.blue[50],
            height: 50.0,
            onPressed: () {},
          ),
          SizedBox(
            height: 16.0,
          ),
          CustomRaisedButton(
            label: 'Sign in with Email',
            color: Colors.teal[700],
            onPrimary: Colors.teal[50],
            height: 50.0,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
