import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticktok/controller/comment_controller.dart';
import 'package:ticktok/widgets/text_input.dart';

class CommentScreen extends StatelessWidget {
  // const CommentScreen({Key? key}) : super(key: key);

  final String id;
  CommentScreen({required this.id});

  final TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.updatePostID(id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Row(
                          children: [
                          Text("User Name", style: TextStyle(fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.redAccent,),),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Comment", style: TextStyle(
                          fontSize: 13,),
                          ),
                          ]
                        ),
                        subtitle: Row(
                          children: [
                            Text("Date Time",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,),),
                          SizedBox(
                            width: 5,
                          ),
                            Text("10 Likes"),
                          ],
                        ),
                        trailing: Icon(Icons.favorite),
                      );
                    }),
              ),
              Divider(),
              ListTile(
                title: TextInput(controller: _commentController,myIcon: Icons.comment,myLabel: "Comment",),
                trailing: TextButton(onPressed: (){
                  commentController.postComment(_commentController.text);
                },child: Text("Send"),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
