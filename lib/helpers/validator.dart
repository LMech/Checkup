// matching various patterns for kinds of data
class Validator {
  Validator();

  String? email(String? value) {
    const String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    final RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Please enter a valid email address.';
    } else {
      return null;
    }
  }

  String? password(String? value) {
    const String pattern = r'^.{6,}$';
    final RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Password must be at least 6 characters.';
    } else {
      return null;
    }
  }

  String? name(String? value) {
    const String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    final RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Please enter a name.';
    } else {
      return null;
    }
  }

  String? number(String? value) {
    const String pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    final RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Please enter a number.';
    } else {
      return null;
    }
  }

  String? amount(String? value) {
    const String pattern = r'^\d+$';
    final RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Please enter a number i.e. 250 - no dollar symbol and no cents';
    } else {
      return null;
    }
  }

  String? date(String? value) {
    const String pattern = r'^\S+$';
    // r'^([0-2][0-9]|(3)[0-1])(\/-)(((0)[0-9])|((1)[0-2]))(\/-)\d{4}$';
    final RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Please, enter a valid date format';
    } else {
      return null;
    }
  }

  String? notEmpty(String? value) {
    const String pattern = r'^\S+$';
    final RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'This is a required field.';
    } else {
      return null;
    }
  }
}
