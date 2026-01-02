import 'package:intl/intl.dart';

class Validation {
  static String? Function(String?) textValidation(String name) {
    return (String? value) {
      if (value!.isEmpty) {
        return "${name} is required field";
      }
      return null;
    };
  }

  static String? Function(String?) websiteUrlValidity(String name) {
    return (String? value) {
      if (value!.isEmpty) {
        return "${name} is required field";
      }
      String pattern =
          r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        return "$name must be valid";
      }
      return null;
    };
  }

  static String? Function(String?) wifiPasswordLengthValidation(String name) {
    return (String? value) {
      if (value!.isEmpty) {
        return "${name} is required field";
      }
      if (value.length < 8) {
        return "${name} must be greater or equal to 8";
      }
      if (value.length >= 12) {
        return "${name} must be less than 12 and greater or equal to 8";
      }
      return null;
    };
  }

  static String? Function(String?) dateTimeValidation(String name) {
    return (String? value) {
      if (value!.isEmpty) {
        return "${name} is required field";
      }

      final DateFormat format = DateFormat("dd MMM yyyy, hh:mm a","en_US");

      try {
        format.parseStrict(value);
        return null;
      } catch (e) {
        return "$name must be valid as hint text";
      }
    };
  }

  static String? Function(String?) phoneNumberValidity(String name) {
    return (String? value) {
      if (value!.isEmpty) {
        return "${name} is required field";
      }

      final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
      if (!phoneRegex.hasMatch(value)) {
        return "$name must be valid";
      }
      return null;
    };
  }

  static String? Function(String? value) emailValidity(String name) {
    return (String? value) {
      if (value!.isEmpty) {
        return "${name} is required field";
      }
      final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
      );
      if (!emailRegex.hasMatch(value)) {
        return "This field is only $name";
      }
      return null;
    };
  }

  static String? Function(String?) usernameValidity(String name) {
    return (String? value) {
      if (value!.isEmpty) {
        return "${name} is required field";
      }
      final usernameRegex = RegExp(r'^[a-zA-Z0-9_.]{3,20}$');
      if (!usernameRegex.hasMatch(value)) {
        return "$name must be valid";
      }
      return null;
    };
  }
}
