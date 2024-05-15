import 'package:dartz/dartz.dart';

import '../../../../core/error/response_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/login_entity.dart';
import '../repositories/authentication_repository.dart';

class LoginUseCase extends UseCase<String, LoginEntity> {
  final AuthenticationRepository authenticationRepository;

  LoginUseCase({
    required this.authenticationRepository,
  });

  @override
  Future<Either<ResponseError, String>> call(LoginEntity params) async {
    return await authenticationRepository.authenticate(loginEntity: params);
  }
}
