import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

enum EmailFormType { sigIn, register }

class EmailForm extends StatefulWidget {
  final AuthBase auth;

  const EmailForm({
    Key key,
    @required this.auth,
  }) : super(key: key);
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passowrdNode = FocusNode();

  EmailFormType _formType = EmailFormType.sigIn;

  void _toggleFormTyple() {
    setState(() {
      _formType = _formType == EmailFormType.sigIn
          ? EmailFormType.register
          : EmailFormType.sigIn;
    });
    _email.clear();
    _password.clear();
  }

  String get _emailValue => _email.text;
  String get _passwordValue => _password.text;

  void _submit() async {
    //todo
    try {
      if (_formType == EmailFormType.sigIn) {
        await widget.auth.signInWithEmail(_emailValue, _passwordValue);
      } else {
        await widget.auth.createUser(_emailValue, _passwordValue);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passowrdNode);
  }

  Widget _buildEmail() {
    return TextField(
      controller: _email,
      focusNode: _emailNode,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email',
        hintText: 'Enter your email you@example.com',
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (_emailValue) => updateState(),
      onEditingComplete: _emailEditingComplete,
    );
  }

  Widget _buildpassword() {
    return TextField(
      controller: _password,
      focusNode: _passowrdNode,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
      ),
      obscureText: true,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      onChanged: (_passwordValue) => updateState(),
      onEditingComplete: _submit,
    );
  }

  List<Widget> _buildChildren() {
    final primaryText =
        _formType == EmailFormType.sigIn ? 'Sign In' : 'Create an Account';
    final secondaryText = _formType == EmailFormType.sigIn
        ? 'New User? Create an Account'
        : 'Already have an account? Login';
    bool submitEnabled = _emailValue.isNotEmpty && _passwordValue.isNotEmpty;
    return [
      _buildEmail(),
      SizedBox(
        height: 16.0,
      ),
      _buildpassword(),
      SizedBox(
        height: 16.0,
      ),
      CustomRaisedButton(
        label: primaryText,
        color: Colors.blue,
        onPressed: submitEnabled ? _submit : null,
        onPrimary: Colors.blue[50],
      ),
      SizedBox(
        height: 16.0,
      ),
      TextButton(
        onPressed: _toggleFormTyple,
        child: Text(secondaryText),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }

  updateState() {
    setState(() {});
  }
}
