import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/components.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,States>(
         listener: (context, state) {
           if(state is NewPostButtonNavState){
             navigateTo(context, NewPostScreen());
           }
         },
      builder: (context,state){
           var cubit= AppCubit.get(context);
           return Scaffold(
             appBar: AppBar(
               title: Text(cubit.titles[cubit.currentIndex]),
               actions: [
                 IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none)),
                 IconButton(onPressed: (){}, icon: Icon(Icons.search)),
               ],
             ),
             body: cubit.screens[cubit.currentIndex],
             bottomNavigationBar: BottomNavigationBar(
               currentIndex: cubit.currentIndex,
               onTap: (index){ cubit.changeButtonNav(index);},
               items: [
                 BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
                 BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
                 BottomNavigationBarItem(icon: Icon(Icons.my_library_add_outlined), label: "Post"),
                 BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle), label: "Users"),
                 BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
               ],
             ),
           );
      },
    );
  }
}
