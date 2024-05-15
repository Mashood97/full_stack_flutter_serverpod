abstract class AuthenticationRemoteDataSourceRepository {
  Future<String> authenticate({
    required String email,
    required String password,
  });

  Future<bool> register({
    required String email,
    required String userName,
    required String password,
  });

  Future<String> verifyAccount({
    required String email,
    required String verificationCode,
  });

  Future<void> logout();

  Future<bool> hasToken();

  Future<void> persistToken(String token);
}
