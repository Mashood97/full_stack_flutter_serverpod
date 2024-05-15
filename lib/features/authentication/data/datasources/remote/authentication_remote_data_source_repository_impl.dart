import 'package:ecom_client/ecom_client.dart';
import 'package:ecom_flutter/features/authentication/data/datasources/remote/authentication_remote_data_source_repository.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';

import '../../../../../core/error/response_error.dart';
import '../../../../../main.dart';

class AuthenticationRemoteDataSourceRepositoryImpl
    implements AuthenticationRemoteDataSourceRepository {
  final EmailAuthController authController;

  const AuthenticationRemoteDataSourceRepositoryImpl({
    required this.authController,
  });

  // final authController = EmailAuthController(client.modules.auth);

  @override
  Future<String> authenticate(
      {required String email, required String password}) async {
    final UserExistModel userExists =
        await client.authenticationEndPoint.verifyUserExistByEmail(
      email: email,
      isFromRegistration: false,
    );

    if (userExists.isExist) {
      final response = await authController.signIn(email, password);

      if (response != null) {
        return response.userIdentifier;
      }

      throw ResponseError(
        errorStatus: "We are unable to login, Please try again later.",
      );
    } else {
      throw ResponseError(
        errorStatus: userExists.message,
      );
    }
  }

  @override
  Future<bool> hasToken() async {
    String isAuth = await localStorageInstance.readAutoLoginKey();
    await Future.delayed(const Duration(
      seconds: 1,
    ));

    return isAuth == "true";
  }

  @override
  Future<void> logout() async {
    await localStorageInstance.clearLocalStorage();
  }

  @override
  Future<void> persistToken(String token) async {
    await localStorageInstance.writeAutoLoginKey(autoLogin: "true");
  }

  @override
  Future<bool> register(
      {required String email,
      required String userName,
      required String password}) async {
    try {
      final UserExistModel userExists = await client.authenticationEndPoint
          .verifyUserExistByEmail(email: email, isFromRegistration: true);

      if (!userExists.isExist) {
        final response = await authController.createAccountRequest(
            userName, email, password);
        return response;
      } else {
        throw ResponseError(
          errorStatus: userExists.message,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> verifyAccount(
      {required String email, required String verificationCode}) async {
    final response =
        await authController.validateAccount(email, verificationCode);

    if (response != null) {
      return response.userIdentifier;
    }

    throw ResponseError(
      errorStatus: "We are unable to login, Please try again later.",
    );
  }
}
