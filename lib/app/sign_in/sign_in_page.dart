import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_exception_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  void _showSignInError(BuildContext context, Exception exception) {
    showExceptionAlertDialog(
      context,
      title: 'Sign In',
      exception: exception,
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      setState(() => _isLoading == true);
      final u = await auth.signInAnonymously();
      print(u);
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading == false);
    }
  }

  Future<void> _googleSignIn(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      setState(() => _isLoading == true);
      final u = await auth.googleSignIn();
      print(u);
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading == false);
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
        children: <Widget>[
          SizedBox(
            height: 50.0,
            child: _buildHeader(),
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
            onPressed: _isLoading ? null : () => _googleSignIn(context),
          ),
          SizedBox(
            height: 16.0,
          ),
          CustomRaisedButton(
            label: 'Sign in with Email',
            color: Colors.teal[700],
            onPrimary: Colors.teal[50],
            height: 50.0,
            onPressed: _isLoading ? null : () => _signInWithEmail(context),
          ),
          SizedBox(
            height: 16.0,
          ),
          CustomRaisedButton(
            label: 'Sign Annomusly',
            color: Colors.yellow[700],
            onPrimary: Colors.black87,
            height: 50.0,
            onPressed: _isLoading ? null : () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
