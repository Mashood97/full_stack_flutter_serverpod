import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String? firebaseToken;
  final String? username;
  final String? password;

  const LoginEntity({this.username, this.password, this.firebaseToken});

  @override
  List<Object?> get props => [firebaseToken, username, password];
}
