import 'package:flutter/cupertino.dart';

abstract class States {}

class appInitStates extends States {}

class RegisterLoadingState extends States {}

class RegisterSuccessState extends States {}

class RegisterErrorState extends States {}

class LoginLoadingState extends States {}

class LoginSuccessState extends States {
  final String uId;
  LoginSuccessState(this.uId);
}

class LoginErrorState extends States {
  final String error;
  LoginErrorState({required this.error});
}

class CreateUserSuccessState extends States {}

class CreateUserErrorState extends States {}

class ChangeButtonNavState extends States{}

class GetUserSuccessState extends States {}

class GetUserErrorState extends States {}

class GetUserLoadingState extends States {}

class NewPostButtonNavState extends States{}

class ProfileImagePickedSuccessState extends States {}

class ProfileImagePickedErrorState extends States {}

class CoverImagePickedSuccessState extends States {}

class CoverImagePickedErrorState extends States {}

class UploadProfileImageSuccessState extends States {}

class UploadProfileImageErrorState extends States {}

class UploadCoverImageSuccessState extends States {}

class UploadCoverImageErrorState extends States {}

class UserUpdateLoadingState extends States {}

class UserUpdateErrorState extends States {}


//create post
class CreatePostSuccessState extends States {}

class CreatePostErrorState extends States {}

class CreatePostLoadingState extends States {}

class PostImagePickedSuccessState extends States {}

class PostImagePickedErrorState extends States {}

class RemovePostImageState extends States {}

