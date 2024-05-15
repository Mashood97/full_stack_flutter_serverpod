import 'package:dartz/dartz.dart';

import '../../../../core/error/response_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/authentication_repository.dart';

class LogoutUseCase extends UseCase<void, NoParams> {
  final AuthenticationRepository authenticationRepository;

  LogoutUseCase({
    required this.authenticationRepository,
  });

  @override
  Future<Either<ResponseError, void>> call(NoParams params) async {
    return await authenticationRepository.logout();
  }
}
