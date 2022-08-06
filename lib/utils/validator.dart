class Validator {
  static String? validateEmail(String value) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    }
    return null;
  }

  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }

    final number = num.tryParse(s);
    if (number == null) {
      return false;
    }

    return true;
  }
}
