part of 'verify_account_bloc.dart';

sealed class VerifyAccountEvent extends Equatable {
  const VerifyAccountEvent();
}

final class VerifyButtonPressed extends VerifyAccountEvent {
  final String email;
  final String verificationCode;

  const VerifyButtonPressed({
    required this.email,
    required this.verificationCode,
  });

  @override
  List<Object?> get props => [
        email,
        verificationCode,
      ];
}
