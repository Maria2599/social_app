import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/cubit/states.dart';

class LoginCubit extends Cubit<States> {
  LoginCubit() : super(appInitStates());

  static LoginCubit get(context) => BlocProvider.of(context);
  final _auth = FirebaseAuth.instance;
  String s="";

  void logInUser({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());

    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
    //      getPhoneNumber( uId: value.user!.uid);
      print(value.user!.uid);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((e) {
      print(e.toString());
      if (e.code == 'user-not-found') {
        s = "The email not found";
      } else if (e.code == 'invalid-email') {
        s = "The email is not valid";
      } else if (e.code == 'wrong-password') {
        s = "Password is wrong";
      }
      // Fluttertoast.showToast(
      //     msg: s,
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.grey,
      //     timeInSecForIosWeb: 1,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      emit(LoginErrorState(error: e.toString()));
    });
  }

  // void getPhoneNumber({
  //   required String uId,
  // }) {
  //
  //   FirebaseFirestore.instance
  //       .collection('patients')
  //       .get()
  //       .then((value) {
  //         print(value.docs[1].data()['phone']);
  //        // num=value.docs[1].data()['phone'];
  //         print(num);
  //   emit(CreateUserSuccessState());
  //   }).catchError((error){
  //   emit(CreateUserErrorState());
  //   });
  // }


}
