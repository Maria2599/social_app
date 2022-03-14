import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:social_app/components/components.dart';
import 'package:social_app/components/constants.dart';
import 'package:social_app/components/rounded_button.dart';
import 'package:social_app/modules/home_screen.dart';
import 'package:social_app/shared/cubit/register_cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'login_screen.dart';

class Registration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegistrationState();
}

var formKey = GlobalKey<FormState>();
var email = TextEditingController();
var password = TextEditingController();
var phone = TextEditingController();
var name = TextEditingController();
var age = TextEditingController();

class RegistrationState extends State<Registration> {
  bool isHidden = false;
  Timer? _timer;
  late double _progress;

  changePassword() {
    setState(() => isHidden = !isHidden);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, States>(
        listener: (BuildContext context, state) {
      if (state is RegisterLoadingState) {
        _progress = 0;
        _timer?.cancel();
        _timer =
            Timer.periodic(const Duration(milliseconds: 20), (Timer timer) {
          EasyLoading.showProgress(_progress,
              status: '${(_progress * 100).toStringAsFixed(0)}% \n Loading');
          _progress += 0.03;

          if (_progress >= 1) {
            _timer?.cancel();
            EasyLoading.dismiss();
          }
        });
      } else if (state is CreateUserSuccessState) {
        navigateAndFinish(
            context,
            Home(),
             );

        EasyLoading.showSuccess("Successful", duration: Duration(seconds: 1));
      } else if (state is RegisterErrorState) {
        EasyLoading.showError("Error", duration: Duration(seconds: 5));
      }
    }, builder: (BuildContext context, Object? state) {
      var cubit = RegisterCubit.get(context);

      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "LET'S START",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "CREATE AN ACCOUNT",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, right: 24.0, top: 30.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 14.0,
                        ),
                        TextCustomFiled(
                          obscureText: false,
                          controller: name,
                          decoration: TextFieldDecoration.copyWith(
                            filled: true,
                            fillColor: Colors.white70,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10),
                            labelText: AppLocalizations.of(context)!.name,
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.blueAccent,
                              size: 20.0,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .nameCantbeEmpty;
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        TextCustomFiled(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .ageCantbeEmpty;
                            } else {
                              return null;
                            }
                          },
                          obscureText: false,
                          controller: age,
                          keyboardType: TextInputType.number,
                          decoration: TextFieldDecoration.copyWith(
                            filled: true,
                            fillColor: Colors.white70,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10),
                            labelText: AppLocalizations.of(context)!.age,
                            prefixIcon: const Icon(
                              Icons.account_box_outlined,
                              color: Colors.blueAccent,
                              size: 20.0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextCustomFiled(
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .phoneCantbeEmpty;
                            } else if (!RegExp(r'(^(01)+[0-9]{9}$)')
                                .hasMatch(value)) {
                              return AppLocalizations.of(context)!
                                  .enterVaildPhone;
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.phone,
                          controller: phone,
                          decoration: TextFieldDecoration.copyWith(
                            filled: true,
                            fillColor: Colors.white70,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10),
                            labelText: AppLocalizations.of(context)!.phone,
                            prefixIcon: const Icon(
                              Icons.phone_android_outlined,
                              color: Colors.blueAccent,
                              size: 20.0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextCustomFiled(
                            obscureText: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .emailCantbeEmpty;
                              } else if (!RegExp(
                                      "^[a-zA-Z0-9]+@[a-zA-Z0-9]+.[a-z]")
                                  .hasMatch(value)) {
                                return AppLocalizations.of(context)!
                                    .enterAValidEMail;
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: email,
                            decoration: TextFieldDecoration.copyWith(
                              filled: true,
                              fillColor: Colors.white70,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10),
                              labelText: AppLocalizations.of(context)!.email,
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Colors.blueAccent,
                                size: 20.0,
                              ),
                            )),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextCustomFiled(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .passwordCantbeEmpty;
                            } else if (value.length < 6) {
                              return AppLocalizations.of(context)!
                                  .passwordmustbemorethan;
                            } else {
                              return null;
                            }
                          },
                          obscureText: isHidden,
                          controller: password,
                          decoration: TextFieldDecoration.copyWith(
                              filled: true,
                              fillColor: Colors.white70,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10),
                              labelText: AppLocalizations.of(context)!.password,
                              prefixIcon: const Icon(
                                Icons.password_rounded,
                                color: Colors.blueAccent,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: changePassword,
                                  icon: isHidden
                                      ? const Icon(
                                          Icons.lock_outline,
                                          color: Colors.blueAccent,
                                          size: 20.0,
                                        )
                                      : const Icon(
                                          Icons.lock_open,
                                          color: Colors.blueAccent,
                                          size: 22.0,
                                        ))),
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        RoundedButton(
                          title: AppLocalizations.of(context)!.signUp,
                          onPressed: () async {
                            phoneConst = phone.text;
                            print(phoneConst);
                            if (formKey.currentState!.validate()) {
                              print(email.text);
                              cubit.registerUser(
                                  email: email.text,
                                  password: password.text,
                                  phone: phone.text,
                                  name: name.text,
                                  age: age.text);
                            }
                          },
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.alreadyhaveAccount,
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.login,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.blueAccent),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      );
    });
  }
}
