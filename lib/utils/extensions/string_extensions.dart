import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../localizations/app_localizations.dart';
import '../navigation/go_router_navigation_delegate.dart';

extension CustomStringExtensions on String {
  bool isHTML() {
    final RegExp htmlRegExp =
        RegExp('<[^>]*>', multiLine: true, caseSensitive: false);
    return htmlRegExp.hasMatch(this);
  }

  String? capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String formattedDate(BuildContext context) {
    return this == ""
        ? "N/A"
        : DateFormat("MMM dd, yyyy", Localizations.localeOf(context).toString())
            .format(DateTime.parse(this).toLocal());
  }

  String formattedDateWithMonthAndYear(BuildContext context) {
    return this == ""
        ? "N/A"
        : DateFormat("yMMM", Localizations.localeOf(context).toString())
            .format(DateTime.parse(this).toLocal());
  }

  String formattedDateAndTime(BuildContext context) {
    return this == ""
        ? "N/A"
        : DateFormat("MMM dd, yyyy", Localizations.localeOf(context).toString())
            .add_jm()
            .format(DateTime.parse(this));
  }

  String get convertRoutePathToRouteName => replaceAll("/", "");

  bool get isTextAUrl {
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = RegExp(pattern);
    if (isEmpty == true) {
      return false;
    } else if (!regExp.hasMatch(this)) {
      return false;
    }
    return true;
  }

  bool get isTextAFilePath {
    RegExp regExp =
        RegExp("[^\\s]+(.*?)\\.(jpg|jpeg|png|gif|JPG|JPEG|PNG|GIF)\$");
    if (regExp.hasMatch(this)) {
      return true;
    }
    return false;
  }
}

extension StringValidations on String? {
  bool get isTextNullAndEmpty => this == null || this?.isEmpty == true;

  bool get isTextNotNullAndNotEmpty => this != null && this?.isNotEmpty == true;

  bool get isTextAUrl {
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = RegExp(pattern);
    if (this?.isEmpty == true) {
      return false;
    } else if (!regExp.hasMatch(this!)) {
      return false;
    }
    return true;
  }

  String? validatePassword(BuildContext context) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    String password = this!.trim();
    if (password.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(password)) {
        return 'Password must be at least 8 characters long and should contain an uppercase letter, a lowercase letter, a number and a special character.';
      } else if (password.isValidXSSAttack) {
        return 'Please enter a valid password';
      }
      return null;
    }
  }

  String? validateEmail(BuildContext context) {
    final emailFormatter = RegExp(r"[a-zA-Z0-9.@]+");
    String email = this!.trim();
    if (email.isEmpty) {
      return "Please enter email";
    } else if (!emailFormatter.hasMatch(email)) {
      return "Please enter a valid email in this format i.e testabc@gmail.com";
    } else if (email.isValidXSSAttack) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? validatePhoneNumber(BuildContext context) {
    final phoneFormatter = RegExp(r'[0-9]');
    String phoneNumber = this!.trim();
    if (phoneNumber.isEmpty) {
      return "Please enter phone number";
    } else if (!phoneFormatter.hasMatch(phoneNumber)) {
      return "Please enter a valid phone number";
    } else if (phoneNumber.isValidXSSAttack) {
      return "Please enter a valid phone number";
    }
    return null;
  }

  String? validateAlphabets({
    required String label,
    required BuildContext context,
  }) {
    final alphabetsInput = RegExp(r"[A-Za-z|\s]+");
    String characters = this!.trim();
    if (characters.isEmpty) {
      return "Please enter $label";
    } else if (!alphabetsInput.hasMatch(characters)) {
      return "Please enter a valid $label";
    } else if (characters.isValidXSSAttack) {
      return "Please enter a valid $label";
    }
    return null;
  }

  String? validatePasswordAndConfirmPassword({
    required String otherPassword,
    required BuildContext context,
  }) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    String password = this!.trim();
    if (password.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(password)) {
        return 'Password must be at least 8 characters long and should contain an uppercase letter, a lowercase letter, a number and a special character.';
      } else if (password.isValidXSSAttack) {
        return 'Please enter a valid password';
      } else if (password != otherPassword.trim()) {
        return "Password and confirm password aren't same";
      }
      return null;
    }
  }

  bool get isValidXSSAttack {
    // Prevent XSS attacks
    if (this?.contains(RegExp(r'(--|\#|\|)')) == true) {
      return true;
    } else if (this?.contains(RegExp(
            r'<script|<iframe|<style|<link|<img|<svg|<canvas|<a[^>]*href')) ==
        true) {
      return true;
    } else {
      return false;
    }
  }
}
