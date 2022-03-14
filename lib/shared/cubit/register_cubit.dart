import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/userModel.dart';
import 'package:social_app/shared/cubit/states.dart';

class RegisterCubit extends Cubit<States> {
  RegisterCubit() : super(appInitStates());

  static RegisterCubit get(context) => BlocProvider.of(context);
  final _auth = FirebaseAuth.instance;
  String s = "";

  void registerUser({
    required String email,
    required String password,
    required String phone,
    required String name,
    required String age,
  }) {
    emit(RegisterLoadingState());

    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.uid);
      createUser(email: email, name: name, phone: phone, age: age, uId: value.user!.uid);
      emit(RegisterSuccessState());
    }).catchError((e) {
      print(e.toString());
      if (e.code == 'email-already-in-use') {
        s = "The account already exists";
      } else if (e.code == 'invalid-email') {
        s = "The email is not valid";
      } else if (e.code == 'weak-password') {
        s = "Password is too weak";
      }
      // Fluttertoast.showToast(
      //     msg: s,
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.grey,
      //     timeInSecForIosWeb: 2,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      emit(RegisterErrorState());
    });
  }

  void createUser({
    required String email,
    required String name,
    required String phone,
    required String age,
    required String uId,
  }) {
    UserModel userModel = UserModel(
      email: email,
      name: name,
      phone: phone,
      age: age,
      uId: uId,
      bio: "write your bio...",
      image: "https://th.bing.com/th/id/OIP.kvETIYCTWn66gr-Hcbv-OgHaHa?pid=ImgDet&rs=1",
      cover: "https://th.bing.com/th/id/OIP.kvETIYCTWn66gr-Hcbv-OgHaHa?pid=ImgDet&rs=1",
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
    .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error){
      emit(CreateUserErrorState());
    });
  }

}
