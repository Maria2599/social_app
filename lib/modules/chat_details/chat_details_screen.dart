import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/messageModel.dart';
import 'package:social_app/models/userModel.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';

import '../../shared/cubit/states.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;

  ChatDetailsScreen({required this.userModel, Key? key}) : super(key: key);

  var messageController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context){
        AppCubit.get(context).getMessages(receiverId: userModel.uId!);
        return
        BlocConsumer<AppCubit,States>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(userModel.image!),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(userModel.name!),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: AppCubit.get(context).messages!= null,
                fallback: (context)=> Center(child: CircularProgressIndicator()),
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context,index){
                              var message= AppCubit.get(context).messages[index];
                              if(AppCubit.get(context).model!.uId == message.senderId)
                                return buildMyMessage(message);

                              return buildMessage(message);
                            },
                            separatorBuilder: (context,index)=> SizedBox(
                              height: 15.0,
                            ),
                            itemCount: AppCubit.get(context).messages.length),
                      ),
                      Container(
                        height: 50.0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type your message here..'),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: () {
                                  AppCubit.get(context).sendMessages(receiverId: userModel.uId!, dateTime: DateTime.now().toString(), text: messageController.text);
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  Icons.send,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );},
    );
  }

  Widget buildMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          )),
      child: Text(model.text!),
    ),
  );

  Widget buildMyMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          )),
      child: Text(model.text!),
    ),
  );

}
