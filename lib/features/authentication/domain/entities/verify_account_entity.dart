import 'package:equatable/equatable.dart';

class VerifyAccountEntity extends Equatable {
  final String email;
  final String verificationCode;

  const VerifyAccountEntity(
      {required this.email, required this.verificationCode});

  @override
  List<Object?> get props => [
        email,
        verificationCode,
      ];
}
