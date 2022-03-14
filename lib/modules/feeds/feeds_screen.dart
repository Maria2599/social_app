import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10.0,
            margin: EdgeInsets.all(8.0),
            child:
                Stack(alignment: AlignmentDirectional.bottomStart, children: [
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
            itemBuilder: (context, index) => buildPostItem(context)
          ,itemCount: 10 ,
          separatorBuilder: (context,index)=> SizedBox(height: 10.0,),),
          SizedBox(height: 8.0,)
        ],
      ),
    );
  }

  Widget buildPostItem(context) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Maria Tharwat",
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
                      "March 11, 2022 at 3 pm",
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
            "The number of paragraphs, words per paragraph and whether or not to wrap paragraphs in paragraph tags can be changed easily. Once happy with your selection, simply click the Copy button and the text is sent straight to your clipboard ready for pasting!",
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
          Container(
            height: 140.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(
                image: NetworkImage(
                    "https://th.bing.com/th/id/OIP.kvETIYCTWn66gr-Hcbv-OgHaHa?pid=ImgDet&rs=1"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(Icons.thumb_up_off_alt,size: 16.0,color: Colors.blue,),
                          SizedBox(width: 5.0,),
                          Text("120",style: Theme.of(context).textTheme.caption,)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.chat,size: 16.0,color: Colors.blue,),
                          SizedBox(width: 5.0,),
                          Text("comments",style: Theme.of(context).textTheme.caption,)
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
                            "https://th.bing.com/th/id/OIP.kvETIYCTWn66gr-Hcbv-OgHaHa?pid=ImgDet&rs=1"),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        "write a comment ...",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
              ),
              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    Icon(Icons.thumb_up_off_alt,size: 16.0,color: Colors.blue,),
                    SizedBox(width: 5.0,),
                    Text("Like",style: Theme.of(context).textTheme.caption,)
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
