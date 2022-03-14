import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class NewPostScreen extends StatelessWidget {
   NewPostScreen({Key? key}) : super(key: key);

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,States>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text("Create post"),
            actions: [
              TextButton(onPressed: (){
                var now = DateTime.now();
                if(AppCubit.get(context).postImage == null){
                  AppCubit.get(context).createPost(dateTime: now.toString(), text: textController.text);
                }else{
                  AppCubit.get(context).uploadPostImage(dateTime: now.toString(), text: textController.text);
                }
              }, child: Text("POST"))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is CreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is CreatePostLoadingState)
                  SizedBox(
                  height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          "https://th.bing.com/th/id/OIP.kvETIYCTWn66gr-Hcbv-OgHaHa?pid=ImgDet&rs=1"),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child:  Text(
                        "Maria Tharwat",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: "What is on your mind... ",
                      border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                if(AppCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all( Radius.circular(4.0),),
                        image: DecorationImage(
                          image: FileImage(AppCubit.get(context).postImage!) ,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){
                      AppCubit.get(context).removePostImage();
                    },
                        icon: CircleAvatar(
                            radius: 20.0,
                            child:
                            Icon(
                              Icons.close,size: 16.0,)))
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        AppCubit.get(context).getPostImage();
                      }, child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.photo_size_select_actual_outlined),
                          SizedBox(width: 5.0,),
                          Text("Add Photo".toLowerCase())
                        ],
                      )),
                    ),
                    Expanded(child: TextButton(onPressed:(){},child: Text("# tags")))
                  ],
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}
