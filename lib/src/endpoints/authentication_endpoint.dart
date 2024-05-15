import 'package:ecom_server/src/generated/protocol.dart';
import 'package:serverpod_auth_server/module.dart' as auth;
import 'package:serverpod/serverpod.dart';

class AuthenticationEndPoint extends Endpoint {
  Future<UserExistModel> verifyUserExistByEmail(
    Session session, {
    required String email,
    bool isFromRegistration = false,
  }) async {
    try {
      final response = await auth.Users.findUserByEmail(session, email);

      if (response == null) {
        return UserExistModel(
            email: email,
            isExist: false,
            code: 403,
            message:
                "No User found with the given email,  Please create a new account with this email.");
      }

      return UserExistModel(
        email: email,
        isExist: true,
        message:isFromRegistration ? "A user already exist by this email.Please use another email to create a new account." : "User found successfully",
        code: 200,
      );
    } catch (e, s) {
      session.log(
        'Oops, something went wrong, StatusCode: 500, Method: verifyUserExistByEmail',
        level: LogLevel.error,
        exception: e,
        stackTrace: s,
      );
      return UserExistModel(
          email: "",
          isExist: false,
          code: 500,
          message: "Something went wrong, Please try again later");
    }
  }
}
