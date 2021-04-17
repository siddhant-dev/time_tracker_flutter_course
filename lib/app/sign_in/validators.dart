abstract class StringValidator {
  bool isValid(String val);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String val) {
    return val.isNotEmpty;
  }
}
