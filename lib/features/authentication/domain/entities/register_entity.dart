import 'package:ecom_flutter/utils/extensions/string_extensions.dart';
import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final String? email;
  final String? username;
  final String? password;

  const RegisterEntity({this.username, this.password, this.email});


  bool get isValidData => email.isTextNotNullAndNotEmpty && username.isTextNotNullAndNotEmpty && password.isTextNotNullAndNotEmpty;

  @override
  List<Object?> get props => [email, username, password];
}
