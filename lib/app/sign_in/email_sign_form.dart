import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/validators.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_alret_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

enum EmailFormType { sigIn, register }

class EmailForm extends StatefulWidget with EmailAndPasswordValidators {
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passowrdNode = FocusNode();
  bool _submitted = false;
  bool _isLoading = false;

  EmailFormType _formType = EmailFormType.sigIn;

  void _toggleFormTyple() {
    setState(() {
      _submitted = false;
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
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    //todo
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      if (_formType == EmailFormType.sigIn) {
        await auth.signInWithEmail(_emailValue, _passwordValue);
      } else {
        await auth.createUser(_emailValue, _passwordValue);
      }
      Navigator.of(context).pop();
    } catch (e) {
      showAlertDialog(context,
          title: 'Sign in failed',
          content: e.toString(),
          defaultActionText: 'OK');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus =
        widget.emailValidator.isValid(_emailValue) ? _passowrdNode : _emailNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  Widget _buildEmail() {
    bool showError = _submitted && !widget.emailValidator.isValid(_emailValue);
    return TextField(
      controller: _email,
      focusNode: _emailNode,
      decoration: InputDecoration(
        errorText: showError ? widget.invalidEmailText : null,
        border: OutlineInputBorder(),
        labelText: 'Email',
        hintText: 'Enter your email you@example.com',
        enabled: !_isLoading,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (_emailValue) => updateState(),
      onEditingComplete: _emailEditingComplete,
    );
  }

  Widget _buildpassword() {
    bool showError =
        _submitted && !widget.passwordValidator.isValid(_passwordValue);

    return TextField(
      controller: _password,
      focusNode: _passowrdNode,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
        errorText: showError ? widget.invalidPasswordText : null,
        enabled: !_isLoading,
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
    bool submitEnabled = widget.emailValidator.isValid(_emailValue) &&
        widget.emailValidator.isValid(_passwordValue) &&
        !_isLoading;
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
        onPressed: !_isLoading ? _toggleFormTyple : null,
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
