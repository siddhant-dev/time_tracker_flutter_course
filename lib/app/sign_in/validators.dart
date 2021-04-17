abstract class StringValidator {
  bool isValid(String val);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String val) {
    return val.isNotEmpty;
  }
}

class EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String invalidEmailText = 'Please enter an email id';
  final String invalidPasswordText = 'Please enter your password';
}
