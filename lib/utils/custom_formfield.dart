// ignore_for_file: must_be_immutable

import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/utils/custom_comment_button.dart';
import 'package:social_media_app/utils/like_button.dart';

class CustomFormField extends StatefulWidget {

  void Function()? onTap;
  String postId;
  String userName;
  String postContent;
  String count;
  CustomFormField(
      {super.key,
      required this.userName,
      required this.onTap,
      required this.postContent,
      required this.postId,
      // required this.likeOnPressed,
      required this.count,

      });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  //final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: Colors.grey)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                      FirebaseAuth.instance.currentUser?.photoURL ?? "",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      widget.userName,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                //height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    // child: Text(
                    //   widget.postContent,
                    //   style: const TextStyle(fontSize: 16),
                    // ),
                    // child: ReadMoreText(
                    //   text: widget.postContent,
                    //   trimLines: 10,
                    // ),
                    child: ExpandableText(
                      widget.postContent,
                      expandText: 'Read more',
                      collapseText: 'Read less',
                      maxLines: 3,
                      linkColor: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    LikeButtonView(
                      postId: widget.postId,
                      //userId: widget.userName,
                      currentUserId: FirebaseAuth.instance.currentUser!.uid,
                    ),
                    Text(widget.count)
                  ],
                ),
                CustomCommentButton(postId: widget.postId, userName: widget.userName,)
              ],
            )
          ],
        ),

      ),
    );
  }
  // void showSnackBar(BuildContext context) {
  //   final snackBar = SnackBar(
  //     content:Container(
  //       height: MediaQuery.of(context).size.height * 0.5,
  //       width: MediaQuery.of(context).size.width * 1.0,
  //       child: Column(
  //         children: [
  //           Expanded(
  //             child: FutureBuilder<List<String>>(
  //               future: PostController().getComments(widget.postId),
  //               builder: (context, snapshot) {
  //                 if (snapshot.connectionState == ConnectionState.waiting) {
  //                   return const CircularProgressIndicator();
  //                 }
  //
  //                 if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //                   return Text('No comments yet.');
  //                 }
  //
  //                 List<String> comments = snapshot.data!;
  //
  //                 // return Column(
  //                 //   crossAxisAlignment: CrossAxisAlignment.start,
  //                 //   children: comments.map((comment) => Text(comment)).toList(),
  //                 // );
  //                 return Container(
  //                   child:Text(
  //                     comments as String
  //                   )
  //                 );
  //               },
  //             ),
  //           ),
  //           Form(
  //             child: Row(
  //               children: [
  //                 TextFormField(
  //                   controller: _commentController,
  //                   decoration: InputDecoration(
  //                     border:OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(15)
  //                     )
  //                   ),
  //                 ),
  //                 IconButton(
  //                     onPressed: () {
  //                       if(_commentController.text.isNotEmpty){
  //                         PostController().addComment(widget.postId, _commentController.text);
  //                       }
  //                       _commentController.clear();
  //                     },
  //                     icon: const Icon(Icons.send))
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //     duration: const Duration(minutes: 2),
  //   );
  //
  //   // Display the SnackBar
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
  // void showToast(message) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       gravity: ToastGravity.SNACKBAR,
  //       backgroundColor: Colors.grey);
  // }
}
