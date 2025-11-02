import 'package:get/get.dart';

class Validation {
  static String? Function(String?) textValidation(String name) {
    return (String? value) {
      if (GetUtils.isNullOrBlank(value)!) {
        return "${name.tr} is required field";
      }
      return null;
    };
  }

  static String? Function(String?) websiteUrlValidity(String name) {
    return (String? value) {
      if (GetUtils.isNullOrBlank(value)!) {
        return "${name.tr} is required field";
      }
      if (!GetUtils.isURL(value!)) {
        return "$name must be valid";
      }
      return null;
    };
  }

  static String? Function(String?) wifiPasswordLengthValidation(
    String name,
    int minLength, {
    int? maxLength,
  }) {
    return (String? value) {
      if (GetUtils.isNullOrBlank(value)!) {
        return "$name is required field";
      }
      if (!GetUtils.isLengthGreaterOrEqual(value, minLength)) {
        return "$name length must be greater than $minLength";
      }
      if (maxLength != null && GetUtils.isLengthGreaterThan(value, maxLength)) {
        return "$name must be less than $maxLength";
      }
      return null;
    };
  }

  static String? Function(String?) dateTimeValidation(String name) {
    return (String? value) {
      if (GetUtils.isNullOrBlank(value)!) {
        return "${name.tr} is required field";
      }
      if (!GetUtils.isDateTime(value!)) {
        return "$name must be valid";
      }
      return null;
    };
  }

  static String? Function(String?) phoneNumberValidity(String name) {
    return (String? value) {
      if (GetUtils.isNullOrBlank(value)!) {
        return "${name} is required field";
      }
      // if (!RegExp(r'^\d{10,}$').hasMatch(value!)) {
      //   return "$name must be at least 10 digits".tr;
      // }
      if (!GetUtils.isPhoneNumber(value!)) {
        return "$name must be valid";
      }
      return null;
    };
  }

  static String? Function(String? value) emailValidity(String name) {
    return (String? value) {
      if (GetUtils.isNullOrBlank(value)!) {
        return "${name.tr} is required field";
      }
      if (!GetUtils.isEmail(value!)) {
        return "This field is only $name";
      }
      return null;
    };
  }

  static String? Function(String?) usernameValidity(String name) {
    return (String? value) {
      if (GetUtils.isNullOrBlank(value)!) {
        return "${name} is required field";
      }
      if (!GetUtils.isUsername(value!)) {
        return "$name must be valid";
      }
      return null;
    };
  }
}
