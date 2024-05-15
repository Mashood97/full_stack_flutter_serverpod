import 'package:dartz/dartz.dart';

import '../../../../core/error/response_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/authentication_repository.dart';

class HasTokenUseCase extends UseCase<bool, NoParams> {
  final AuthenticationRepository authenticationRepository;

  HasTokenUseCase({
    required this.authenticationRepository,
  });

  @override
  Future<Either<ResponseError, bool>> call(NoParams params) async {
    return await authenticationRepository.hasToken();
  }
}
