import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/components.dart';
import 'package:social_app/models/userModel.dart';
import 'package:social_app/modules/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,States>(
      listener: (context,state){} ,
      builder: (context,state){
        return  ConditionalBuilder(
          condition: AppCubit.get(context).users.length>0,
          fallback: (context)=>Center(child: CircularProgressIndicator()),
          builder:(context)=> ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(AppCubit.get(context).users[index],context),
              separatorBuilder: (context, index) => Container(
                height: 0.5,
                color: Colors.grey,
              ),
              itemCount: AppCubit.get(context).users.length),
        );
      },

    );
  }

  Widget buildChatItem(UserModel userModel, context) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(userModel: userModel));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
                "${userModel.image}"),
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            "${userModel.name}",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
