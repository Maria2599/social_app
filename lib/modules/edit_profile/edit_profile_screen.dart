import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/rounded_button.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';

import '../../components/components.dart';
import '../../components/constants.dart';
import '../../shared/cubit/states.dart';

class EditProfileScreen extends StatelessWidget {



  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, States>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel= AppCubit.get(context).model;
          var profileImage= AppCubit.get(context).profileImage;
          var coverImage= AppCubit.get(context).coverImage;

          nameController.text= userModel!.name!;
          bioController.text= userModel.bio!;
          phoneController.text= userModel.phone!;

          return Scaffold(
              appBar: AppBar(
            title: Text("Edit Profile"),
            actions: [
              TextButton(
                  onPressed: () {
                    AppCubit.get(context).updateUser(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                  },
                  child: Text(
                    "UPDATE",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                width: 15.0,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is UserUpdateLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0)),
                                  image: DecorationImage(
                                    image: coverImage == null ?
                                    NetworkImage("${userModel.image}"):
                                    FileImage(coverImage) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(onPressed: (){
                                AppCubit.get(context).getCoverImage();
                              },
                                  icon: CircleAvatar(
                                    radius: 20.0,
                                      child:
                                      Icon(
                                          Icons.camera_alt_outlined,size: 16.0,)))
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null ?
                                NetworkImage("${userModel.image}"):
                                FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(onPressed: (){
                              AppCubit.get(context).getProfileImage();
                            },
                                icon: CircleAvatar(
                                    radius: 20.0,
                                    child:
                                    Icon(
                                      Icons.camera_alt_outlined,size: 16.0,)))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if(AppCubit.get(context).profileImage!=null || AppCubit.get(context).coverImage!=null)
                    Row(
                        children: [
                        if(AppCubit.get(context).profileImage!=null)
                          Expanded(
                            child: Column(
                              children: [
                                RoundedButton(
                                  title: "upload profile",
                                  onPressed: (){
                                    AppCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                                  },
                                  color: Colors.blue,),
                                SizedBox(
                                  height: 5.0,
                                ),
                                if(state is UserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if(AppCubit.get(context).coverImage!=null)
                          Expanded(
                          child: Column(
                            children: [
                              RoundedButton(title: "upload cover",
                                onPressed: (){
                                  AppCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);

                                },
                                color: Colors.blue,),
                              SizedBox(
                                height: 5.0,
                              ),
                              if(state is UserUpdateLoadingState)
                                LinearProgressIndicator(),
                            ],
                          ),
                        ),
                        ],
                      ),
                    SizedBox(
                      height: 20.0,
                    ),
                  TextCustomFiled(
                      validator: (value){
                        if(value!.isEmpty){
                          return '   NAME CAN\'T BE EMPTY';
                        }else return null;
                      },
                      keyboardType: TextInputType.name,
                    decoration: TextFieldDecoration.copyWith(
                    label: Text("Name"),
                      prefixIcon: Icon(Icons.supervised_user_circle)
                    ),
                    controller: nameController),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextCustomFiled(
                      validator: (value){
                        if(value!.isEmpty){
                          return '   Bio CAN\'T BE EMPTY';
                        }else return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: TextFieldDecoration.copyWith(
                          label: Text("Bio"),
                          prefixIcon: Icon(Icons.info_outline)
                      ),
                      controller: bioController),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextCustomFiled(
                      validator: (value){
                        if(value!.isEmpty){
                          return '   Phone CAN\'T BE EMPTY';
                        }else return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: TextFieldDecoration.copyWith(
                          label: Text("Bio"),
                          prefixIcon: Icon(Icons.call)
                      ),
                      controller: phoneController)
                ],
              ),
            ),
          ),
          );
        });
  }
}
