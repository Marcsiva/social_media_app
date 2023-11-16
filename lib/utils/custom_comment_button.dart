// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:social_media_app/controller/post_controller.dart';
import 'package:social_media_app/utils/custom_comment.dart';

class CustomCommentButton extends StatefulWidget {
  String postId;
  String userName;
  CustomCommentButton(
      {super.key, required this.postId, required this.userName});

  @override
  State<CustomCommentButton> createState() => _CustomCommentButtonState();
}

class _CustomCommentButtonState extends State<CustomCommentButton> {
  final TextEditingController _commentController = TextEditingController();
  final GlobalKey<FormState> _validateKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: CommentSnackBar, icon: const Icon(Icons.comment_sharp));
  }

  void CommentSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        duration: const Duration(minutes: 2),
        content: Column(
          children: [
            IconButton(onPressed: (){
              setState(() {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              });
            }, icon:   Icon(Icons.arrow_drop_down_circle_outlined,
            color: Theme.of(context).primaryColor,)),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 1.0,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: StreamBuilder<List<String>>(
                  stream: PostController().getAllComments(widget.postId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()),
                      ); // or a loading indicator
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String post = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CustomComment(
                                  userName: widget.userName,
                                  comment: post),
                            );
                          });
                    }
                  }),
            ),
            Row(
              children: [
                Form(
                  key: _validateKey,
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: const TextStyle(color:Colors.black ),
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: 'write a comment...',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.blue),),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.blue),),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.blue),)),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'enter the proper comment';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      if (_validateKey.currentState!.validate()) {
                        try {
                          await PostController()
                              .addComment(
                              widget.postId, _commentController.text);
                        } catch (e) {
                          print('$e');
                        }
                        _commentController.clear();
                      }

                    } ,                  icon:  Icon(Icons.send,
                    color: Colors.blue.shade900))
              ],
            ),
          ],
        )));
  }
}
