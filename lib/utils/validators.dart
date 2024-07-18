class Validator {
  

  static String? emptyField(
    String? value, {
    String message = 'Field cant"t be empty',
  }) {
    if (value!.isEmpty) {
      return message;
    } else {
      return null;
    }
  }


  static String? emailValidator(String? value) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regex = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Field cannot be blank';
    } else if (!regex.hasMatch(value)) {
      return 'Enter valid email address';
    }
    return null;
  }

}
