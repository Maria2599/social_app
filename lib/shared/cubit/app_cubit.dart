import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/messageModel.dart';
import 'package:social_app/models/postModel.dart';
import 'package:social_app/models/userModel.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../components/constants.dart';

class AppCubit extends Cubit<States> {
  AppCubit() : super(appInitStates());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  UserModel? model;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  List titles = ["News Feeds", "Chats", "Posts", "Users", "Settings"];

  void getUsers() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      print(model!.name);
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState());
    });
  }

  void changeButtonNav(int index) {
    if(index ==1)
      getAllUsers();
    if (index == 2) {
      emit(NewPostButtonNavState());
    } else {
      currentIndex = index;
      emit(ChangeButtonNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(ProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(CoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoadingState());
    //child ta5od the last path of image elly hya btkon asmha EX: "app.jpeg"
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoadingState());
    //child ta5od the last path of image elly hya btkon asmha EX: "app.jpeg"
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

//   void updateUserImages({
//   required String name,
//   required String phone,
//   required String bio,
// }){
//     emit(UserUpdateLoadingState());
//
//     if(coverImage != null){
//       uploadPCoverImage();
//     }
//     else if(profileImage != null){
//       uploadProfileImage();
//     }else if(coverImage != null && profileImage != null){
//
//     }
//     else{
//      updateUser(name: name, phone: phone, bio: bio);
//     }
//   }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    UserModel userModel = UserModel(
        name: name,
        phone: phone,
        bio: bio,
        email: model!.email,
        cover: cover ?? model!.cover,
        image: image ?? model!.image,
        uId: model!.uId,
        age: model!.age);

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .update(userModel.toMap())
        .then((value) {
      getUsers();
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(PostImagePickedErrorState());
    }
  }

  void removePostImage(){
    postImage = null;
    emit(RemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoadingState());
    //child ta5od the last path of image elly hya btkon asmha EX: "app.jpeg"
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel postModel = PostModel(
      name: model!.name,
      image: model!.image,
      uId: model!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
          emit(CreatePostSuccessState());
    })
        .catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> posts=[];
  List<String> postsId=[];
  List<int> likes=[];

  void getPosts(){
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          //element hwa mo7tawa l doc l wa7da
          value.docs.forEach((element) {
            element.reference
            .collection('likes')
            .get()
            .then((value) {
              likes.add(value.docs.length);
              postsId.add(element.id);
              posts.add(PostModel.fromJson(element.data()));
            })
            .catchError((error){});

          });
          emit(GetPostsSuccessState());
    })
        .catchError((error){
          emit(GetPostsErrorState());
    });
  }

  void likePost(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({
      'like': true,
    })
        .then((value) {
          emit(LikePostsSuccessState());
    })
        .catchError((error){
          emit(LikePostsErrorState());
    });
  }

  void commentPost(String postId, String commentText){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(model!.uId)
        .set({
      'comment': commentText,
    }).then((value) {
      emit(CommentPostsSuccessState());
    })
        .catchError((error){
          emit(CommentPostsErrorState());
    });
  }

  List<UserModel> users=[];
  void getAllUsers() {
    emit(GetAllUsersLoadingState());
    if(users.length == 0)
      FirebaseFirestore.instance.collection('users').get()
        .then((value) {
      value.docs.forEach((element) {
        if(element.data()['uId'] != model!.uId)
          users.add(UserModel.fromJson(element.data()));
      });
      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      emit(GetAllUsersErrorState());
    });
  }


  void sendMessages({
  required String receiverId,
  required String dateTime,
  required String text,
}){

    MessageModel messageModel = MessageModel(
      senderId: model!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
    );

    //set my chats
    FirebaseFirestore.instance
    .collection('users')
    .doc(model!.uId)
    .collection('chat')
    .doc(receiverId)
    .collection('messages')
    .add(messageModel.toMap())
    .then((value) {
      emit(SendMessagesSuccessState());
    })
    .catchError((error){
      emit(SendMessagesErrorState());
    });

    //set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(model!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessagesSuccessState());
    })
        .catchError((error){
      emit(SendMessagesErrorState());
    });
  }

  List<MessageModel> messages=[];

  void getMessages({
    required String receiverId,
}){
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
    .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages=[];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
          emit(GetMessagesSuccessState());
    });
  }
}
