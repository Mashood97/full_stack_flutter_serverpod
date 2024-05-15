/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class UserExistModel extends _i1.SerializableEntity {
  UserExistModel._({
    required this.email,
    required this.isExist,
    required this.message,
    required this.code,
  });

  factory UserExistModel({
    required String email,
    required bool isExist,
    required String message,
    required int code,
  }) = _UserExistModelImpl;

  factory UserExistModel.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return UserExistModel(
      email:
          serializationManager.deserialize<String>(jsonSerialization['email']),
      isExist:
          serializationManager.deserialize<bool>(jsonSerialization['isExist']),
      message: serializationManager
          .deserialize<String>(jsonSerialization['message']),
      code: serializationManager.deserialize<int>(jsonSerialization['code']),
    );
  }

  String email;

  bool isExist;

  String message;

  int code;

  UserExistModel copyWith({
    String? email,
    bool? isExist,
    String? message,
    int? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'isExist': isExist,
      'message': message,
      'code': code,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'email': email,
      'isExist': isExist,
      'message': message,
      'code': code,
    };
  }
}

class _UserExistModelImpl extends UserExistModel {
  _UserExistModelImpl({
    required String email,
    required bool isExist,
    required String message,
    required int code,
  }) : super._(
          email: email,
          isExist: isExist,
          message: message,
          code: code,
        );

  @override
  UserExistModel copyWith({
    String? email,
    bool? isExist,
    String? message,
    int? code,
  }) {
    return UserExistModel(
      email: email ?? this.email,
      isExist: isExist ?? this.isExist,
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
