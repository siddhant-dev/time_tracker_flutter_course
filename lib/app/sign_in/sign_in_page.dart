import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class SignInPage extends StatelessWidget {
  Future<void> _signInAnonymously(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      final u = await auth.signInAnonymously();
      print(u);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _googleSignIn(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      final u = await auth.googleSignIn();
      print(u);
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Time Tracker"),
        ),
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
            onPressed: () => _googleSignIn(context),
          ),
          SizedBox(
            height: 16.0,
          ),
          CustomRaisedButton(
            label: 'Sign in with Email',
            color: Colors.teal[700],
            onPrimary: Colors.teal[50],
            height: 50.0,
            onPressed: () => _signInWithEmail(context),
          ),
          SizedBox(
            height: 16.0,
          ),
          CustomRaisedButton(
            label: 'Sign Annomusly',
            color: Colors.yellow[700],
            onPrimary: Colors.black87,
            height: 50.0,
            onPressed: () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }
}
