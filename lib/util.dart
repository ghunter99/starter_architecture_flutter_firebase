class util {
  static bool isEmail(String emailStr) {
    if (emailStr == null) {
      return false;
    }
    final emailRegex = RegExp(
        r'''^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$''');
    if (!emailRegex.hasMatch(emailStr)) {
      return false;
    }
    final emailRegex2 = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!emailRegex2.hasMatch(emailStr)) {
      return false;
    }
    return true;
  }

  static String emailValidator(String str) {
    if (!util.isEmail(str.trim())) {
      return 'Please enter a valid email\n';
    }
    return null;
  }

  static String passwordValidator(String str) {
    if (str.length < 8) {
      return 'Password must have at least 8 characters\n';
    }
    if (str.length > 25) {
      return 'Password can have at most 25 characters\n';
    }
    return null;
  }

  static String firstNameValidator(String name) {
    // check length
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      return 'Please enter first name\n';
    }
    if (trimmedName.length > 35) {
      return 'Name can have at most 35 characters\n';
    }
    // check doesn't contain special characters or emoji
    // except for hyphen, single quote, apostrophe or period characters
    final str1 = trimmedName
        .replaceAll('-', '')
        .replaceAll("'", '')
        .replaceAll('’', '')
        .replaceAll('.', '');
    final str2 = trimmedName.replaceAll(RegExp(r'(_|[^\w\s])+'), '');
    if (str1 == str2) {
      return null;
    }
    return 'Name can not contain special characters or emoji';
  }

  static String lastNameValidator(String name) {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      return 'Please enter last name\n';
    }
    if (trimmedName.length > 35) {
      return 'Name can have at most 35 characters\n';
    }
    // check doesn't contain special characters or emoji
    // except for hyphen, single quote, apostrophe or period characters
    final str1 = trimmedName
        .replaceAll('-', '')
        .replaceAll("'", '')
        .replaceAll('’', '')
        .replaceAll('.', '');
    final str2 = trimmedName.replaceAll(RegExp(r'(_|[^\w\s])+'), '');
    if (str1 == str2) {
      return null;
    }
    return 'Name can not contain special characters or emoji';
  }

  static String stripFirebaseHeaderFromMessage(String message) {
    String result = message;
    if (result != null && result.contains(']')) {
      final list = result.split(']');
      if (list.length == 2 && list[1].length > 0) {
        result = list[1];
      }
    }
    return result;
  }
}
