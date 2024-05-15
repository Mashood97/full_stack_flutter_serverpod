import 'package:ecom_flutter/utils/navigation/go_router_navigation_delegate.dart';
import 'package:ecom_flutter/utils/navigation/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AppNavigations {
  static final AppNavigations _instance = AppNavigations._internal();

  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory AppNavigations() {
    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  AppNavigations._internal();

  void navigateBack({required BuildContext context, dynamic value}) {
    if (context.canPop()) {
      context.pop(value);
    }
  }

  void navigateFromLoginToRegisterScreen({required BuildContext context}) {
    context.goNamed(
      NavigationRouteNames.registerRoute.convertRoutePathToRouteName,
    );
  }

  void navigateFromRegisterScreenToVerifyEmail({
    required BuildContext context,
    required String email,
  }) {
    context.goNamed(
      NavigationRouteNames.verifyAccountRoute.convertRoutePathToRouteName,
      queryParameters: {"email": email},
    );
  }
}
