import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/postModel.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';

import '../../shared/cubit/states.dart';

class FeedsScreen extends StatelessWidget {
   FeedsScreen({Key? key}) : super(key: key);

  var commentText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, States>(
      listener: (context, index) {},
      builder: (context, index) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).posts.length > 0 && AppCubit.get(context).model != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10.0,
                  margin: EdgeInsets.all(8.0),
                  child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: const [
                        Image(
                          image: NetworkImage(
                              "https://artinsights.com/wp-content/uploads/2018/11/DonaldBaseball5x7.5.jpeg"),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Communicate with your friends",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                        ),
                      ]),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(
                      AppCubit.get(context).posts[index], context,index),
                  itemCount: AppCubit.get(context).posts.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                )
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage("${model.image}"),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${model.name}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 15.0,
                            )
                          ],
                        ),
                        Text(
                          "${model.dateTime}",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 16.0,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                "${model.text}",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                    fontSize: 14.5),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0, top: 5.0),
                child: Container(
                  width: double.infinity,
                  child: Wrap(children: [
                    Container(
                      padding: EdgeInsetsDirectional.only(end: 6.0),
                      height: 25.0,
                      child: MaterialButton(
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Text(
                          "#Software",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.only(end: 6.0),
                      height: 25.0,
                      child: MaterialButton(
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Text(
                          "#Software",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.only(end: 6.0),
                      height: 25.0,
                      child: MaterialButton(
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Text(
                          "#Software",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15.0),
                  child: Container(
                    height: 140.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          "${model.postImage}",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.thumb_up_off_alt,
                                size: 16.0,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "${AppCubit.get(context).likes[index]}",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.chat,
                                size: 16.0,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "comments",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                              "${AppCubit.get(context).model!.image}"),
                            ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Container(
                            width: 150,
                            child: TextFormField(
                              controller: commentText,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintText: "write a comment ...",
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        AppCubit.get(context).commentPost(AppCubit.get(context).postsId[index], commentText.text);
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      AppCubit.get(context).likePost(AppCubit.get(context).postsId[index]);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.thumb_up_off_alt,
                          size: 16.0,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Like",
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
