import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel{
  
  const factory UserModel({
    required String uid,
    required String password,
    required String phoneNumber,
    required String email,
    required String username,
    required String userProfile,
    required AuthStatus userStatus
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json)  => _$UserModelFromJson(json);

}

enum AuthStatus{
  newUser,
  existingUser
}