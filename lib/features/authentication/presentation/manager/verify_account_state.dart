part of 'verify_account_bloc.dart';

abstract class VerifyAccountState extends Equatable {
  const VerifyAccountState();
}

class VerifyAccountInitial extends VerifyAccountState {
  const VerifyAccountInitial();

  @override
  List<Object?> get props => [];
}

class VerifyAccountLoading extends VerifyAccountState {
  const VerifyAccountLoading();

  @override
  List<Object?> get props => [];
}

class VerifyAccountFailure extends VerifyAccountState {
  final String error;

  const VerifyAccountFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'VerifyAccountFailure { error: $error }';
}
