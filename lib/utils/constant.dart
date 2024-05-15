import 'package:flutter/cupertino.dart';
import 'package:universal_platform/universal_platform.dart';

import '../widgets/responsive.dart';

class AppImages {
  static final AppImages _instance = AppImages._internal();

  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory AppImages() {
    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  AppImages._internal();

  static const String _directory = "assets/image";

  String verifyAccountImage = "$_directory/verify_account.jpg";
}

class AppConstants {
  static final AppConstants _instance = AppConstants._internal();

  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory AppConstants() {
    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  AppConstants._internal();

  static const EdgeInsets appPadding = EdgeInsets.all(24);

  static SizedBox sizedBoxHeight(
    BuildContext context, {
    double defaultValue = 20,
  }) =>
      SizedBox(
        height: getResponsiveValue(
          context,
          defaultValue,
        ),
      );

  static SizedBox sizedBoxWidth(
    BuildContext context, {
    double defaultValue = 10,
  }) =>
      SizedBox(
        width: getResponsiveValue(
          context,
          defaultValue,
        ),
      );

  static double kAppButtonHeight(BuildContext context) => getResponsiveValue(
        context,
        55,
      );

  bool get isWebPlatform => UniversalPlatform.isWeb;
}

class AppFontWeight {
  static final AppFontWeight _instance = AppFontWeight._internal();

  factory AppFontWeight() {
    return _instance;
  }

  AppFontWeight._internal();

  FontWeight boldFontWeight = FontWeight.w900;
  FontWeight semiBoldFontWeight = FontWeight.w600;
  FontWeight lightFontWeight = FontWeight.w500;
  FontWeight thinFontWeight = FontWeight.w400;
}
